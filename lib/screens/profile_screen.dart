import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences _prefs;
  bool _isLoading = true;
  bool _isEditing = false;
  
  // User data
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _bio = '';
  
  // Controllers for editing
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bioController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
  
  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });
    
    _prefs = await SharedPreferences.getInstance();
    
    setState(() {
      _firstName = _prefs.getString('firstName') ?? '';
      _lastName = _prefs.getString('lastName') ?? '';
      _email = _prefs.getString('email') ?? '';
      _bio = _prefs.getString('bio') ?? 'No bio added yet.';
      
      _firstNameController.text = _firstName;
      _lastNameController.text = _lastName;
      _bioController.text = _bio;
      
      _isLoading = false;
    });
  }
  
  Future<void> _saveUserData() async {
    setState(() {
      _isLoading = true;
    });
    
    await _prefs.setString('firstName', _firstNameController.text);
    await _prefs.setString('lastName', _lastNameController.text);
    await _prefs.setString('bio', _bioController.text);
    
    await _loadUserData();
    
    setState(() {
      _isEditing = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully'))
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveUserData();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: _isLoading 
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Profile Avatar
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Theme.of(context).primaryColorLight,
                          backgroundImage: NetworkImage(
                            'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&s=200',
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Display name
                  Text(
                    _isEditing ? 'Edit Profile' : '$_firstName $_lastName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  if (!_isEditing) 
                    Text(
                      _email,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  
                  SizedBox(height: 30),
                  
                  // Profile Info Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _isEditing 
                            ? _buildEditForm() 
                            : _buildProfileInfo(),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Statistics Card
                  if (!_isEditing)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Activity',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              _buildStatRow(Icons.bookmark, 'Saved Articles', '${_prefs.getString('saved_articles')?.isNotEmpty == true ? json.decode(_prefs.getString('saved_articles')!).length : 0}'),
                              Divider(),
                              _buildStatRow(Icons.visibility, 'Articles Read', '0'),
                              Divider(),
                              _buildStatRow(Icons.comment, 'Comments', '0'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  SizedBox(height: 30),
                  
                  // Logout button
                  if (!_isEditing)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Implement logout functionality
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
  
  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('First Name', _firstName),
        Divider(),
        _buildInfoRow('Last Name', _lastName),
        Divider(),
        _buildInfoRow('Email', _email),
        Divider(),
        _buildInfoRow('Bio', _bio),
      ],
    );
  }
  
  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildTextField('First Name', _firstNameController),
        SizedBox(height: 16),
        _buildTextField('Last Name', _lastNameController),
        SizedBox(height: 16),
        Text(
          'Email: $_email',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        _buildTextField('Bio', _bioController, maxLines: 3),
      ],
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatRow(IconData icon, String label, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 16)),
          Spacer(),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}