import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
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
                    color: Colors.indigo,
                    fontWeight: FontWeight.w500,
                    fontSize: 50),
                textAlign: TextAlign.center,
              )),
          Container(
            child: Image.asset('assets/images/trial1.jpg'),
            height: 190,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
              ),
              child: const Text('Get Started'),
              onPressed: () {},
            ),
          ),
          Row(
            children: <Widget>[
              const Text('Already have an account?'),
              TextButton(
                child: const Text('Sign in',
                    style: TextStyle(color: Colors.indigo, fontSize: 15)),
                onPressed: () {
                  //signup screen
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
