import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/views/home_page_content/widget/departments_card.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class SecondSecondary extends StatelessWidget {
  SecondSecondary({super.key});
  final List<String> titles = [
    "ستاتيكا",
    "ديناميكا",
    "تفاضل و تكامل",
    "جبر",
    "هندسه فراغيه",
  ];

  final List<Widget> images = [
    DepartmentsCard(
      title: 'ستاتيكا',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoJl_vyLvjj1TkeCFiEgme8swZ98reFlhPIQ&s',
    ),
    DepartmentsCard(
      title: 'ديناميكا',
      imageUrl:
          'https://media.istockphoto.com/id/518905264/vector/blackboard.jpg?s=612x612&w=0&k=20&c=Q29rc5MoCrRAkimWOwtH4F-WsfbImB7HNi2yrzdBQ7U=',
    ),
    DepartmentsCard(
      imageUrl:
          'https://img.freepik.com/free-vector/hand-drawn-scientific-formulas-chalkboard_23-2148496321.jpg?semt=ais_hybrid',
      title: 'تفاضل و تكامل',
    ),
    DepartmentsCard(
      imageUrl:
          'https://img.goodfon.com/wallpaper/nbig/1/60/blackboard-mathematics-algebra.webp',
      title: 'جبر',
    ),
    DepartmentsCard(
      imageUrl:
          'https://www.edutrapedia.com/resources/thumbs/article_photos/Noj7cPv62g-571.jpg_729x410.jpg',
      title: 'هندسه فراغيه',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الاقسام",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).primaryIconTheme.color,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: VerticalCardPager(
                  width: MediaQuery.of(context).size.width - 30,
                  titles: titles, // required
                  images: images, // required
                  textStyle: TextStyle(
                    // decorationStyle: TextDecorationStyle.wavy,
                    // decorationThickness: 20,
                    fontFamily: 'vip_hala',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(-1.0, -1.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(1.0, -1.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(-1.0, 1.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                    //fontWeight: FontWeight.bold,
                  ), // optional
                  onPageChanged: (page) {
                    // optional
                  },
                  onSelectedItem: (index) {
                    // optional
                  },
                  initialPage: 2, // optional
                  align: ALIGN.CENTER, // optional
                  physics: ClampingScrollPhysics() // optional
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
