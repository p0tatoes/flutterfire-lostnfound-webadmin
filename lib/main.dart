import 'package:firebase_core/firebase_core.dart';
import 'package:lostnfound_webadmin/providers/auth.provider.dart';
import 'package:lostnfound_webadmin/providers/items.provider.dart';
import 'package:lostnfound_webadmin/views/admin_dashboard.view.dart';
import 'package:lostnfound_webadmin/views/item.view.dart';
import 'package:lostnfound_webadmin/views/login.view.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemsProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: "Campus Lost-n-found",
      initialRoute: AuthProvider.user == null ? "/login" : "/dashboard",
      routes: {
        "/login": (context) => const LoginView(),
        "/dashboard": (context) => const AdminDashboardView(),
        "/item": (context) => const ItemView(),
      },
    );
  }
}
