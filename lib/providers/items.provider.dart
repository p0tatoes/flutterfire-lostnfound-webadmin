import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:lostnfound_webadmin/models/items.model.dart';

class ItemsProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

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

    //? Old fetching; sorted by time found
    // final itemSnapshot =
    //     await _db.collection("items").orderBy("time_found").get();

    // sort by "claimed" status
    final itemSnapshot = await _db.collection("items").orderBy("claimed").get();

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

  Future<bool> addItem(
      {required String name,
      required String category,
      required String description,
      required String locationFound,
      required String timeFoundString,
      List<Uint8List>? images}) async {
    List<String> imageURLs = [];

    //convert time_found into a DateTime instance
    final timeFound = DateTime.parse(timeFoundString);

    final data = {
      "name": name,
      "category": category,
      "description": description,
      "location_found": locationFound,
      "time_found": Timestamp.fromDate(timeFound),
      "claimed": false,
      "image": [],
    };

    try {
      // add data
      final dataSnapshot = await _db.collection("items").add(data);

      /**
       * Upload images and update "image" field to add image urls
       */
      if (category != "Valuables" && images != null && images.isNotEmpty) {
        final storageRef = _storage.ref();

        for (var index = 0; index < images.length; index++) {
          final fileName = "${dataSnapshot.id}-${index + 1}";
          final imageRef = storageRef.child(fileName);
          final uploadTask = await imageRef.putData(images[index]);

          if (uploadTask.state == TaskState.success) {
            String imageURL = await imageRef.getDownloadURL();
            imageURLs.add(imageURL);
          }
        }
      }

      await _db
          .collection("items")
          .doc(dataSnapshot.id)
          .update({"image": imageURLs});

      // refresh items list after adding new item
      clearItems();
      getAllItems();

      notifyListeners();

      return true;
    } catch (e) {
      print("Failed to upload\n\n$e");
      return false;
    }
  }

  Future<bool> updateStatus({required String id}) async {
    try {
      final itemRef = _db.collection("items").doc(id);
      final itemSnapshot = await itemRef.get();
      final bool isClaimed = itemSnapshot.get("claimed");

      await itemRef.update({"claimed": !isClaimed});

      // refresh items list after adding new item
      clearItems();
      getAllItems();

      notifyListeners();

      return true;
    } catch (e) {
      print("Failed to upload\n\n$e");
      return false;
    }
  }
}
