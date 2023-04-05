import 'package:flutter/material.dart';

import 'screens/signin_screen.dart';
import 'screens/signup_screen.dart';
import 'utils/color_utils.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: ListView(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 50,
  //         ),
  //         Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(10),
  //           child: const Text(
  //             'Hi There, Welcome to',
  //             style: TextStyle(fontSize: 20),
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(10),
  //           child: const Text(
  //             'Beam Load Analyzer',
  //             style: TextStyle(
  //                 color: Colors.indigo,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 50),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 30,
  //         ),
  //         Container(
  //           child: Image.asset('assets/images/trial1.jpg'),
  //           height: 300,
  //         ),
  //         SizedBox(
  //           height: 50,
  //         ),
  //         Container(
  //           height: 40,
  //           padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               primary: Colors.indigo,
  //             ),
  //             child: const Text('Get Started'),
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => const SignUpScreen()));
  //             },
  //           ),
  //         ),
  //         SizedBox(
  //           height: 50,
  //         ),
  //         Row(
  //           children: <Widget>[
  //             const Text(
  //               'Already have an account?',
  //               style: TextStyle(fontSize: 15),
  //             ),
  //             TextButton(
  //               child: const Text('Sign in',
  //                   style: TextStyle(color: Colors.indigo, fontSize: 15)),
  //               onPressed: () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => const SignInScreen()));
  //                 //signup screen
  //               },
  //             )
  //           ],
  //           mainAxisAlignment: MainAxisAlignment.center,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("757BBE"),
            hexStringToColor("7F4E7F"),
            hexStringToColor("420420")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Hi There, Welcome to',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Beam Load Analyzer',
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w500,
                        fontSize: 50),
                    textAlign: TextAlign.center,
                  )),
              Image.asset("assets/images/logo.jpg",
                  fit: BoxFit.fitWidth, height: 240, width: 240),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black38, fixedSize: Size(200, 5)),
                child: const Text('Get Started',
                    style: TextStyle(color: Colors.white70)),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen())),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Alreaady have an account?',
                      style: TextStyle(color: Colors.white70)),
                  TextButton(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () =>
                        //signup screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen())),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
