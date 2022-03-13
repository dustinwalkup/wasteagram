class FoodWasteEntryDTO {
  late String date;
  late String imgUrl;
  late int numOfItems;
  late String latitude;
  late String longitude;

  @override
  String toString() =>
      'Date: $date, imgUrl: $imgUrl, NumOfItems: $numOfItems, Latitude: $latitude, Longitude: $longitude';
}
