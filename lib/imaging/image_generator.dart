
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:vector_math/vector_math.dart';

import 'package:flutter/material.dart';

///This class is meant to be both a way and explanation of how generating an image from width/height of a screen

class ImageGenerator{

ImageGenerator.fromWidthandHeight(){}


 Future<ui.Image> generateImage(Size size) async{
 var completer = Completer<ui.Image>();
  
 
  ui.decodeImageFromPixels(
    pixels.buffer.asUint8List(),
    width,
    height,
    ui.PixelFormat.bgra8888,
    (ui.Image img) {
      completer.complete(img);
    },
  );

  return completer.future;
}


/// Main area of interest, this function will
/// return color for each particular color on our [ui.Image]



///The width and and height property of our screen defines how many pixels are on the x and y axis, respectively.
///By iterating through a double forloop, we can effectively create an Array(List in Dart) of values which
///actually represent the logical pixels. Logical Pixels are not the same as the actual physical pixels 
///on the device. 

iteratePixels(Size size){
  int width = size.width.ceil();
  int height = size.height.ceil();
  
  //a list of 32bit ints. bits describe the max value a type can have
  //32 bits means the lowest possible value is  -2,147,483,648 and the max is  2,147,483,647
  //and we create a List with the size of width*height to represent the number of pixels on the screen
  Int32List pixels = Int32List(width * height);

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      //1*360+0=360
      //2*360+0=720
      int index = y * width + x;
      
      pixels[index] = generatePixel(x, y, size);
      
    }
  }
}


int generatePixel(int x, int y, Size size) {
  /// White dots each 20 pixels
  if (x % 20 == 0 && y % 20 == 0) {
    return 0xffffffff;
  }
  if(x==145&&y==200){
    return 0xffef5fcd;
  }

  /// Compute unified vector, values of its components
  /// will be between 0 and 1
  var uv = Vector2(x / size.width, y / size.height);

  /// Mapping unified vector values
  /// to color range of 0..255
  return Color.fromRGBO(
    (uv.x * 255).toInt(),
    0,
    (uv.y * 255).toInt(),
    1.0,
  ).value;
}

}