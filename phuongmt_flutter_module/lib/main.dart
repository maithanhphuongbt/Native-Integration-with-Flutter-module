import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter module'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('SenpayTest');


  int _counter = 0;
  String _dataFromAndroid = "No thing";
  String _dataToAndroid = "No thing";

  Future<void> _getDataFromAndroid() async {
    try {
      final String result = await platform.invokeMethod('getDataFromNative');
      print('phuongmt data from native: $result');
      setState(() {
        _dataFromAndroid = result;
      });
    } on PlatformException catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _sendDataToNative(String data) async {
    try {
      _counter++;
      setState(() {
        _dataToAndroid = '$data --- $_counter';
      });
      await platform.invokeMethod('sendDataToNative',{"data": _dataToAndroid}); //sending data from flutter here

      _getDataFromAndroid();
      final String result2 = await platform.invokeMethod('sendDataToNative');
      debugPrint('phuongmt flutter: $result2');
    } on PlatformException catch (e) {
      debugPrint("Error: $e");
    }
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
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/icon.png'),
            ),
            Divider(),
            Text(
              'Data from native: $_dataFromAndroid',
            ),
            Divider(),
            Text(
              'Send data to native: $_dataToAndroid',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_sendDataToNative('sendDataToNative'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
