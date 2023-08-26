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
  List<DateTime> imageUploadTimes = [];
  List<int> levels = []; // Declare the levels list

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    ListResult result = await FirebaseStorage.instance
        .ref('images') // Replace 'images' with your Firebase Storage folder
        .listAll();

    List<String> urls = [];
    List<DateTime> uploadTimes = [];

    await Future.wait(result.items.map((ref) async {
      final metadata = await ref.getMetadata();
      final uploadTime = metadata.timeCreated ?? DateTime.now();

      urls.add(await ref.getDownloadURL());
      uploadTimes.add(uploadTime);
    }));

    List.generate(urls.length, (index) {
      final reversedIndex = urls.length - 1 - index;
      imageUrls.add(urls[reversedIndex]);
      imageUploadTimes.add(uploadTimes[reversedIndex]);
      levels.add(reversedIndex); // Assign levels in descending order
    });

    setState(() {});
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
          children: List.generate(imageUrls.length, (index) {
            final imageUrl = imageUrls[index];
            final uploadTime = imageUploadTimes[index];
            final level = levels[index];

            return Card(
              margin: EdgeInsets.all(10),
              color: Colors.deepPurple[300],
              shadowColor: Colors.blueGrey,
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30.0, top: 30.0, bottom: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(imageUrl),
                      title: Text(
                        "Level $level",
                        style: TextStyle(fontSize: 21),
                      ),
                      subtitle: Text(
                        'Uploaded on: ${DateFormat('dd-MM-yyyy HH:mm').format(uploadTime)}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
