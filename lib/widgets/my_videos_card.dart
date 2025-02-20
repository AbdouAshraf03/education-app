import 'package:flutter/material.dart';

class MyVideosCard extends StatefulWidget {
  MyVideosCard({super.key});

  @override
  State<MyVideosCard> createState() => _MyVideosCardState();
}

class _MyVideosCardState extends State<MyVideosCard>
    with SingleTickerProviderStateMixin {
  final Map<String, dynamic> myVideos = {
    'title':
        'ديناميكا التكنولوجيا الإلكترونية في الأداء البيئي والإنتاج البيئي',
    'number_of_hours': 6,
    'number_of_video': 3,
    'imageurl':
        'https://www.edutrapedia.com/resources/thumbs/article_photos/Noj7cPv62g-571.jpg_729x410.jpg'
  };

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Start from right side
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
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
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border:
                Border.symmetric(horizontal: BorderSide(color: Colors.grey)),
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
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 20,
        child: MaterialButton(
          onPressed: () {},
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
                      '${myVideos['title']!}',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '( ${myVideos['number_of_hours']} ) عدد الساعات',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '( ${myVideos['number_of_video']} ) رقم الحصه ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14),
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
                    image: NetworkImage(myVideos['imageurl']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
