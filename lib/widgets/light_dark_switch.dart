import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:mr_samy_elmalah/core/app_theme.dart';

class LightDarkSwitchApp extends StatelessWidget {
  const LightDarkSwitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LDSwitch(
      width: 100 * 0.6,
      height: 45 * 0.6,
      iconSize: 30 * 0.6,
    );
  }
}

class LDSwitch extends StatefulWidget {
  final double width;
  final double height;
  final double iconSize;

  const LDSwitch({
    super.key,
    this.width = 160,
    this.height = 60,
    this.iconSize = 50,
  });

  @override
  State<LDSwitch> createState() => _LDSwitchState();
}

class _LDSwitchState extends State<LDSwitch>
    with SingleTickerProviderStateMixin {
  bool _clicked = false;
  bool _changeSunToMoon = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Attach status listener to the ANIMATION instead of controller
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        //print('🎬 Animation Status: $status');
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          //print(
          //  '🌗 Toggling _changeSunToMoon from $_changeSunToMoon to ${!_changeSunToMoon}');
          setState(() {
            _changeSunToMoon = !_changeSunToMoon;
            themeNotifier.themeModeChanger();
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSun(double size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size * 0.1),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(size / 2),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.withOpacity(0.5),
                spreadRadius: size * 0.1,
                blurRadius: size * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoon(double size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size * 0.1),
      child: Stack(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(size / 2),
            child: Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(size / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: size * 0.2,
                    blurRadius: size * 0.2,
                  ),
                ],
              ),
            ),
          ),
          ..._buildMoonDetails(size),
        ],
      ),
    );
  }

  List<Widget> _buildMoonDetails(double size) {
    return [
      _buildMoonSpot(size * 0.14, size * 0.25, size * 0.14),
      _buildMoonSpot(size * 0.3, size * 0.1, size * 0.3),
      _buildMoonSpot(size * 0.2, size * 0.6, size * 0.2),
    ];
  }

  Widget _buildMoonSpot(double top, double left, double diameter) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(diameter / 2),
        ),
      ),
    );
  }

  Widget _buildBackground(double scaleFactor) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height * 3.333,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigo[900]!, Colors.lightBlue[300]!],
            ),
          ),
        ),
        ..._buildStars(scaleFactor),
        ..._buildClouds(scaleFactor, Colors.lightBlue[50]!),
        ..._buildClouds(scaleFactor, Colors.lightBlue[100]!),
      ],
    );
  }

  List<Widget> _buildStars(double scaleFactor) {
    return [
      _buildStar(10, 10, 10, scaleFactor),
      _buildStar(20, 30, 8, scaleFactor),
      _buildStar(10, 50, 10, scaleFactor),
      _buildStar(20, 70, 8, scaleFactor),
      _buildStar(10, 110, 10, scaleFactor),
      _buildStar(15, 85, 10, scaleFactor),
      _buildStar(40, 20, 10, scaleFactor),
      _buildStar(35, 35, 8, scaleFactor),
      _buildStar(40, 55, 10, scaleFactor),
      _buildStar(35, 65, 8, scaleFactor),
      _buildStar(40, 80, 10, scaleFactor),
      _buildStar(30, 90, 8, scaleFactor),
    ];
  }

  Widget _buildStar(double top, double left, double size, double scaleFactor) {
    return Positioned(
      top: top * scaleFactor,
      left: left * scaleFactor,
      child: StarContainer(
        size: size * scaleFactor,
        color: Colors.white,
        armCount: 4,
      ),
    );
  }

  List<Widget> _buildClouds(double scaleFactor, Color color) {
    return [
      _buildCloud(140, -50, 100, scaleFactor, color),
      _buildCloud(155, -30, 100, scaleFactor, color),
      _buildCloud(165, 40, 70, scaleFactor, color),
      _buildCloud(155, 85, 30, scaleFactor, color),
      _buildCloud(150, 110, 40, scaleFactor, color),
      _buildCloud(170, 90, 60, scaleFactor, color),
      _buildCloud(130, 140, 100, scaleFactor, color),
    ];
  }

  Widget _buildCloud(
      double top, double left, double size, double scaleFactor, Color color) {
    return Positioned(
      top: top * scaleFactor,
      left: left * scaleFactor,
      child: CircularContainer(
        size: size * scaleFactor,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(
    //'🔄 BUILD CALLED - clicked: $_clicked, _changeSunToMoon: $_changeSunToMoon');
    final scaleFactor = widget.height / 60;
    final backgroundHeight = widget.height * 3.333;
    final translationDistance = backgroundHeight - widget.height;
    final horizontalTranslation = (widget.width - widget.iconSize * 1.2);

    //print('📐 Scale Factor: $scaleFactor');
    //print('🏞 Background Height: $backgroundHeight');
    //print('🔼 Vertical Translation Distance: $translationDistance');
    //print('↔️ Horizontal Translation: $horizontalTranslation');
    return GestureDetector(
      onTap: () {
        //  print('🖱 TAP DETECTED - current _clicked state: $_clicked');
        if (!_clicked) {
          //    print('⏩ Starting forward animation');
          _controller.forward();
        } else {
          //    print('⏪ Starting reverse animation');
          _controller.reverse();
        }
        setState(() => _clicked = !_clicked);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.height / 2),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                top: 0,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    //  print('🎞 Background Builder - value: ${_animation.value}');
                    return Transform.translate(
                      offset: Offset(
                          0, -translationDistance * (1 - _animation.value)),
                      child: child!,
                    );
                  },
                  child: _buildBackground(scaleFactor),
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(horizontalTranslation * _animation.value, 0),
                  child: SizedBox(
                    // 👈 Add fixed size container
                    width: widget.iconSize * 1.2,
                    height: widget.iconSize,
                    child: child,
                  ),
                ),
                child: _changeSunToMoon
                    ? _buildMoon(widget.iconSize)
                    : _buildSun(widget.iconSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  final double size;
  final Color color;

  const CircularContainer({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class StarContainer extends StatelessWidget {
  final double size;
  final Color color;
  final int armCount;

  const StarContainer({
    super.key,
    required this.size,
    required this.color,
    required this.armCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: StarPainter(color, armCount)),
    );
  }
}

class StarPainter extends CustomPainter {
  final Color color;
  final int armCount;

  StarPainter(this.color, this.armCount);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final midX = size.width / 2;
    final midY = size.height / 2;
    final radius = size.width / 2;
    final angleIncrement = (2 * math.pi) / armCount;

    final points = List<Offset>.generate(
      armCount * 2,
      (i) {
        final angle = i % 2 == 0
            ? (i ~/ 2) * angleIncrement - math.pi / 2
            : (i ~/ 2) * angleIncrement + angleIncrement / 2 - math.pi / 2;
        final r = i % 2 == 0 ? radius : radius * 0.5;
        return Offset(
          midX + r * math.cos(angle),
          midY + r * math.sin(angle),
        );
      },
    );

    canvas.drawPath(Path()..addPolygon(points, true), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
