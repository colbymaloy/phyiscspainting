import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' hide Colors;

/// Waits till [ui.Image] is generated and renders
/// it using [CustomPaint] to render it. Allows use of [MediaQuery]
class ImagePaintExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ui.Image>(
        future: generateImage(Size(300,500)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomPaint(
              // Passing our image
              painter: ImagePainter(image: snapshot.data),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 1.5,
              ),
            );
          }
          return Text('Generating image...');
        },
      ),
    );
  }
}

/// Paints given [ui.Image] on [ui.Canvas]
/// does not repaint
class ImagePainter extends CustomPainter {
  ui.Image image;

  ImagePainter({this.image});

  @override
  void paint(Canvas canvas, Size size) {
    
    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// Generates a [ui.Image] with certain pixel data
Future<ui.Image> generateImage(Size size,) async {
  int width = size.width.ceil();
  int height = size.height.ceil();
  var completer = Completer<ui.Image>();
  print(width);
  print(height);
  print(width * height);

 

  Int32List pixels = Int32List(width * height);

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < height; y++) {
      //1*360+0=360
      //2*360+0=720
      int index = x+y*width;
      
      pixels[index] = generatePixel(x, y, size);
    }
  }
  print(pixels.length);
  
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
/// return color for each particular pixel on our [ui.Image]
int generatePixel(int x, int y, Size size) {
  /// White dots each 20 pixels
  if (x % 20 == 0 && y % 20 == 0) {
    return 0xffffffff;
  }
  if (x == 145 && y == 200) {
    return 0xffef5fcd;
  }

  int ind2 = (x+1) +y*size.width.toInt();
      

  /// Compute unified vector, values of its components
  /// will be between 0 and 1
  var uv = Vector2(x.toDouble()/size.width , y.toDouble()/size.height);

  double dist = uv.distanceTo(Vector2(size.width/2,size.height/2));


  /// Mapping unified vector values
  /// to color range of 0..255
  return Color.fromRGBO(
    (uv.x*255).toInt(),
    0,
    (uv.y*255).toInt(),
    1.0,
  ).value;
}

/// Takes a unit Vector3 (all values from 0 to 1)
/// and returns an int representing color in RGBA format
/// Vector3(0, 1, 0) -> 0xff00ff00
///
/// to further clarify - vector3 class has mappings for each of its values
/// x,y,z coordinates to multiple different things. The best way to thing about it is
/// when you create a vector3(2,3,4) x == 2,y==3,z==4
/// and then you map those like so:
/// x == r == 2
/// y == g == 3
/// z == b == 4
/// you could probably describe that as mapping the vector values to a color, even thought they're both the same number
int toColorInt(Vector3 vec) {
  int r = (vec.r * 255).toInt();
  int g = (vec.g * 255).toInt();
  int b = (vec.b * 255).toInt();

  return (b << 0) | (g << 8) | (r << 16) | (255 << 32);
}
