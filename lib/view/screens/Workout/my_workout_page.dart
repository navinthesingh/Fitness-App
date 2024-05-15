import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fitness_application/model/exercise.dart';
import 'package:smart_fitness_application/model/selected_exercise.dart';
import 'package:smart_fitness_application/view/screens/Workout/start_workout_page.dart';

class MyWorkoutPage extends StatelessWidget {
  final SelectedExercises selectedExercises =
      SelectedExercises(); // Singleton instance

  @override
  Widget build(BuildContext context) {
    List<Exercise> exercises = selectedExercises.selectedExercises;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Workout'),
        centerTitle: true,
      ),
      body: exercises.isEmpty
          ? Center(
              child: Text('No exercises selected'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.lightBlueAccent,
                                  width: 2.0,
                                ),
                              ),
                              child: Image(
                                image: NetworkImage(exercise.gifUrl),
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise.name,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.fitness_center),
                                      Text(
                                        exercise.equipment,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.accessibility),
                                      Text(
                                        exercise.target,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedExercises.selectedExercises.isEmpty) {
                          // If it's empty, do nothing or display a message
                          print("No exercises selected");
                        } else {
                          try {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => StartWorkoutPage(
                                  selectedExercises: exercises,
                                  defaultReps: 10,
                                  defaultSets: 3,
                                ),
                              ),
                            );
                          } catch (e, stackTrace) {
                            // Handle exceptions here
                            print("Error navigating to StartWorkoutPage: $e");
                            print("StackTrace: $stackTrace");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                      ),
                      child: Text(
                        'START',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
