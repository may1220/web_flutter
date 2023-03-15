import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testing_app/testing_ui_pages/home_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage(
          {required Color color,
          required String urlImage,
          required String title,
          required String subtitle}) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
                color: Colors.green.shade100,
                urlImage: 'assets/photo1.jfif',
                title: "REDUCE",
                subtitle: "This site can’t be reached"),
            buildPage(
                color: Colors.blue.shade100,
                urlImage: 'assets/photo2.jfif',
                title: "REDUCE",
                subtitle: "This site can’t be reached"),
            buildPage(
                color: Colors.red.shade100,
                urlImage: 'assets/photo3.jfif',
                title: "REDUCE",
                subtitle: "This site can’t be reached"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: (() async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              }),
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 24),
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color.fromARGB(255, 8, 8, 8),
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(80)),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text('SKIP')),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                      child: Text('NEXT'))
                ],
              ),
            ),
    );
  }
}
