import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/models/items.model.dart';
import 'package:lostnfound_webadmin/providers/auth.provider.dart';
import 'package:lostnfound_webadmin/providers/items.provider.dart';
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

    // show loading indicator if items are still fetching
    if (itemsProvider.isFetching) return const CircularProgressIndicator();

    return Scaffold(body: Text("${itemsProvider.items}"));
  }
}
