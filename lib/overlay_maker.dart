// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' as ui;
import 'dart:math';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import 'functions/currencies.dart';
import 'functions/conversion_rates.dart';

import 'search.dart';

enum Detector { text }


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
        container.boundingBox.top * scaleY - 5,
        container.boundingBox.right * scaleX + 20,
        container.boundingBox.bottom * scaleY + 5,
      );
    }

    dynamic drawText(TextContainer container, canvas, String money){
      final textStyle = TextStyle(
        color: Colors.white,
        fontSize: max(12.0, container.boundingBox.height / 2),
      );
      final textSpan = TextSpan(
        text: money,
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
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
      ..colorFilter = ColorFilter.mode(Colors.black.withOpacity(0.75), BlendMode.dstATop);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          num money;
          // String text = element.text.replaceFirst(',', '.'); //EU support? Based on locale?
          String text = element.text.replaceAll(',', '');

          String c1;
            for(Map<String, String> currency in getCurrenciesSync()){
              if(text.startsWith(currency['symbol'])){
                c1 = currency['short'];
                text = text.substring(1);
                break;
              }else if(text.endsWith(currency['symbol'])){
                c1 = currency['short'];
                text = text.substring(0, text.length - 1);
                break;
              }
          }

          // Probably not money
          if(text.length >= 5 && !(text.contains('.') || text.contains(','))){
            break;
          }else if(element.boundingBox.height < 5){
            break;
          }

          try{
            money = double.parse(text);
            money = calculateConverted(selectedCountriesShared['c1'].short, selectedCountriesShared['c2'].short, money);
            print(formatMoney(selectedCountriesShared['c2'].short, money));
            canvas.drawRect(scaleRect(element), paint);
            drawText(element, canvas, formatMoney(selectedCountriesShared['c2'].short, money));
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