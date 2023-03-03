import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation(
      {required this.latitude, required this.longitude, this.address});
}

// We don't want to listen to that model because the data won't really change.
// locations are like coordinates and a combination of latitude and longitude.
class Place {
  final String id; // unique id.
  final String title;
  final PlaceLocation? location;
  final File
      image; // for on device images we use File data type. each image is a file.
  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});
}