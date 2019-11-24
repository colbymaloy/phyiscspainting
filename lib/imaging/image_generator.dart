import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:vector_math/vector_math.dart' hide Colors;

import 'package:flutter/material.dart';

///This class is meant to be both a way and explanation of how generating an image from width/height of a screen

class ImageGenerator {

  
  

  Future<ui.Image> generateImage(Size size) async {
    var completer = Completer<ui.Image>();

    ui.decodeImageFromPixels(
      iteratePixels(size).buffer.asUint8List(),
      size.width.toInt(),
      size.height.toInt(),
      ui.PixelFormat.bgra8888,
      (ui.Image img) {
        completer.complete(img);
      },
    );

    return completer.future;
  }

  ///The width and and height property of our screen defines how many pixels are on the x and y axis, respectively.
  ///By iterating through a double forloop, we can effectively create an Array(List in Dart) of values which
  ///actually represent the logical pixels. Logical Pixels are not the same as the actual physical pixels
  ///on the device.

  Int32List iteratePixels(Size size) {
    int width = size.width.ceil();
    int height = size.height.ceil();

    //a list of 32bit ints. bits describe the max value a type can have
    //32 bits means the lowest possible value is  -2,147,483,648 and the max is  2,147,483,647
    //and we create a List with the size of width*height to represent the number of pixels on the screen
    Int32List pixels = Int32List(width * height);

    //iterate through the width and height to populate each position in the List with an int to represent the color

    for (var x = 0; x < width; x++) {
      for (var y = 0; y < height; y++) {
        //0*0+0 = 0
        //1*360+0=360
        //2*360+0=720
        //0*360+1=1
        int index = y * width + x;

        pixels[index] = generatePixelColor(x, y, size);
      }
    }

    return pixels;
  }

  ///using the current coordinate of the pixel, return an int to go in to the pixels array
  ///which represents the desired color

  int generatePixelColor(int x, int y, Size size) {
    /// White dots each 20 pixels
    if (x % 20 == 0 && y % 20 == 0) {
      return 0xffffffff;
    }
    if (x == 145 && y == 200) {
      return Colors.blue.value;
    }

    /// this allows us the option of generating a color pattern based on the x& y of the pixel
    /// and dividing by width&height to get a value between 0 and 1,
    var uv = Vector2(x.toDouble(), y.toDouble());

    ///the distance between the current x and y and the center of the screen
  double dist = uv.distanceTo(Vector2(size.width/2,size.height/2));

    

    ///return the desired color for the pixel
    return Color.fromRGBO(
      (dist).toInt(),
      0,
      (uv.y * 255).toInt(),
      1.0,
    ).value;
  }
}
