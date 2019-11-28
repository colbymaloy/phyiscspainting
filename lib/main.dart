import 'package:flutter/material.dart';
import 'package:physics/image_paint_example.dart';
import 'package:physics/physics/physics_home_view.dart';

void main() async => runApp(MaterialApp(
 // showPerformanceOverlay: true,
  home: MyApp()));

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return PhysicsHome();
  }
}
