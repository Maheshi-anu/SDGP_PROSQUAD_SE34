import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My App'),
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

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextScreen(),
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
              _image!,
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
  const NextScreen({super.key});

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  final _textController4 = TextEditingController();

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                controller: _textController1,
                decoration: const InputDecoration(
                  labelText: 'Field 1',
                ),
              ),
              TextFormField(
                controller: _textController2,
                decoration: const InputDecoration(
                  labelText: 'Field 2',
                ),
              ),
              TextFormField(
                controller: _textController3,
                decoration: const InputDecoration(
                  labelText: 'Field 3',
                ),

              ),
              TextFormField(
                controller: _textController4,
                decoration: const InputDecoration(
                  labelText: 'Field 4',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _textController1.clear();
                      _textController2.clear();
                      _textController3.clear();
                      _textController4.clear();
                    },
                    child: const Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResultScreen(),
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
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/car.jpg',
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