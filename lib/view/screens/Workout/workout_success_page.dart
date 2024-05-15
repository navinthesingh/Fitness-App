import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fitness_application/view/screens/Workout/workout_page.dart';

class WorkoutSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Workout Completed',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to the Manual Selection page.
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => WorkoutPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'Back to Workout Page',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
