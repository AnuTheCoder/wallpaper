import 'package:flutter/material.dart';
import 'package:wallpaper/UI/screens/home.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aesthetic Wallpapers",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity:VisualDensity.adaptivePlatformDensity
      ),
      home:home(),
    );
  }
}
