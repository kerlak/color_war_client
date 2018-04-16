import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'dart:math' as math;

class ColorBattle extends StatefulWidget {
  ColorBattle({Key key, this.channel}) : super(key: key);
  final PhoenixChannel channel;

  @override
  ColorBattleState createState() => new ColorBattleState();
}

class ColorBattleState extends State<ColorBattle> {
  double ratio = 0.5;

  void updateRadius(Map payload, String ref, String joinRef) {
    int color_1 = payload["color_1"];
    int color_2 = payload["color_2"];
    if(color_1 != 0 || color_2 != 0) {
      ratio = color_1 / (color_1 + color_2);
      print(ratio);
    }
    setState(() {
      ratio = ratio;
    });
  }

  @override
  void initState() {
    super.initState();
    this.transition();
  }

  transition() async {
    widget.channel.on("colors", updateRadius);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Container(
      width: width * ratio,
      height: height,
      decoration: new BoxDecoration(color: Colors.red),
    );
  }
}