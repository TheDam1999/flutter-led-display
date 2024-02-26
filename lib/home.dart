import 'package:flutter/material.dart';
import 'display_simulator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? text;

  @override
  void initState() {
    text = 'gfgfgfdgd';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            DisplaySimulator(
              text: text!,
              border: true,
              debug: false,
            ),
            SizedBox(height: 18),
            _getTextField()
          ],
        )
      )
    );
  }

  Container _getTextField() {
    BorderSide borderSide = BorderSide(color: Colors.blue, width: 4);
    InputDecoration inputDecoration = InputDecoration(
      border: UnderlineInputBorder(borderSide: borderSide),
      disabledBorder: UnderlineInputBorder(borderSide: borderSide),
      enabledBorder: UnderlineInputBorder(borderSide: borderSide),
      focusedBorder: UnderlineInputBorder(borderSide: borderSide),
    );
    print("dambt : start");

    return Container(
      width: 200,
      child: TextField(
        maxLines: null,
        enableSuggestions: false,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 32,
          fontFamily: "Monospace"
        ),
          decoration: inputDecoration,
          onChanged: (val) {
            setState(() {
              text = val;
            });
          },
        //controller: _controller,
      )
    );
  }
}
