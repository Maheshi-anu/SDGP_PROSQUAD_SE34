import 'package:flutter/material.dart';

import 'main.dart';

class HelpPage extends StatelessWidget {
  final List<String> instructions = const [
    "Capture the image clearly and in correct orientation.",
    "Cage your all input values in blue colour.",
    "Write letters in black colour.",
    "You need to use platignums for your drawings and writings.",
    "The force values should be in Newtons (N) and the lengths should be in millimeters (mm).",
    "This application only allows for simply supported beams with vertical point loads, and it does not accept UDL or moments or angled forces.",
    "This prototype generates shear force and bending moment diagrams for each case.",
    "The sign convention considers the upward direction as positive and the downward direction as negative.",
    "Images must be captured or uploaded in an upright position.",
    "The application will verify the inputs in the second UI, and the calculations will depend on these confirmed values.",
    "Decimal points are not allowed in the inputs",
    "To indicate force, use the notation [+ or -][magnitude of the force][,][horizontal distance to the acting point by considering the leftmost corner of the beam as 0]. For example, +10,5000 means an upward-directed force with a magnitude of 10 and a horizontal distance of 5 meters from the acting point.",
  ];

  Widget _buildImageButton({
    required String imagePath,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Material();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Help",
      //   ),
      //   backgroundColor: Colors.indigo,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Welcome to",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // SizedBox(height: 20),
            Text(
              "Help!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            Image(
              image: AssetImage("assets/images/customer_care.png"),
              height: 150,
            ),
            SizedBox(height: 70),
            Text(
              "Please follow these instructions",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 340, // fixed height for the listview
              child: ListView.builder(
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text(instructions[index]),
                  );
                },
              ),
            ),

            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: "Beam Load Analyzer")));
              },
            ),
          ],
        ),
      ),
    );
  }
}
