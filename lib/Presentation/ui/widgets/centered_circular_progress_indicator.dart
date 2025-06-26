import 'package:flutter/material.dart';

class CenteredCircularProgressIndicator extends StatefulWidget {
  const CenteredCircularProgressIndicator({super.key});

  @override
  State<CenteredCircularProgressIndicator> createState() =>
      _CenteredColorfulProgressIndicatorState();
}

class _CenteredColorfulProgressIndicatorState
    extends State<CenteredCircularProgressIndicator> {
  final List<Color> _colors = [
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
    Colors.orange,
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final nextIndex = (_currentIndex + 1) % _colors.length;

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(begin: _colors[_currentIndex], end: _colors[nextIndex]),
      duration: const Duration(seconds: 1),
      onEnd: () {
        setState(() {
          _currentIndex = nextIndex;
        });
      },
      builder: (context, color, child) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.teal),
            backgroundColor: Colors.grey.shade300,
            strokeWidth: 4,
          ),
        );
      },
    );
  }
}
