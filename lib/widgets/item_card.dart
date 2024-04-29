import "package:flutter/material.dart";

class ItemCard extends StatelessWidget {
  final String name;
  final String category;
  final List<dynamic>? image;

  const ItemCard({
    super.key,
    required this.name,
    required this.category,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade900,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: image == null || image!.isEmpty
                ? Center(
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue.shade900),
                    ),
                  )
                : Image.network(
                    image?[0],
                    fit: BoxFit.fill,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                Text("${category[0].toUpperCase()}${category.substring(1)}",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onPressed() {}
}
