import 'package:flutter/material.dart';
import 'package:smart_fitness_application/controller/exercise_controller.dart';
import 'package:smart_fitness_application/model/selected_exercise.dart';
import 'exercise_list.dart';

class ExerciseSelectionPage extends StatefulWidget {
  @override
  _ExerciseSelectionPageState createState() => _ExerciseSelectionPageState();
}

class _ExerciseSelectionPageState extends State<ExerciseSelectionPage> {
  final ExerciseController exerciseController = ExerciseController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // If debugging put true
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exercise List'),
          centerTitle: true,
        ),
        body: ExerciseListPage(
          onExerciseSelected: (exercise, isSelected) {
            if (isSelected) {
              // Add the selected exercise to the Singleton
              SelectedExercises().toggleExerciseSelection(exercise);
            } else {
              // Remove the deselected exercise from the Singleton
              SelectedExercises().toggleExerciseSelection(exercise);
            }
          },
        ),
      ),
    );
  }
}
