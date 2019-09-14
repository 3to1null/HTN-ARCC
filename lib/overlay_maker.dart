// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

enum Detector { text }

class TextOverlayMaker extends StatelessWidget {
  TextOverlayMaker(this.absoluteImageSize, this.visionText);

  final Size absoluteImageSize;
  final VisionText visionText;

  

  Widget _createOverlay(BuildContext context, TextContainer container){
    final double scaleX = absoluteImageSize.width / MediaQuery.of(context).size.width;
    final double scaleY = absoluteImageSize.height / MediaQuery.of(context).size.height;
    num money;

    try{
       money = double.parse(container.text);
    }catch(e){
      return null;
    }
    
    if(money == null){
      return null;
    }

    return Positioned(
      left: container.boundingBox.left * scaleX,
      top: container.boundingBox.top * scaleY,
      right: container.boundingBox.right * scaleX,
      bottom: container.boundingBox.bottom * scaleY,
      child: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Text(money.toString(), style: TextStyle(color: Colors.white),),
      ),
    );
  }

  List<Widget> _createChildren(BuildContext context){
    List<Widget> childlist = [];
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          if(_createOverlay(context, element) != null){
            childlist.add( _createOverlay(context, element));
          }
        }
      }
    }
    return childlist;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _createChildren(context),
    );
  }
}

// Paints rectangles around all the text in the image.
class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.visionText);

  final Size absoluteImageSize;
  final VisionText visionText;


  @override
  void paint(Canvas canvas, Size size) {
    
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;


    Rect scaleRect(TextContainer container) {
      return Rect.fromLTRB(
        container.boundingBox.left * scaleX,
        container.boundingBox.top * scaleY,
        container.boundingBox.right * scaleX,
        container.boundingBox.bottom * scaleY,
      );
    }

    dynamic drawText(TextContainer container, canvas, num money){
      final textStyle = TextStyle(
        color: Colors.white,
        fontSize: container.boundingBox.height / 2,
      );
      final textSpan = TextSpan(
        text: money.toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final offset = Offset(container.boundingBox.left * scaleX, container.boundingBox.top * scaleY);
      textPainter.paint(canvas, offset);
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill
      ..colorFilter = ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          num money;
          try{
            money = double.parse(element.text);
            // TODO: Actually implement the conversion.
            canvas.drawRect(scaleRect(element), paint);
            drawText(element, canvas, money);
          }catch(e){}
        }
      }
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.visionText != visionText;
  }
}