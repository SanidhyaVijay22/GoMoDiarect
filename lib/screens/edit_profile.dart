import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentPhoneNumber;
  final String currentEmailAddress;

  EditProfilePage({
    required this.currentName,
    required this.currentPhoneNumber,
    required this.currentEmailAddress,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailAddressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneNumberController =
        TextEditingController(text: widget.currentPhoneNumber);
    _emailAddressController =
        TextEditingController(text: widget.currentEmailAddress);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailAddressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    Map<String, String> updatedInfo = {
      'name': _nameController.text,
      'phoneNumber': _phoneNumberController.text,
      'emailAddress': _emailAddressController.text,
    };
    Navigator.pop(context, updatedInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: _saveChanges,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailAddressController,
              decoration: InputDecoration(labelText: "Email Address"),
            ),
          ],
        ),
      ),
    );
  }
}
