import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';

class WasteDetailScreen extends StatelessWidget {
  const WasteDetailScreen({Key? key, required this.post}) : super(key: key);

  final FoodWasteEntry post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wasteagram'),
          centerTitle: true,
        ),
        body: layout(post));
  }
}

Widget layout(post) {
  return Column(
    children: [
      const SizedBox(height: 50),
      Text('${post.getDate}', style: const TextStyle(fontSize: 30)),
      const SizedBox(height: 50),
      Semantics(
          child: Image.network(
            post.imgUrl,
            width: 600,
            height: 300,
          ),
          image: true,
          hint: 'Photo of food waste'),
      const SizedBox(height: 20),
      Text('${post.getNumOfItems} items', style: const TextStyle(fontSize: 30)),
      const SizedBox(height: 60),
      Text('Location (${post.getLatitude}, ${post.getLongitude})',
          style: const TextStyle(fontSize: 18))
    ],
  );
}
