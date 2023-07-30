import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.pink[200],
      appBar: AppBar(
        title: const Text('Capturing Images'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(imageFile != null)
              Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover
                  ),
                  border: Border.all(width: 5, color: Colors.black),
                  borderRadius: BorderRadius.circular(9.0),
                ),
              )
            else
              Container(
                width: 400,
                height: 400,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  border: Border.all(width: 8, color: Colors.white60),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text('Image should appear here',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      onPressed: ()=> getImage(source: ImageSource.camera),
                      icon: Icon(Icons.camera),
                      label: const Text('Capture Image')
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child:ElevatedButton.icon(
                    onPressed:()=> getImage(source: ImageSource.gallery),
                    icon: Icon(Icons.image_outlined),  //icon data for elevated button
                    label: Text("Select Image",), //label text
                  ) ,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {

    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 640,
        maxHeight: 480,
        imageQuality: 70 //0 - 100
    );

    if(file?.path != null){
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
