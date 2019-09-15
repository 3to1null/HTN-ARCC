// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'camera_preview_scanner.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomeCameraView(),
      },
    ),
  );
}
