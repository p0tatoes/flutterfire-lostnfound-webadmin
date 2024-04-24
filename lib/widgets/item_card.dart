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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: image == null
                ? const Placeholder(
                    color: Colors.red,
                  )
                : Image.network(
                    image?[0],
                    fit: BoxFit.fill,
                  ),
          ),
          Text(name.toUpperCase()),
          Text(category),
        ],
      ),
    );
  }
}
