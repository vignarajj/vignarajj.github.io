// ignore: avoid_web_libraries_in_flutter
// ignore: deprecated_member_use
import 'dart:html';
import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalendlyPage extends StatelessWidget {
  CalendlyPage({super.key}) {
    // Register the iframe as a view
    if (kIsWeb) {
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(
        'calendly-html',
        (int viewId) => IFrameElement()
          ..src = 'https://calendly.com/vignarajj'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: HtmlElementView(viewType: 'calendly-html'),
    );
  }
}
