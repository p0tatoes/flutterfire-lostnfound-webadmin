import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/services/auth.service.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        onPressed: () async {
          // TODO: Fix logout functionality
          // AuthService.googleSignout();
        },
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            backgroundColor: Colors
                .blue.shade900, // This is the background color of the button
            foregroundColor: Colors.blue.shade100),
        child: const Text("Sign in with AdDU Google"),
      )
    ]);
  }
}
