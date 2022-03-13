import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:location/location.dart';
import '../models/food_waste_entry_dto.dart';

class WastedFoodForm extends StatefulWidget {
  const WastedFoodForm({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<WastedFoodForm> createState() => _WastedFoodFormState();
}

class _WastedFoodFormState extends State<WastedFoodForm> {
  final formKey = GlobalKey<FormState>();
  final wasteEntryFields = FoodWasteEntryDTO();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    late LocationData locationData;
    locationData = await locationService.getLocation();
    wasteEntryFields.latitude = locationData.latitude.toString();
    wasteEntryFields.longitude = locationData.longitude.toString();
    wasteEntryFields.imgUrl = widget.url;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(key: formKey, child: formFields(context)));
  }

  Widget formFields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [itemQuantityField(context), uploadButton(context)],
    );
  }

  Widget itemQuantityField(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Semantics(
          child: TextFormField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(hintText: 'Number of Wasted Items'),
              style: Theme.of(context).textTheme.titleMedium,
              onSaved: (value) {
                wasteEntryFields.numOfItems = int.parse(value!);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a quantity';
                } else {
                  return null;
                }
              }),
          onTapHint: 'Enter quantity',
          textField: true,
        ));
  }

  Widget uploadButton(BuildContext context) => ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          FirebaseFirestore.instance.collection('posts').add({
            'date': DateTime.now(),
            'imgUrl': wasteEntryFields.imgUrl,
            'longitude': wasteEntryFields.longitude,
            'latitude': wasteEntryFields.latitude,
            'numOfItems': wasteEntryFields.numOfItems
          });
          Navigator.of(context).pop();
        }
      },
      child: Semantics(
        child: const Icon(Icons.cloud_upload_outlined),
        button: true,
        hint: 'Upload photo',
      ));
}
