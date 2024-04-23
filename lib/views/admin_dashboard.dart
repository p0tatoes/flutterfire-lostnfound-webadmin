import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/services/auth.service.dart';

AuthService auth = AuthService();

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  Widget build(BuildContext context) {
    print("is logged in (dashboard)? ${AuthService.user != null}");

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AuthService.user?.displayName ?? "No name"),
          const SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            onPressed: () async {
              // TODO: Fix not getting a prompt to select an account after logging out.
              try {
                await auth.googleSignOut();

                if (AuthService.user == null) {
                  //? Debugging
                  // print("is logged out? ${AuthService.user == null}");

                  Navigator.popAndPushNamed(context, "/login");
                }
              } catch (e) {
                // uhhh
              }
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                backgroundColor: Colors.blue
                    .shade900, // This is the background color of the button
                foregroundColor: Colors.blue.shade100),
            child: const Text("Sign out"),
          )
        ]);
  }
}
