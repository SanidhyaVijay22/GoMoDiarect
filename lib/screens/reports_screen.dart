import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("R E P O R T S"),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
        ),
        body: Column(children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.deepPurple[200],
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 30.0, top: 30.0, bottom: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:
                        Image.asset('images/iris1.jpeg'), // leading: Icon (
                    //     Icons.album,
                    //     color: Colors.cyan,
                    //     size: 45
                    title: Text(
                      "Level 0",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text('22/7/2001'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.deepPurple[200],
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 30.0, top: 30.0, bottom: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:
                        Image.asset('images/iris1.jpeg'), // leading: Icon (
                    //     Icons.album,
                    //     color: Colors.cyan,
                    //     size: 45
                    title: Text(
                      "Level 1",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text('23/7/2001'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.deepPurple[200],
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 30.0, top: 30.0, bottom: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:
                        Image.asset('images/iris1.jpeg'), // leading: Icon (
                    //     Icons.album,
                    //     color: Colors.cyan,
                    //     size: 45
                    title: Text(
                      "Level 2",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text('24/7/2001'),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.deepPurple[200],
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 30.0, top: 30.0, bottom: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:
                        Image.asset('images/iris1.jpeg'), // leading: Icon (
                    //     Icons.album,
                    //     color: Colors.cyan,
                    //     size: 45
                    title: Text(
                      "Level 3",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text('25/7/2001'),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
