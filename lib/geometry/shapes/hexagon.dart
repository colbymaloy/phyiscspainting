import 'dart:math';

import 'package:flutter/material.dart';

import 'base_polygon.dart';

//TODO abstract to a polygon class

///the orientation of the [Hexagon] on the coordinate plane determines the angle from 0° which all the points are located
///[FlatSideUp] has points at 0°, 60°, 120°, 180°, 240°, 300° of rotation
///[PointySideUp] has points at 30°, 90°, 150°, 210°, 270°, 330° of rotation
enum HexagonOrientation { FlatSideUp, PointySideUp }

class Hexagon {
  final HexagonOrientation _orientation;

  final int numOfSides = 6;

  ///from center to pointy end is the radius
  final double radius;

  final Offset center;

  Hexagon.flatSideUp(
    this.radius,
    this.center,
  ) : this._orientation = HexagonOrientation.FlatSideUp;

  Hexagon.pointySideUp(
    this.radius,
    this.center,
  ) : this._orientation = HexagonOrientation.PointySideUp;

  HexagonOrientation get type => this._orientation;



//the sqrt(3) comes from the rule of a 30, 60, 90 triangle which you can draw from the [center]
//to any vertex(corner) and from the center to the wall, making a right triangle.
//the side lengths follow a rule of x,2x,x√3 which is respective of the side across from the corresponding angle size
//(the side across from the 30° angle is the shortest side - x)
//the radius of the shape is 2x
//multiplying by the radius gives us the full width or height, depending on the orientation


  double get height =>
      type == HexagonOrientation.FlatSideUp ? sqrt(3) * radius : 2 * radius;

  double get width =>
      type == HexagonOrientation.FlatSideUp ? 2 * radius : sqrt(3) * radius;



  List<Offset> getOffsetsOfAllVertices() {
    List<Offset> temp = [];

    for (int i = 0; i < numOfSides; i++) {
      temp.add(getSingleVertexOffset(i));
    }
    return temp;
  }

  ///a vertex is a one of the corners where the sides intersect

  Offset getSingleVertexOffset(int sideNumber) {
    switch (_orientation) {
      case HexagonOrientation.FlatSideUp:
        var angle_deg = 60 * sideNumber;
        var angle_rad = pi / 180 * angle_deg;
        return Offset(center.dx + radius * cos(angle_rad),
            center.dy + radius * sin(angle_rad));
        break;
      case HexagonOrientation.PointySideUp:
        
        var angle_deg = (60 * sideNumber) - 30;
        var angle_rad = pi / 180 * angle_deg;
        return Offset(center.dx + radius * cos(angle_rad),
            center.dy + radius * sin(angle_rad));
        break;
    }
  }

  ///for regular polygons(all sides are equal)
  double getSingleAngleOfRegularPolygon() {
    return getSumOfInteriorAngles() / numOfSides;
  }

  ///formula for sum of angles of polygon is (n-2)*180
  double getSumOfInteriorAngles() {
    return (this.numOfSides - 2) * 180.0;
  }
}
