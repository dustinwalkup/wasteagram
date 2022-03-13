import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Post created from constructor should have appropiate property values',
      () {
    final date = DateTime.now().toString();
    const imgUrl = 'URL_';
    const latitude = '123';
    const longitude = '456';
    const numOfItems = 5;

    final post = FoodWasteEntry(
        date: date,
        imgUrl: imgUrl,
        latitude: latitude,
        longitude: longitude,
        numOfItems: numOfItems);

    expect(post.date, date);
    expect(post.imgUrl, imgUrl);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
    expect(post.numOfItems, numOfItems);
  });

  test('Getter functions should return appropiate values', () {
    final date = DateTime.now().toString();
    const imgUrl = 'URL_';
    const latitude = '123';
    const longitude = '456';
    const numOfItems = 5;

    final post = FoodWasteEntry(
        date: date,
        imgUrl: imgUrl,
        latitude: latitude,
        longitude: longitude,
        numOfItems: numOfItems);

    expect(post.getDate, date);
    expect(post.getimgUrl, imgUrl);
    expect(post.getLatitude, latitude);
    expect(post.getLongitude, longitude);
    expect(post.getNumOfItems, numOfItems);
  });
}
