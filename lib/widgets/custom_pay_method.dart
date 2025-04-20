import 'package:flutter/material.dart';

class CustomPayMethod extends StatelessWidget {
  const CustomPayMethod(
      {super.key, required this.icon, required this.title, this.onPressed});
  final String title;
  final Widget icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 120,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1C71C2),
            Color(0xFF5BAFFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).primaryColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
