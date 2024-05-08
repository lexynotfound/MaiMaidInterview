import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:maimaid_interview/screens/onboarding_screen/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/user/users_bloc.dart';
import '../../screens/home_screen/home_screen.dart';

class OnboardingScreenState extends StatefulWidget {
  const OnboardingScreenState({super.key});

  @override
  State<OnboardingScreenState> createState() => _OnboardingScreenStateState();
}

class _OnboardingScreenStateState extends State<OnboardingScreenState> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updatedUI);
  }

  @override
  void dispose() {
    _controller.removeListener(_updatedUI);
    _controller.dispose();
    super.dispose();
  }

  void _updatedUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: 4, // Assuming 4 onboarding pages
              itemBuilder: (_, index) {
                return OnboardingPage(
                  image: 'assets/images/img_${index + 1}.svg',
                  headline: 'Loren Ipsum Sit Amet',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur elit sit amet',
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 4,
            effect: const WormEffect(),
            onDotClicked: (index) {
              _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_controller.page == 3) {
                      // Last page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (_) => UsersBloc(httpClient: http.Client()),
                            child: const HomeScreen(),
                          ),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _controller.page == 3 ? 'Get Started' : 'Next',
                  ),
                ),
                if (_controller.page != 0)
                  TextButton(
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Previous'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
