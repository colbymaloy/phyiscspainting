import 'package:flutter/material.dart';
import 'package:physics/physics/particle.dart';
import 'package:physics/physics/particle_system.dart';
import 'package:vector_math/vector_math.dart';

class PhysicsPainter extends CustomPainter {
  ParticleSystem system;

  PhysicsPainter({this.system}) : super(repaint: system) {
     print("created Painter");
  }

  @override
  void paint(Canvas canvas, Size size) {
   
   // print("painting");
    // TODO: implement paint

    // canvas.clipRect(Rect.fromCenter());
    
    for (Particle part in system.particles) {
      
      part.checkEdges(size);
      
      canvas.drawCircle(part.offset, part.size, Paint()..color=Color.fromARGB(part.alpha, 200, 200, 200));
    }
    

    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }
}
