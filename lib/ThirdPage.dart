import 'package:flutter/material.dart';
import 'package:flutter_v2/Resources.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key, required this.title});

  final String title;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  //Variables to store accelerometer data
  String _accelerometerData = "Accelerometer Data:";
  String? sharedPrefText;

  @override
  void initState() {
    super.initState();

    _loadSharedPref();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerData = "Accelerometer Data:\n"
            "X: ${event.x.toStringAsFixed(2)}\n"
            "Y: ${event.y.toStringAsFixed(2)}\n"
            "Z: ${event.z.toStringAsFixed(2)}";
      });
    });
  }

  Future<void> _loadSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedText = prefs.getString("inputText");
    if (savedText != null) {
      setState(() {
        sharedPrefText = savedText; // Update the TextField with saved text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Display the accelerometer data
            Text(_accelerometerData, style: const TextStyle(fontSize: 16)),
            buildSharedPrefText(sharedPrefText?? "No Saved Text"),
            navigationRow(context, "Home", "/", "SharedPref", "/second"),
          ],
        ),
      ),
    );
  }
}
