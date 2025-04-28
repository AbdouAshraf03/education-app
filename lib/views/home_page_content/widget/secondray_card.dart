import 'package:flutter/material.dart';

class SecondaryCard extends StatefulWidget {
  const SecondaryCard({
    required this.routeName,
    super.key,
    required this.title,
    required this.imageUrl,
  });

  final String routeName;
  final String title;
  final String imageUrl;

  @override
  State<SecondaryCard> createState() => _SecondaryCardState();
}

class _SecondaryCardState extends State<SecondaryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageOpacity;
  late Animation<Offset> _imageOffset;
  late Animation<double> _buttonOpacity;
  late Animation<Offset> _buttonOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Image animation (starts immediately)
    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    _imageOffset = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    // Button animation (starts after image animation)
    _buttonOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _buttonOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String nameOfRoute = widget.routeName;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: 310,
      child: Stack(
        children: <Widget>[
          // Image Container with separate animation
          SlideTransition(
            position: _imageOffset,
            child: FadeTransition(
              opacity: _imageOpacity,
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Button with separate animation
          Center(
            child: Column(
              children: [
                const Spacer(),
                SlideTransition(
                  position: _buttonOffset,
                  child: FadeTransition(
                    opacity: _buttonOpacity,
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.lightBlue],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            nameOfRoute,
                            arguments: widget.title,
                          );
                        },
                        child: Text(
                          widget.title,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'vip_hala',
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 45)
              ],
            ),
          )
        ],
      ),
    );
  }
}
