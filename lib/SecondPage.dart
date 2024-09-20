import 'package:flutter/material.dart';
import 'package:flutter_v2/Resources.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.title});

  final String title;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        sharedPrefText = savedText; //Update the TextField with saved text
      });
    }
  }

  Future<void> _saveSharedPref(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("inputText", text);
    setState(() {
      sharedPrefText = text;
    });
    print("SharedPref: $sharedPrefText");
    showToast(sharedPrefText!);
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
            buildSharedPrefText(sharedPrefText?? "No Saved Text"),
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: inputSharedPref(context, _textController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveSharedPref(_textController.text);
                          _textController.clear();
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
            navigationRow(context, "Home", "/", "Sensor", "/third"),
          ],
        ),
      ),
    );
  }
}
