import 'package:flutter/material.dart';
class Book extends StatelessWidget {
  const Book({key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Text("data"),
      ),
    );
  }
}