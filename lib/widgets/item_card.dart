import "package:flutter/material.dart";

class ItemCard extends StatelessWidget {
  final String name;
  final String category;
  final bool claimed;
  final List<dynamic>? image;

  const ItemCard({
    super.key,
    required this.name,
    required this.category,
    required this.claimed,
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
            height: 170.0,
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
                Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "${category[0].toUpperCase()}${category.substring(1)}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(
                      width: 3.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: claimed ? Colors.green : Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        claimed ? "Claimed" : "To be claimed",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                // Text(
                //   "${category[0].toUpperCase()}${category.substring(1)}",
                //   style: TextStyle(color: Colors.white),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onPressed() {}
}
