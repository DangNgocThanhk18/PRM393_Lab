import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exercise1Page extends StatelessWidget {
  const Exercise1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exercise 1 – Core Widgets: Text, Image, Icon, Card, ListTile",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcom to Flutter UI",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Icon(Icons.movie, size: 90, color: Colors.blue),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Image.asset("assets/images/cat.jpg", fit: BoxFit.cover),
              ),
            ),
            Expanded(child: ListView(children: <Widget>[CardView()])),
          ],
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.star),
        title: Text('Movie Item'),
        subtitle: Text('This is a sample ListTile inside a Card'),
      ),
    );
  }
}
