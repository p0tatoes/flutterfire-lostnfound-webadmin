import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/models/items.model.dart';
import 'package:lostnfound_webadmin/providers/auth.provider.dart';
import 'package:lostnfound_webadmin/providers/items.provider.dart';
import 'package:lostnfound_webadmin/widgets/item_card.dart';
import 'package:provider/provider.dart';

AuthProvider auth = AuthProvider();
ItemsProvider items = ItemsProvider();

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ItemsProvider>(context, listen: false).getAllItems();

    //? Debugging
    // print("retrieved items in init state");
  }

  @override
  Widget build(BuildContext context) {
    final itemsProvider = context.watch<ItemsProvider>();
    final items = itemsProvider.items;
    final isFetching = itemsProvider.isFetching;

    // show loading indicator if items are still fetching
    if (isFetching) return const CircularProgressIndicator();

    if (items == null || items.isEmpty) {
      return const SizedBox.expand(
        child: Center(
          child: Text("No text :("),
        ),
      );
    }

    return Scaffold(
      body: GridView.builder(
        itemCount: itemsProvider.items?.length,
        padding: const EdgeInsets.all(30.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
        itemBuilder: (context, index) {
          final itemsJSON = items[index].toJSON();
          final String id = itemsJSON["id"];
          final String name = itemsJSON["name"];
          final String description = itemsJSON["description"];
          final String category = itemsJSON["category"];
          final String locationFound = itemsJSON["location_found"];

          final Timestamp timeFound = itemsJSON["time_found"];
          final String strTimeFound = timeFound.toDate().toString();

          final List<dynamic>? image = itemsJSON["image"];
          final bool claimed = itemsJSON["claimed"];

          return GridTile(
            child: InkWell(
              onTap: () {
                // redirects to item details view with arguments containing item data
                Navigator.pushNamed(
                  context,
                  "/item",
                  arguments: ItemsModel(
                      id: id,
                      name: name,
                      description: description,
                      category: category,
                      locationFound: locationFound,
                      timeFound: timeFound,
                      image: image,
                      claimed: claimed),
                );
              },
              child: ItemCard(
                name: name,
                category: category,
                image: image,
              ),
            ),
          );
        },
      ),
    );
  }
}
