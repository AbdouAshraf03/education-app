import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';

class MyVideosCard extends StatefulWidget {
  const MyVideosCard(
      {super.key,
      required this.myVideos,
      required this.isPurchased,
      required this.section});
  final Map<String, dynamic> myVideos;
  final bool isPurchased;
  final String section;
  @override
  State<MyVideosCard> createState() => _MyVideosCardState();
}

class _MyVideosCardState extends State<MyVideosCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    widget.myVideos
        .addAll({'isPurchased': widget.isPurchased, 'section': widget.section});
    //print(widget.myVideos);
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start from right side
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                // border:
                //     Border.symmetric(horizontal: BorderSide(color: Colors.grey)),
                // borderRadius: BorderRadius.circular(10),
                // boxShadow: const [
                //   BoxShadow(
                //     color: Colors.black54,
                //     blurRadius: 5,
                //     offset: Offset(2, 4),
                //   )
                // ],
                color: Colors.transparent
                // gradient: LinearGradient(
                //   begin: Alignment.bottomLeft,
                //   end: Alignment.bottomRight,
                //   colors: [Colors.indigo[900]!, Colors.lightBlue[300]!],
                // )
                ),
            margin: const EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width - 20,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.purchasePage,
                    arguments: widget.myVideos);
              },
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.myVideos['title'] ?? ''}',
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '( ${widget.myVideos['long_of_vid']} ) عدد الساعات',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                '( ${widget.myVideos['no_of_vid']} ) رقم الحصه ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 120,
                    height: 80,
                    //margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: Colors.black54,
                      //     blurRadius: 5,
                      //     offset: Offset(5, 10),
                      //   )
                      // ],
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(widget.myVideos['image_url'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).primaryIconTheme.color,
          )
        ],
      ),
    );
  }
}
