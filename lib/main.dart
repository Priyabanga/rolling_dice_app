import 'package:flutter/material.dart';

import 'homescreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "homescreen",
      routes: {
        "homescreen": (context) => MyHomeScreen(),
      },
    ),
  );
}
