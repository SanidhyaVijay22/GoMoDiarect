import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentPhoneNumber;
  final VoidCallback refreshUserData; // Define the callback

  EditProfilePage({
    required this.currentName,
    required this.currentPhoneNumber,
    required this.refreshUserData, // Pass the callback
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneNumberController =
        TextEditingController(text: widget.currentPhoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    String newName = _nameController.text;
    String newPhoneNumber = _phoneNumberController.text;

    Map<String, dynamic> updatedInfo = {
      'username': newName,
      'phone': newPhoneNumber,
    };

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .set(updatedInfo, SetOptions(merge: true));

      Navigator.pop(context, updatedInfo);
      widget.refreshUserData(); // Call the callback to refresh the profile page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.deepPurple,
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
          ],
        ),
      ),
    );
  }
}
