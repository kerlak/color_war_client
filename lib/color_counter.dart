import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class ColorCounter extends StatefulWidget {
  ColorCounter({Key key, this.color, this.colorIndex, this.channel}) : super(key: key);
  final String color;
  final int colorIndex;
  final PhoenixChannel channel;

  @override
  ColorCounterState createState() => new ColorCounterState();
}

class ColorCounterState extends State<ColorCounter> {
  int counter = 0;

  void incrementCounter() {
    final push_1 = new PhoenixPush(widget.channel, "color_" + widget.colorIndex.toString(), {}, 100);
    push_1.send();
  }

  void updateCounter(Map payload, String ref, String joinRef) {
    int newCounter = payload["color_" + widget.colorIndex.toString()];
    setState(() {
      counter = newCounter;
    });
  }

  @override
  void initState() {
    super.initState();
    this.transition();
  }

  transition() async {
    widget.channel.on("colors", updateCounter);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new MaterialButton(
          onPressed: incrementCounter,
          child:
            new Column(
              children: <Widget>[
                new Text(
                  '$counter',
                  style: Theme.of(context).textTheme.display1,
                ),
                new Text(widget.color)
              ],
            )
        )
      ],
    );
  }
}