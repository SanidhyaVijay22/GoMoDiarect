import 'package:flutter/material.dart';
import 'package:gomodiarect/screens/welcome_screen.dart';

import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Sanidhya Vijay";
  String phoneNumber = "9010112211";
  String emailAddress = "sanidhya@gmail.com";

  void _editProfile() async {
    Map<String, String> updatedInfo = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentName: name,
          currentPhoneNumber: phoneNumber,
          currentEmailAddress: emailAddress,
        ),
      ),
    );

    if (updatedInfo != null) {
      setState(() {
        name = updatedInfo['name']!;
        phoneNumber = updatedInfo['phoneNumber']!;
        emailAddress = updatedInfo['emailAddress']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("H O M E"),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Color(0xFF7165D6),
        body: Center(
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
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              emailAddress,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
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
                      )),
                ),
              ),
            ),
            SizedBox(height: 80),
            SingleChildScrollView(
                child: Container(
              height: 217.9,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 45,
                left: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ));
                },
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Colors.orange,
                    size: 35,
                  ),
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            )),
          ],
        )),
      ),
    );
  }
}
