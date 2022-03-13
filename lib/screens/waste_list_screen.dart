import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../widgets/camera_fab.dart';
import 'waste_detail_screen.dart';

class WasteListScreen extends StatefulWidget {
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {
  final Stream<QuerySnapshot> _postsStream = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date', descending: true)
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wasteagram'),
          centerTitle: true,
        ),
        body: wasteList(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Semantics(
          child: cameraFab(context),
          button: true,
          onTapHint: 'Select an image',
        ));
  }

  Widget wasteList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _postsStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data?.docs[index];
                  final entry = FoodWasteEntry(
                      date: DateFormat.yMMMMEEEEd().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              post!['date'].seconds * 1000)),
                      latitude: post['latitude'],
                      imgUrl: post['imgUrl'],
                      longitude: post['longitude'],
                      numOfItems: post['numOfItems']);
                  return Semantics(
                    child: ListTile(
                        title: Text(entry.getDate),
                        trailing: Text(entry.getNumOfItems.toString(),
                            style: const TextStyle(fontSize: 24)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WasteDetailScreen(post: entry)));
                        }),
                    button: true,
                    onTapHint: 'View item detail',
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
