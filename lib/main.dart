import 'screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/main_page.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDBqnAH8buJ845Cbad3uKXRRACuf3Ycufk',
        appId: '1:480297090611:android:862ec2908a358abb9a6d46',
        messagingSenderId: '480297090611',
        projectId: 'eaapp-72d1f')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Authentication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: const Color.fromRGBO(110, 52, 235, 100),
    ),
      home: const MainPage(),
      initialRoute: '/',
      routes: {
        'register': (context) => const RegisterPage(),
        'profile': (context) => const ProfilePage(),
        'login': (context) => const LoginPage(),
      },
    );
  }
}