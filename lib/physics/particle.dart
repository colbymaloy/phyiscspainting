import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Particle{
  ///a location is simply a single point. It doesn't define movement across a plane
  ///you need some other (Vector "velocity")force ADDED to location(over time) to simulate motion
  Vector2 location;
  ///Velocity is ADDED to current coordinates to create the new position. Add over time to simulate motion
  Vector2 velocity;

  ///acceleration does not merely refer to the speeding up or slowing down of a moving object,
  ///but rather any change in velocity in either magnitude or direction. 
  ///Acceleration is used to steer an object and should? be added to velocity
  Vector2 acceleration;

  ///Force = mass*acceleration
  double mass;


///friction is an opposite force to velocity -described as a "Dissipative force"
///F = -1*u*N*v
///
///*u(coefficient of friction,i.e ice has a lower value than sandpaper )
///*N(the normal force - newtons 3rd law - vehicle pushes against road with Gravity, road pushes back with N)
/// the object is moving along a surface at an angle, computing the normal force
/// is a bit more complicated because it doesn’t point in the same direction as gravity.
/// We’ll need to know something about angles and trigonometry later.
///*velocity(normalized velocity ie- the unit vector for the velocity
///
  Vector2 friction;


  /// air and fluid resistance Friction also occurs when a body passes through a liquid or gas(air).
  /// viscous force, drag force, fluid resistance. While the result is ultimately the same as our previous 
  /// friction example (the object slows down),
  /// the way in which we calculate a drag force will be slightly different. Let’s look at the formula:
  /// Fd=−(1/2)p(v²) (ACᵈ) v^
  /// 
  /// - Fd : Force of drag -the vector we ultimately want to compute and pass into our applyForce() function.
  /// 
  /// - (-1/2) is a constant: -0.5. This is fairly irrelevant in terms of our world, 
  /// as we will be making up values for other constants anyway. However, the fact that it is negative is important, 
  /// as it tells us that the force is in the opposite direction of velocity (just as with friction).
  /// 
  /// - ρ  is the Greek letter rho, and refers to the density of the liquid, something we don’t need to worry about. 
  /// We can simplify the problem and consider this to have a constant value of 1.
  /// 
  /// - v²  refers to the speed of the object moving.
  /// The object’s speed is the magnitude of the velocity vector: velocity.magnitude(). And v2 just means v squared or v * v.
  /// 
  /// - A refers to the frontal area of the object that is pushing through the liquid (or gas). An aerodynamic Lamborghini, for example, 
  /// will experience less air resistance than a boxy Volvo. Nevertheless, for a basic simulation, we can consider our object to be spherical and ignore this element.
  /// 
  /// - Cd  is the coefficient of drag, exactly the same as the coefficient of friction (u). This is a constant we’ll determine based on whether we want the drag force to be strong or weak.
  /// 
  /// - v^ This refers to the velocity unit vector, i.e. velocity.normalize(). Just like with friction, drag is a force that points in the opposite direction of velocity.
  /// 
  /// now after removing the elements we don't want we have:
  /// Force of drag = v²*Cd*v^*-1
  /// 
  
  ///apply drag of [substance] to [this] 
  Vector2 drag(var substance){
    var coefficient = .1; //coefficient should come from the substance, but no substance class exists yet so its a static value
    var speed =velocity.length;
    var dragMagnitude = coefficient*speed*speed;

    
    Vector2 drag =velocity.clone();
    drag.multiply(Vector2.all(-1));

    drag.normalize();
    drag.multiply(Vector2.all(dragMagnitude));
    applyForce(drag);

  }




  Particle({this.location}){
    velocity =Vector2(0, 0);
    acceleration =Vector2(0, 0);

  }
///update should change the location by applying other vectors 
  update(){
    velocity.add(acceleration);
    location.add(velocity);

    acceleration.multiply(Vector2.zero());
  }

///apply a force to acceleration
  applyForce(Vector2 force){
    acceleration.add(force);
  }


 

   Offset get offset => Offset(this.location.x, this.location.y);
}
