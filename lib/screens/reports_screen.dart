import 'package:firebase_auth/firebase_auth.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> _showImageDialog(String imageUrl) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the dialog when tapped
            },
            child: Image.network(imageUrl),
          ),
        );
      },
    );
  }

  Future<void> fetchImageUrls() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      isLoading = true; // Set loading to true while fetching
    });

    ListResult result = await FirebaseStorage.instance
        .ref(
            'user_images/${user.email}') // Replace 'images' with the folder name
        .listAll();

    List<String> urls = [];
    List<DateTime> uploadTimes = [];

    await Future.wait(result.items.map((ref) async {
      final metadata = await ref.getMetadata();
      final uploadTime = metadata.timeCreated ?? DateTime.now();

      urls.add(await ref.getDownloadURL());
      uploadTimes.add(uploadTime);
    }));

    setState(() {
      imageUrls = urls;
      imageUploadTimes = uploadTimes;
      isLoading = false; // Set loading to false when fetching is done
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
          children: [
            if (isLoading) // Show loading indicator if isLoading is true
              Center(
                child: CircularProgressIndicator(),
              ),
            if (!isLoading && imageUrls.isEmpty) // Show empty message
              Center(
                child: Text("No images available."),
              ),
            ...List.generate(imageUrls.length, (index) {
              final imageUrl = imageUrls[index];
              final uploadTime = imageUploadTimes[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
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
                        leading: GestureDetector(
                          onTap: () => _showImageDialog(imageUrl),
                          child: Image.network(imageUrl),
                        ),
                        title: Text(
                          "Image $index",
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
          ],
        ),
      ),
    );
  }
}
