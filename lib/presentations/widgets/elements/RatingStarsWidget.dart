import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color color;

  const RatingStars({
    Key? key,
    required this.rating,
    this.starSize = 16.0,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: color, size: starSize);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: color, size: starSize);
        } else {
          return Icon(Icons.star_border, color: color, size: starSize);
        }
      }),
    );
  }
}
