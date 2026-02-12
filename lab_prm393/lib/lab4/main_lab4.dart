import 'package:flutter/material.dart';
import 'package:lab_prm393/lab4/exe_01.dart';
import 'package:lab_prm393/lab4/exe_02.dart';
import 'package:lab_prm393/lab4/exe_03.dart';
import 'package:lab_prm393/lab4/exe_04.dart';
import 'package:lab_prm393/lab4/exe_05.dart';

class MainLab4 extends StatelessWidget {
  const MainLab4({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "Exercise 1 – Core Widgets Demo", "page": Exercise1Page()},
      {"title": "Exercise 2 – Input Controls Demo", "page": Exercise2Page()},
      {"title": "Exercise 3 – Layout Demo", "page": Exercise3Page()},
      {"title": "Exercise 4 – App Structure & Theme", "page": Exercise4Page()},
      {"title": "Exercise 5 – Common UI Fixes", "page": Exercise5Page()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 – Flutter UI Fundamentals"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                item["title"] as String,
                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
              ),
              trailing: IconButton(icon:Icon(Icons.chevron_right),
                  onPressed: () {
                    Navigator.of(context).push(
                       MaterialPageRoute<void>(
                        builder: (context) => item["page"]as Widget ,
                      ),
                    );
              }),
            ),
          );
        },
      ),
    );
  }
}
