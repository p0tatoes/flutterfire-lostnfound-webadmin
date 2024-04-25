import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/models/items.model.dart';

class ItemsProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<ItemsModel>? items = [];
  bool isFetching = false;

  Future<void> getAllItems() async {
    /**
     * retrieve items from oldest to newest based on "time_found" field 
     * 
     * set "loading" state to true
     */
    isFetching = true;
    notifyListeners();

    final itemSnapshot =
        await _db.collection("items").orderBy("time_found").get();

    for (var item in itemSnapshot.docs) {
      final data = item.data();

      String id = item.id;
      String name = data["name"];
      String description = data["description"];
      String category = data["category"];
      String locationFound = data["location_found"];
      Timestamp timeFound = data["time_found"];
      List<dynamic>? image = data["image"];
      bool claimed = data["claimed"];

      if (image == null) {
        // Special Items (with category of jewelries or money)
        items?.add(ItemsModel(
            id: id,
            name: name,
            description: description,
            category: category,
            locationFound: locationFound,
            timeFound: timeFound,
            claimed: claimed));

        //? Debugging
        // print("special items");
        // print({
        //   "id": id,
        //   "name": name,
        //   "description": description,
        //   "category": category,
        //   "locationFound": locationFound,
        //   "timeFound": timeFound,
        //   "claimed": claimed
        // });
      } else {
        // Regular Items
        items?.add(ItemsModel(
            id: id,
            name: name,
            description: description,
            category: category,
            locationFound: locationFound,
            timeFound: timeFound,
            image: image,
            claimed: claimed));

        //? Debugging
        // print("regular items");
        // print({
        //   "id": id,
        //   "name": name,
        //   "description": description,
        //   "category": category,
        //   "locationFound": locationFound,
        //   "timeFound": timeFound,
        //   "image": image,
        //   "claimed": claimed
        // });
        // print("$image\n");
      }
    }

    isFetching = false;
    notifyListeners();
  }

  Future<void> clearItems() async {
    items?.clear();
    notifyListeners();
  }
}
