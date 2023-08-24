import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gomodiarect/screens/profile_page.dart';
import 'package:gomodiarect/screens/settings_screen.dart';
import 'package:gomodiarect/screens/welcome_screen.dart';
import 'package:gomodiarect/screens/profile_page.dart';

class AppointmentScreen extends StatelessWidget {
  List imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

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
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/doctor1.jpg'),
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 15),
                        Container(
                          height: 600,
                          width: double.infinity,
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(children: [
                            ListTile(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ProfileApp(),
                                //   ),
                                // );
                              },
                              leading: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  CupertinoIcons.person,
                                  color: Colors.blue,
                                  size: 35,
                                ),
                              ),
                              title: Text(
                                "Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                            SizedBox(height: 20),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Settings(),
                                    ));
                              },
                              leading: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.green,
                                  size: 35,
                                ),
                              ),
                              title: Text(
                                "General",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                            Divider(height: 180),
                            ListTile(
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
                          ]),
                        ),
                      ]),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
