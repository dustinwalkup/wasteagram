import 'package:flutter/material.dart';

import '../screens/new_waste_screen.dart';

FloatingActionButton cameraFab(BuildContext context) {
  return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewWasteScreen()));
      },
      child: const Icon(Icons.camera_alt));
}
