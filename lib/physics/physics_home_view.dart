import 'package:flutter/material.dart';

import 'package:physics/physics/particle_system.dart';
import 'package:physics/physics/physics_painter.dart';

class PhysicsHome extends StatefulWidget {
  @override
  _PhysicsHomeState createState() => _PhysicsHomeState();
}

class _PhysicsHomeState extends State<PhysicsHome>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Offset _offset = Offset(.4, .7);

  ParticleSystem system;

  @override
  initState() {
    super.initState();
    system = ParticleSystem(count: 70);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..addListener(() {
            system.updateParticles();
          });
  }

  @override
  Widget build(BuildContext context) {
    print('being build');
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, .001)
        ..rotateX(_offset.dx)
        ..rotateY(_offset.dy),
      alignment: FractionalOffset.center,
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: GestureDetector(
          onTap: () {
            controller.forward();
          },
          child: CustomPaint(
            painter: PhysicsPainter(
              system: system,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    super.dispose();
  }
}
