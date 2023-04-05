import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../get_started.dart';
import 'signin_screen.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () {
        FirebaseAuth.instance.signOut().then((value) {
          print("Signed Out");

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyStatefulWidget()));
        });
      },
    );
  }
}
