import 'package:flutter/material.dart';

class LabelCard extends StatelessWidget {
  const LabelCard(
    this.text, {
    this.icon,
    super.key,
  });
  final String text;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(
                icon,
                size: 15,
                color: Colors.white,
              ),
            ),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
