import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound_webadmin/services/auth.service.dart';
import 'package:lostnfound_webadmin/views/authState.dart';

class AdminDashboardView extends ConsumerStatefulWidget {
  const AdminDashboardView({super.key});

  @override
  ConsumerState<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends ConsumerState<AdminDashboardView> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<User?> authStateChanges =
        ref.watch(authStateChangeProvider);
    print('change');
    print(authStateChanges);
    authStateChanges.whenData(
      (user) async {
        if (user == null) {
          print(user);
          await Navigator.pushNamed(context, '/login');
        }
      },
    );
    return Column(children: [
      ElevatedButton(
        onPressed: () async {
          AuthService.googleSignout();
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
