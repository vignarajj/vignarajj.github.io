// Widget to display mock visit count with animation
import 'package:flutter/material.dart';

class VisitCountWidget extends StatefulWidget {
  final int visitCount;
  const VisitCountWidget({super.key, this.visitCount = 0});

  @override
  _VisitCountWidgetState createState() => _VisitCountWidgetState();
}

class _VisitCountWidgetState extends State<VisitCountWidget> {
  final int _visitCount = 1234; // Mock count

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: widget.visitCount),
      duration: const Duration(seconds: 2),
      builder: (context, int value, child) {
        return Text(
          'Site Visits: ${_visitCount + widget.visitCount}',
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        );
      },
    );
  }
}
