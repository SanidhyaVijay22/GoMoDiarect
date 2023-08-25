import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String phoneNumber = "";
  String emailAddress = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void refreshUserData() {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            name = data['username'] as String;
            phoneNumber = data['phone'] as String;
            emailAddress = data['UserEmail'] ??
                "Email not available"; // Use user.email here
          });
        }
      }
    }
  }

  void _editProfile() async {
    Map<String, String> updatedInfo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentName: name,
          currentPhoneNumber: phoneNumber,
          refreshUserData: refreshUserData, // Pass the callback function
        ),
      ),
    );

    if (updatedInfo != null) {
      setState(() {
        name = updatedInfo['username']!;
        phoneNumber = updatedInfo['phone']!;
        emailAddress = updatedInfo['UserEmail']!;
      });
    }
  }

  Future<void> updateUserDataInFirestore(
      Map<String, String> updatedInfo) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .update({
        'username': updatedInfo['username'],
        'phone': updatedInfo['phone'],
        // You can update other fields here as well
      });
    }
  }

  bool? appVerificationDisabledForTesting = true; // or false or null

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("P R O F I L E"),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("images/person.png"),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  emailAddress,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 300,
                  height: 60,
                  child: Material(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: _editProfile,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
