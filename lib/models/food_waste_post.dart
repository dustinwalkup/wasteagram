class FoodWasteEntryFields {
  String imgUrl = 'imgUrl';
  String latitude = 'latitude';
  String longitude = 'longitude';
  String numOfItems = 'numOfItems';
  String date = 'date';
}

class FoodWasteEntry {
  final String imgUrl;
  final String latitude;
  final String longitude;
  final int numOfItems;
  final String date;

  const FoodWasteEntry({
    required this.imgUrl,
    required this.latitude,
    required this.longitude,
    required this.numOfItems,
    required this.date,
  });

  String get getimgUrl => imgUrl;
  String get getLatitude => latitude;
  String get getLongitude => longitude;
  int get getNumOfItems => numOfItems;
  String get getDate => date;

  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'latitude': latitude,
      'longitude': longitude,
      'numOfItems': numOfItems,
      'date': date,
    };
  }

  @override
  String toString() {
    return '{imgUrl: $imgUrl, latitude: $latitude, longitude: $longitude, numOfItems: $numOfItems, date: $date}';
  }
}
