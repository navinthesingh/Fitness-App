import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fitness_application/model/exercise.dart';
import 'package:smart_fitness_application/model/done_exercise.dart';
import 'package:smart_fitness_application/view/screens/Workout/cancel_workout_page.dart';
import 'package:smart_fitness_application/model/firestore_workout_service.dart';

import 'dart:async';

import 'package:smart_fitness_application/view/screens/Workout/workout_success_page.dart';

class StartWorkoutPage extends StatefulWidget {
  final List<Exercise> selectedExercises;
  final int defaultSets;
  final int defaultReps;

  StartWorkoutPage({
    required this.selectedExercises,
    required this.defaultSets,
    required this.defaultReps,
  });

  @override
  _StartWorkoutPageState createState() => _StartWorkoutPageState();
}

class _StartWorkoutPageState extends State<StartWorkoutPage> {
  int currentExerciseIndex = 0;
  int currentSet = 1;
  int currentReps = 10; // Default reps
  int secondsElapsed = 0; // Timer variable
  late Timer timer; // Timer instance

  @override
  void initState() {
    super.initState();

    // Start the timer when the widget is initialized
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedExercises.isEmpty ||
        currentExerciseIndex >= widget.selectedExercises.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No Exercises'),
        ),
        body: Center(
          child: Text('No exercises available.'),
        ),
      );
    }

    Exercise currentExercise = widget.selectedExercises[currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Flexible(
            child: Center(
              child: Text(
                '${Duration(seconds: secondsElapsed).toString().split('.').first}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    currentExercise.gifUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentExercise.name,
                            style: TextStyle(fontSize: 24),
                          ),
                          Row(
                            children: [
                              Icon(Icons.fitness_center),
                              Text(
                                currentExercise.equipment,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 16),
                              Icon(Icons.accessibility),
                              Text(
                                currentExercise.target,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Sets: $currentSet',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Reps: $currentReps',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Log the exercise and update the state
                  DoneExercises().addDoneExercise(
                    currentExercise,
                    currentSet,
                    currentReps,
                  );

                  if (currentSet < widget.defaultSets) {
                    // Move to the next set
                    setState(() {
                      currentSet++;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Completed set ${currentSet - 1}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    if (currentExerciseIndex <
                        widget.selectedExercises.length - 1) {
                      // Move to the next exercise
                      setState(() {
                        currentExerciseIndex++;
                        currentSet = 1;
                      });
                    } else {
                      // Completed the workout

                      // Sending to Firestore
                      FirestoreWorkoutService workoutService =
                          FirestoreWorkoutService();

                      // Returns the current date with the time
                      DateTime currentDate = DateTime.now().toLocal();

                      // Formats the date time to only return date
                      String formattedDate =
                          currentDate.toLocal().toString().split(' ')[0];
                      List<String> dateComponents = formattedDate.split('-');
                      String reversedDate = dateComponents.reversed.join('-');

                      String formattedTimer =
                          '${Duration(seconds: secondsElapsed).toString().split('.').first}';

                      workoutService.addExerciseToWorkout(
                        duration: formattedTimer,
                        workoutDate: reversedDate,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Completed set $currentSet'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => WorkoutSuccessPage(),
                        ),
                      );
                      print('Workout Completed');
                      print(DoneExercises().doneExercises); // Log the exercises
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Log',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CancelWorkoutPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  backgroundColor: Color(0xFFD8E5ED),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
