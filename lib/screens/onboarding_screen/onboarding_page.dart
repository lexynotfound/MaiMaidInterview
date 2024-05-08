import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String headline;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.headline,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          width: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        Text(
          headline,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
            wordSpacing: 1.0,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
