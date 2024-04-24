import 'package:flutter/material.dart';
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
      return SizedBox.expand(
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
          final String name = itemsJSON["name"];
          // final String description = itemsJSON["description"];
          final String category = itemsJSON["category"];
          final String locationFound = itemsJSON["location_found"];
          final String timeFound = itemsJSON["time_found"];
          final List<dynamic>? image = itemsJSON["image"];
          final bool claimed = itemsJSON["claimed"];

          return GridTile(
            child: ItemCard(
              name: name,
              category: category,
              // description: description,
              locationFound: locationFound,
              timeFound: timeFound,
              claimed: claimed,
              image: image,
            ),
          );
        },
      ),
    );
  }
}
