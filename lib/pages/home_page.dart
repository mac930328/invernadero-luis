import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final DatabaseReference controlRef = FirebaseDatabase.instance.ref('control');

  bool _isLight1On = false;
  bool _isLight2On = false;
  bool _isFan1On = false;
  bool _isFan2On = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('L1'),
                    IconButton(
                      icon: Icon(
                        Icons.lightbulb,
                        size: 60,
                        color: _isLight1On ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => _isLight1On = !_isLight1On);
                        _updateControlValues();
                      },
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text('L2'),
                    IconButton(
                      icon: Icon(
                        Icons.lightbulb,
                        size: 60,
                        color: _isLight2On ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => _isLight2On = !_isLight2On);
                        _updateControlValues();
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('F1'),
                    IconButton(
                      icon: Icon(
                        Icons.ac_unit_rounded,
                        size: 60,
                        color: _isFan1On ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => _isFan1On = !_isFan1On);
                        _updateControlValues();
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('F2'),
                    IconButton(
                      icon: Icon(
                        Icons.ac_unit_rounded,
                        size: 60,
                        color: _isFan2On ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => _isFan2On = !_isFan2On);
                        _updateControlValues();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateControlValues() {
    controlRef.set({
      'l1': _isLight1On ? 1 : 0,
      'l2': _isLight2On ? 1 : 0,
      'f1': _isFan1On ? 1 : 0,
      'f2': _isFan2On ? 1 : 0,
    });
  }
}
