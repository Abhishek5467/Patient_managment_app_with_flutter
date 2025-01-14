// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Patient Care",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }

}