import 'package:flutter/material.dart';

// This code is responsible for the displaying the home page of the application
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingScreen(
                  icon: Icons.fitness_center_rounded,
                  title: "Create Workout",
                  description:
                      "A mobile application that enables users to select exercises and create a workout routine.",
                ),
                OnboardingScreen(
                  icon: Icons.filter_alt,
                  title: "Exercise Filtering",
                  description:
                      "Enable users to select exercises based on the target muscles and available equipment",
                ),
                OnboardingScreen(
                  icon: Icons.track_changes,
                  title: "Workout History Tracking",
                  description:
                      "A tracking system that records the history of completed workouts by the user.",
                ),
              ],
            ),
          ),
          buildDots(),
        ],
      ),
    );
  }

  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3, // Number of pages
        (index) => buildDot(index),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingScreen(
      {required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.black,
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 300,
              child: Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
