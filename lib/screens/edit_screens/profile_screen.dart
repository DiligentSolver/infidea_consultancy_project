import 'package:flutter/material.dart';
import '../../core/constants/App_colors.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with existing data
    _nameController.text = "User Name";
    _jobTitleController.text = "Job Title";
    _salaryController.text = "50000";
    _locationController.text = "Location";
    _contactInfoController.text = "Contact Info";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _salaryController.dispose();
    _locationController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save profile data
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated')),
                );
                Navigator.pop(context);
              }
            },
            child: Text('SAVE', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 18,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                            onPressed: () {
                              // Add image picker functionality
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  validator: (value) => value!.isEmpty ? 'Name is required' : null,
                ),
                _buildTextField(
                  controller: _jobTitleController,
                  label: 'Job Title',
                  validator: (value) => value!.isEmpty ? 'Job title is required' : null,
                ),
                _buildTextField(
                  controller: _salaryController,
                  label: 'Salary',
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: _locationController,
                  label: 'Location',
                ),
                _buildTextField(
                  controller: _contactInfoController,
                  label: 'Contact Info',
                  validator: (value) => value!.isEmpty ? 'Contact info is required' : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        validator: validator,
      ),
    );
  }
}