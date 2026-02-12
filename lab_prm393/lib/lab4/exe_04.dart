import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exercise4Page extends StatelessWidget {
  const Exercise4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise 1 – Core Widgets: Text, Image, Icon, Card, ListTile"),
      ),
      body:  Center(
        child: Text(
          "Nội dung Exercise 1",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
