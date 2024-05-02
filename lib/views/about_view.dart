import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/providers/auth.provider.dart';

AuthProvider auth = AuthProvider();

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
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
                      Image.asset("assets/University-Seal.png",
                          height: 86, width: 86),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Welcome, ${AuthProvider.user?.displayName}",
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title:
                      const Text("Home", style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.home, color: Colors.white),
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/dashboard");
                  },
                ),
                ListTile(
                  title: const Text("Add Item",
                      style: TextStyle(color: Colors.white)),
                  leading:
                      const Icon(Icons.create_rounded, color: Colors.white),
                  onTap: () {
                    Navigator.pushNamed(context, "/create");
                  },
                ),
                Container(
                  color: Colors.blue.shade700,
                  child: const ListTile(
                    title: Text("About App",
                        style: TextStyle(color: Colors.white)),
                    leading: Icon(Icons.info_outline_rounded,
                        color: Colors.white),
                    onTap: null,
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: ListTile(
                    title: const Text("Sign Out",
                        style: TextStyle(color: Colors.white)),
                    leading: const Icon(Icons.logout, color: Colors.white),
                    onTap: () async {
                      await auth.googleSignOut();

                      if (AuthProvider.user == null) {
                        Navigator.popAndPushNamed(context, "/login");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    const Text('About CampusFind',
                        style: TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold)),
                    Image.asset('assets/campusfind-blue-logo.png',
                        width: 512, height: 512),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 32.0, right: 32, top: 10),
                      child: Text(
                          'CampusFind is an application that allows AdDU Students to locate and find any items they may have lost inside the campus. OSA Admins may list down any valuables that are reported to their office as lost and found, while users may claim their lost items in the office,',
                          style: TextStyle(color: Colors.black, fontSize: 24)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
