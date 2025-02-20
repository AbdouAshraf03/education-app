import 'package:flutter/material.dart';

class DepartmentsCard extends StatelessWidget {
  const DepartmentsCard(
      {super.key,
      required this.title,
      // required this.routeName,
      required this.imageUrl});
  final String title;
  // final String routeName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(149, 0, 0, 0),
            blurRadius: 10,
            offset: Offset(0, 8),
          )
        ],
      ),
    );
  }
}
