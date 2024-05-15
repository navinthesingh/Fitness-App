import 'package:smart_fitness_application/model/exercise.dart';

// DoneExercises is a singleton class responsible for tracking completed exercises and workout duration.
class DoneExercises {
  // Private constructor to ensure a singleton instance.
  DoneExercises._();

  // Singleton instance of DoneExercises.
  static final DoneExercises _instance = DoneExercises._();

  // Factory constructor to return the singleton instance.
  factory DoneExercises() {
    return _instance;
  }

  // List to store details of completed exercises.
  List<Map<String, dynamic>> _doneExercises = [];

  // Variable to track the total workout duration in seconds.
  int _workoutDuration = 0;

  // Getter method to retrieve the list of completed exercises.
  List<Map<String, dynamic>> get doneExercises => _doneExercises;

  // Getter method to retrieve the total workout duration.
  int get workoutDuration => _workoutDuration;

  // Method to add details of a completed exercise including sets and reps.
  void addDoneExercise(Exercise exercise, int sets, int reps) {
    // Create a map to store exercise details.
    Map<String, dynamic> exerciseDetails = {
      'name': exercise.name,
      'equipment': exercise.equipment,
      'target': exercise.target,
      'gifUrl': exercise.gifUrl,
      'sets': sets,
      'reps': reps,
    };

    // Add the exercise details to the list of completed exercises.
    _doneExercises.add(exerciseDetails);
  }

  // Method to update the total workout duration in seconds.
  void updateWorkoutDuration(int seconds) {
    _workoutDuration = seconds;
  }

  // Method to clear the list of completed exercises and reset the duration.
  void clearDoneExercises() {
    _doneExercises.clear();
    _workoutDuration = 0;
    print('Done Exercises Cleared');
  }

  // Method to get exercise details as a map.
  Map<String, dynamic> getExerciseDetails(
      Exercise exercise, int sets, int reps) {
    return {
      'name': exercise.name,
      'equipment': exercise.equipment,
      'target': exercise.target,
      'gifUrl': exercise.gifUrl,
      'sets': sets,
      'reps': reps,
      // 'Date': date,  // Commented out as date is not currently used in the implementation.
    };
  }
}
