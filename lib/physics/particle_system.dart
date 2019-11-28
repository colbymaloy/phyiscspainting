import 'dart:math';

import 'package:flutter/material.dart';
import 'package:physics/physics/particle.dart';
import 'package:vector_math/vector_math.dart';

export 'package:physics/physics/particle.dart';

class ParticleSystem extends ChangeNotifier {
  List<Particle> particles = [];
  Random ran = Random();
  Vector2 tapPos = Vector2.zero();

  Size size ;

  ParticleSystem({
    int count,
  }) {
    particles = List.generate(
      count,
      (size) {
        return Particle(
          Vector2(175, 500),
        );
      },
    );
  }

  updateParticles() {
    particles.add(Particle(Vector2(175, 500)));

    for (int i = particles.length-1;i>0;i--) {
      particles[i].tapPos = tapPos;
      particles[i].update();
      if(particles[i].finished){
        particles.removeAt(i);
      }
    }
    notifyListeners();
  }
}
