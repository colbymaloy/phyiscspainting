import 'dart:ui';

import 'package:flutter/material.dart';

class TestPainting extends StatefulWidget {
  @override
  _TestPaintingState createState() => _TestPaintingState();
}

class _TestPaintingState extends State<TestPainting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: CustomPaint(
        painter: TestPainter(initOffsets(MediaQuery.of(context).size)),
       // child: Container(color: Color(0x20ffffff),),
       size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      ),
    );
  }

  initOffsets(Size size) {
    List<Offset> temp = [];

    for (int x = 0; x < size.width; x++) {
      temp.add(Offset(x.toDouble(),200,));
    }
    return temp;
  }
}

class TestPainter extends CustomPainter {
  final List<Offset> offsets;

  TestPainter(this.offsets);
  Paint painter = Paint()..color=Colors.black;
  @override
  void paint(Canvas canvas, Size size) {
    //canvas.(rect, paint)

    canvas.drawPoints(PointMode.polygon, offsets, painter);
  }

  @override
  bool shouldRepaint(TestPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TestPainter oldDelegate) => false;
}
