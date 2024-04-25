import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/models/items.model.dart';
import 'package:lostnfound_webadmin/providers/auth.provider.dart';
import 'package:lostnfound_webadmin/providers/items.provider.dart';
import 'package:lostnfound_webadmin/widgets/item_card.dart';
import 'package:provider/provider.dart';

AuthProvider auth = AuthProvider();

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  late ItemsProvider _itemsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
    _itemsProvider.getAllItems();

    //? Debugging
    // print("retrieved items in init state");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _itemsProvider.clearItems();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemsProvider = context.watch<ItemsProvider>();
    final items = itemsProvider.items;
    final isFetching = itemsProvider.isFetching;

    // show loading indicator if items are still fetching
    if (isFetching) {
      return const SizedBox(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    }
    if (items == null || items.isEmpty) {
      return const SizedBox.expand(
        child: Center(
          child: Text("No Items :("),
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          Container(
            color: Colors.blue.shade900,
            width: 300.0,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Image.asset("assets/logo-addu-text.jpg"),
                      Text("Welcome, ${AuthProvider.user?.displayName}",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text("Dashboard",
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.home_sharp, color: Colors.white),
                  onTap: () async {},
                ),
                ListTile(
                  title: const Text("Profile",
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.person, color: Colors.white),
                  onTap: () async {},
                ),
                ListTile(
                  title: const Text("Sign Out",
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.logout, color: Colors.white),
                  onTap: () async {
                    await auth.googleSignOut();

                    if (AuthProvider.user == null) {
                      Navigator.popAndPushNamed(context, "/login");
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: itemsProvider.items?.length,
              padding: const EdgeInsets.all(30.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0),
              itemBuilder: (context, index) {
                final itemsJSON = items[index].toJSON();
                final String id = itemsJSON["id"];
                final String name = itemsJSON["name"];
                final String description = itemsJSON["description"];
                final String category = itemsJSON["category"];
                final String locationFound = itemsJSON["location_found"];
                final Timestamp timeFound = itemsJSON["time_found"];
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
          ),
        ],
      ),
    );
  }
}
