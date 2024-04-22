import "package:cloud_firestore/cloud_firestore.dart";

class ItemsModel {
  final String name;
  final String description;
  final String category;
  final String locationFound; // location_found
  final Timestamp timeFound; // time_found
  final List<String>? image; // not required if item category is jewelry or cash
  final bool claimed;

  ItemsModel(
      {required this.name,
      required this.description,
      required this.category,
      required this.locationFound,
      required this.timeFound,
      this.image,
      required this.claimed});
}
