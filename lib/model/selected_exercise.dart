import 'package:smart_fitness_application/model/exercise.dart';

// SelectedExercises is a singleton class responsible for managing the list of selected exercises.
class SelectedExercises {
  // List to store selected exercises.
  List<Exercise> _selectedExercises = [];

  // Singleton instance of SelectedExercises.
  static final SelectedExercises _instance = SelectedExercises._internal();

  // Factory constructor to return the singleton instance.
  factory SelectedExercises() {
    return _instance;
  }

  // Private constructor to ensure a singleton instance.
  SelectedExercises._internal();

  // Getter method to retrieve the list of selected exercises.
  List<Exercise> get selectedExercises => _selectedExercises;

  // Method to toggle the selection of an exercise (add or remove from the list).
  void toggleExerciseSelection(Exercise exercise) {
    if (_selectedExercises.contains(exercise)) {
      _selectedExercises.remove(exercise);
    } else {
      _selectedExercises.add(exercise);
    }
  }

  // Method to clear the list of selected exercises.
  void clearSelectedExercises() {
    _selectedExercises.clear();
  }
}
