import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbehScreen extends StatefulWidget {
  const TasbehScreen({super.key});

  @override
  State<TasbehScreen> createState() => _TasbehScreenState();
}

class _TasbehScreenState extends State<TasbehScreen> {
  int counter = 0;
  int cunter2 = 0;

  void incrementCounter() {
    setState(() {
      counter++;
      if (counter == 33) {
        counter = 0;
        cunter2++;
      }
      _savePreferences();
    });
  }

  //funksion shared_preferences
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
      cunter2 = prefs.getInt('cunter2') ?? 0;
    });
  }

  //save counter and cunter2
  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
    prefs.setInt('cunter2', cunter2);
  }

  //initState
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void resetCounter() {
    setState(() {
      counter = 0;
      cunter2 = 0;
       _savePreferences(); 
    });
  }

  void resetFunction() {
    setState(() {
      counter = 0;
       _savePreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Tasbeeh",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Neumorphic(
                    style: NeumorphicStyle(
                      color: Colors.grey,
                      shape: NeumorphicShape.flat,
                      border: NeumorphicBorder.none(),
                    ),
                    child: Container(
                      width: 100,
                      height: 55,
                      child: Center(
                          child: Text(
                        '$cunter2',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      color: Colors.grey,
                      shape: NeumorphicShape.flat,
                      border: NeumorphicBorder.none(),
                    ),
                    child: Container(
                      width: 100,
                      height: 55,
                      child: Center(
                          child: Text(
                        '$counter',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 8,
                lightSource: LightSource.topLeft,
                color: Colors.white,
              ),
              child: Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                child: Text(
                  '$counter',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            NeumorphicButton(
                onPressed: incrementCounter,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  depth: 4,
                  color: Colors.teal,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 34,
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                      onPressed: resetCounter,
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: 4,
                        color: Colors.redAccent,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Icon(
                        Icons.restore,
                        color: Colors.white,
                        size: 34,
                      )),
                  NeumorphicButton(
                      onPressed: resetFunction,
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.convex,
                        depth: 4,
                        color: Colors.redAccent,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      child: Icon(
                        Icons.restart_alt_rounded,
                        color: Colors.white,
                        size: 34,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
