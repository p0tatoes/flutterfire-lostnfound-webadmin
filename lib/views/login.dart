import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound_webadmin/services/auth.service.dart';
import 'authState.dart';
/* final authStateChangeProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
}); */

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<User?> authStateChanges =
        ref.watch(authStateChangeProvider);
    authStateChanges.whenData(
      (user) async {
        if (user != null) {
          await Navigator.pushNamed(
            context,
            "/dashboard",
          );
        }
      },
    );

    return const Login();
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Image.asset(
              "assets/bg-ccfc.jpg",
              fit: BoxFit.fill,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
          ),
          SizedBox(
            width: 500.0,
            height: 350,
            child: Card(
              // color: Colors.white,
              surfaceTintColor: Colors.white,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/logo-addu-text.jpg"),
                    const Text(
                      "ADMIN",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight
                              .w900), // TODO: change font style to Trajan
                    ),
                    const Text(
                      "Campus Lost-and-Found",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight
                              .w900), // TODO: change font style to Trajan
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await AuthService.googleSignin();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          backgroundColor: Colors.blue
                              .shade900, // This is the background color of the button
                          foregroundColor: Colors.blue.shade100),
                      child: const Text("Sign in with AdDU Google"),
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
