import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double thickness;

  DashedLinePainter({
    this.color = const Color(0xFFD9D9D9),
    this.dashWidth = 4.0,
    this.dashGap = 2.0,
    this.thickness = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double startX = 0;
    final double y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedDividerExample extends StatelessWidget {
  const DashedDividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(),
      child: SizedBox(
        height: 1,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
