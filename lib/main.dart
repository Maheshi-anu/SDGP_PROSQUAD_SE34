import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'get_started.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beam Load Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyStatefulWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  /** Values decoded from the image sent to the server */
  List _decodedValues = [];

  /**
  check the type and set the decoded values returned from the server
   */
  void _setDecodedValues(response) {
    if (response is List) {
      _decodedValues = response;
    }
  }

  Future<void> _getImageFromCamera() async {
    print("getting image from camera");
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    print("before sending the request");
    _setDecodedValues(await _sendImage(_image));
    print("after sending the request");
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    _setDecodedValues(await _sendImage(_image));
  }

  Future<List?> _sendImage(image) async {
    var stream = await image.readAsBytes();
    var length = await image.length();
    print("fileSize : \n");
    print(length / 1000);
    try {
      var headers = {'Content-Type': 'multipart/form-data'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:8000/api/main_image/'))
        ..headers.addAll(headers)
        ..files.add(http.MultipartFile.fromBytes('image', stream,
            filename: 'image.jpg'));

      // var url = Uri.http('127.0.0.1:8000', 'api/main_image/');
      // var request = http.MultipartRequest('POST',url);
      // request.files.add(new http.MultipartFile('file',stream, length, filename : "main_image.jpg"));
      print("request.toString() \n");
      print(request.toString());
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode >= 400) {
        //... 400, 401, 403, 500, 503
        //... error
      }
      return json.decode(await response.stream.bytesToString());
    } catch (e) {
      print(e);
    }
  }

  void _navigateToNextScreen() {
    //... check if server has sent a correct response
    //... if not don't navigate to next screen
    if (_decodedValues.length == 0) {
      return;
    }

    print("navigating to 'NextScreen'");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextScreen(decodedValues: _decodedValues),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    File(_image!.path),
                    height: 400,
                    width: 400,
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: _getImageFromGallery,
                  icon: const Icon(Icons.image),
                  iconSize: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: _navigateToNextScreen,
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageFromCamera,
        tooltip: 'Take Photo',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  List decodedValues = [];
  NextScreen({Key? key, required this.decodedValues}) : super(key: key);

  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  var _textBoxesControllers = [];
  var _textBoxWidgets = [];
  final _formKey = GlobalKey<FormState>();
  var _imageResponse;

/**
prepare the text box value from the given  List
 */
  String _prepareTextValues(List values) {
    var preparedValues = "";
    values.forEach((value) => preparedValues += value);
    return preparedValues;
  }

/**
initialise the text box widgets and text box controllers
 */
  void initTextBoxControllersAndTextBoxes() {
    for (var i = 1; i <= widget.decodedValues.length; i++) {
      var txtController = TextEditingController(
          text: _prepareTextValues(widget.decodedValues[i - 1]));
      txtController.addListener(() {
        widget.decodedValues[i - 1] = [txtController.text];
      });
      _textBoxesControllers.add(txtController);
      _textBoxWidgets.add(TextFormField(
          controller: txtController,
          decoration: InputDecoration(
            labelText: 'Field $i',
          )));
    }
  }

  @override
  void dispose() {
    //.. use a for loop to dispose all the text boxes
    for (var i = 0; i <= _textBoxesControllers.length; i++) {
      _textBoxesControllers[i].dispose();
    }
    super.dispose();
  }

  Future<void> _getTheResponse() async {
    print(jsonEncode(widget.decodedValues));

    try {
      var response = await http.post(
          Uri.parse("http://10.0.2.2:8000/api/verified_data/"),
          headers: {'Content-Type': "application/json"},
          body: jsonEncode({'data': widget.decodedValues}));

      print(response.runtimeType);
      _imageResponse = response.bodyBytes;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    initTextBoxControllersAndTextBoxes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._textBoxWidgets,
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _textBoxesControllers.forEach((textBoxController) {
                        textBoxController.clear();
                      });
                    },
                    child: const Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //... call the api - api/verified_values
                      await _getTheResponse();

                      if (_imageResponse == null) {
                        return;
                      }
                      //... navigate to the final screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            image: _imageResponse,
                          ), //... pass the image to the widget
                        ),
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Final Screen
class ResultScreen extends StatelessWidget {
  final Uint8List image;
  ResultScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Results'), automaticallyImplyLeading: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.memory(
            image,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
              child: const Text('Go to Home'),
            ),
          ),
        ],
      ),
    );
  }
}
