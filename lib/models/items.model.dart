import "package:cloud_firestore/cloud_firestore.dart";

class ItemsModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String locationFound; // location_found
  final Timestamp timeFound; // time_found
  final List<dynamic>?
      image; // not required if item category is jewelry or cash
  final bool claimed;

  ItemsModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.locationFound,
      required this.timeFound,
      this.image,
      required this.claimed});

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category,
        "location_found": locationFound,
        "time_found": timeFound.toDate().toString(),
        "image": image,
        "claimed": claimed,
      };
}
