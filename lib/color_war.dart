import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'color_counter.dart';
import 'color_battle.dart';

class ColorWar extends StatefulWidget {
  ColorWar({Key key}) : super(key: key);

  @override
  ColorWarState createState() => new ColorWarState();
}

class ColorWarState extends State<ColorWar> {

  @override
  Widget build(BuildContext context) {
    
    final PhoenixSocket socket = new PhoenixSocket("ws://51.38.33.122:4000/socket/websocket");
    socket.connect();
    final channel = socket.channel("color_war:lobby");
    channel.join();

    return
      new Container(
        decoration: new BoxDecoration(color: Colors.deepPurple),
        child: new Stack(
          children: <Widget>[
            new ColorBattle(channel: channel),
            new Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ColorCounter(color: "Orange", colorIndex: 1, channel: channel),
                new ColorCounter(color: "Purple", colorIndex: 2, channel: channel),
              ],
            ),
          ],
        )
      );
  }
}