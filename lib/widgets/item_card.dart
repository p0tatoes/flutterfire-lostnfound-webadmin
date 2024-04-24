import "package:flutter/material.dart";

class ItemCard extends StatelessWidget {
  final String name;
  final String category;
  // final String description;
  final String locationFound;
  final String timeFound;
  final List<dynamic>? image;
  final bool claimed;

  const ItemCard({
    super.key,
    required this.name,
    required this.category,
    // required this.description,
    required this.locationFound,
    required this.timeFound,
    this.image,
    required this.claimed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: image == null
                ? const Text("No image :(")
                : Image.network(
                    image?[0],
                    fit: BoxFit.fill,
                  ),
          ),
          Text(name.toUpperCase()),
          Text(category),
          Text(locationFound),
          Text(timeFound.toString()),
          // Text(description),
          Text(claimed ? "Claimed" : "Not claimed"),
        ],
      ),
    );
  }
}
