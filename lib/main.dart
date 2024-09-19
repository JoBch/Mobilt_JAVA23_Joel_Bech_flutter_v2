import 'package:flutter/material.dart';
import 'package:flutter_v2/Resources.dart';
import 'package:flutter_v2/SecondPage.dart';
import 'package:flutter_v2/ThirdPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter V2",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: "Home"),
        "/second": (context) => const SecondPage(title: "SharedPref"),
        "/third": (context) => const ThirdPage(title: "Accelerometer"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textController;
  String? sharedPrefText;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _loadSharedPref();
  }

  Future<void> _loadSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedText = prefs.getString("inputText");
    if (savedText != null) {
      setState(() {
        sharedPrefText = savedText;
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
            const Image(
              image: AssetImage("./assets/flutter_dart_bird.gif"),
            ),
            buildSharedPrefText(sharedPrefText!),
            navigationRow(context, "SharedPref", "/second", "Sensor", "/third"),
          ],
        ),
      ),
    );
  }
}
