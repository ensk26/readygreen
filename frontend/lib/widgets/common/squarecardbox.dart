import 'package:flutter/material.dart';

class SquareCardBox extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color textColor;
  final String? imageUrl;
  final Color subtitleColor;
  final Widget? child;

  const SquareCardBox({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.backgroundGradient,
    this.textColor = Colors.black,
    this.imageUrl,
    this.subtitleColor = Colors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth / 3,
      height: deviceWidth / 2.4,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        color: backgroundGradient == null ? backgroundColor : null,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 아이템 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                // fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            if (imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 1.2),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imageUrl!,
                    // width: deviceWidth / 4.6,
                    height: deviceWidth / 3.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
