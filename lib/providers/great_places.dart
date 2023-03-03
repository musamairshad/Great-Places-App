// We are managing all the great places we collected.

import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import 'dart:io';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null, // location field is nullable.
    );
    _items.add(newPlace);
    notifyListeners();
    // The keys of Map must matched the fields of the table.
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path, // because we want to store path in the db.
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((item) => Place(
              id: item["id"],
              title: item["title"],
              image: File(item["image"]),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}