import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lostnfound_webadmin/providers/auth.provider.dart';

/* final authStateChangeProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
}); */

AuthProvider auth = AuthProvider();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            height: 500,
            child: Card(
              // color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/logo-addu-text.jpg"),
                    Image.asset('assets/campusfind-blue-logo.png',
                        width: 256, height: 256),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await auth.googleSignIn();

                            if (AuthProvider.user != null) {
                              //? Debugging
                              // print("is logged in? ${AuthService.user != null}");
                              // print("user: ${AuthService.user?.displayName}");

                              Navigator.pushNamed(context, "/dashboard");
                            }
                          } catch (e) {
                            // uhhhh
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            backgroundColor: Colors.blue
                                .shade900, // This is the background color of the button
                            foregroundColor: Colors.blue.shade100),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Image.asset('assets/google_icon.png',
                                    width: 28, height: 28),
                              ),
                              Text(
                                "Sign in with AdDU Google",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ])),
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
