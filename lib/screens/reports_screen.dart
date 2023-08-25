import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Reports extends StatefulWidget {
  Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    ListResult result = await FirebaseStorage.instance
        .ref('images') // Replace 'images' with your Firebase Storage folder
        .listAll();

    List<String> urls = await Future.wait(result.items.map((ref) async {
      return await ref.getDownloadURL();
    }));

    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("R E P O R T S"),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: imageUrls
              .map((imageUrl) => Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.deepPurple[300],
                    shadowColor: Colors.blueGrey,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 30.0, top: 30.0, bottom: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Image.network(
                                imageUrl), // Use Image.network to fetch images from the URL
                            title: Text(
                              "Level ${imageUrls.indexOf(imageUrl)}",
                              style: TextStyle(fontSize: 21),
                            ),
                            subtitle: Text(
                              'Date: ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
