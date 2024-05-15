import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_fitness_application/controller/exercise_controller.dart';
import 'package:smart_fitness_application/model/exercise.dart';
import 'package:smart_fitness_application/model/enums.dart';
import 'package:smart_fitness_application/view/screens/Workout/selected_workout_page.dart';

class ExerciseListPage extends StatefulWidget {
  final Function(Exercise, bool) onExerciseSelected;

  ExerciseListPage({
    required this.onExerciseSelected,
  });

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  List<Exercise> exercises = [];
  final ExerciseController _exerciseController = ExerciseController();
  TextEditingController _searchController = TextEditingController();
  List<Exercise> filteredExercises = [];
  List<Exercise> selectedExercises = [];

  final TextEditingController targetMuscleController = TextEditingController();
  TargetMuscle? selectedMuscle;
  final TextEditingController equipmentController = TextEditingController();
  Equipment? selectedEquipment;

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      final List<Exercise> fetchedExercises =
          await _exerciseController.fetchExercises();
      setState(() {
        exercises = fetchedExercises;
        filteredExercises = exercises;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _filterExercises(String query) {
    setState(() {
      filteredExercises = exercises
          .where((exercise) =>
              exercise.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  String mapEquipmentToString(Equipment equipment) {
    if (equipment == Equipment.bodyWeight) {
      return 'body weight';
    }
    return equipment.toString().split('.').last.toLowerCase();
  }

  void _filterExercisesManual({TargetMuscle? muscle, Equipment? equipment}) {
    setState(() {
      selectedMuscle = muscle;
      selectedEquipment = equipment;

      filteredExercises = exercises.where((exercise) {
        final exerciseMuscle = exercise.target;
        final exerciseEquipment = exercise.equipment;

        final selectedMuscleLower =
            muscle?.toString().split('.').last.toLowerCase();

        final selectedEquipmentLower =
            equipment != null ? mapEquipmentToString(equipment) : null;

        // Check if the exercise matches the selected muscle or equipment
        return (selectedMuscleLower == null ||
                exerciseMuscle == selectedMuscleLower) &&
            (selectedEquipmentLower == null ||
                exerciseEquipment == selectedEquipmentLower);
      }).toList();
    });
  }

  Future<void> _toggleExerciseSelection(Exercise exercise) async {
    setState(() {
      if (selectedExercises.contains(exercise)) {
        selectedExercises.remove(exercise);
      } else {
        selectedExercises.add(exercise);
      }
    });

    printSelectedExercises();
  }

  void printSelectedExercises() {
    print("Selected Exercises:");
    for (var exercise in selectedExercises) {
      print("Name: ${exercise.name}");
      print("Equipment: ${exercise.equipment}");
      print("Target Muscle: ${exercise.target}");
      print("Gif URL: ${exercise.gifUrl}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterExercises(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for exercises',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  DropdownMenu<TargetMuscle>(
                    initialSelection: selectedMuscle,
                    controller: targetMuscleController,
                    requestFocusOnTap: true,
                    label: const Text('Target Muscle'),
                    onSelected: (TargetMuscle? muscle) {
                      _filterExercisesManual(
                          muscle: muscle != null && muscle == TargetMuscle.all
                              ? null
                              : muscle,
                          equipment: selectedEquipment);
                    },
                    dropdownMenuEntries: TargetMuscle.values
                        .map<DropdownMenuEntry<TargetMuscle>>((muscle) {
                      return DropdownMenuEntry<TargetMuscle>(
                        value: muscle,
                        label: muscle.toString().split('.').last.toLowerCase(),
                        enabled: true,
                      );
                    }).toList(),
                  ),
                  DropdownMenu<Equipment>(
                    initialSelection: selectedEquipment,
                    controller: equipmentController,
                    requestFocusOnTap: true,
                    label: const Text('Equipment'),
                    onSelected: (Equipment? equipment) {
                      _filterExercisesManual(
                          muscle: selectedMuscle,
                          equipment:
                              equipment != null && equipment == Equipment.all
                                  ? null
                                  : equipment);
                    },
                    dropdownMenuEntries: Equipment.values
                        .map<DropdownMenuEntry<Equipment>>((equipment) {
                      return DropdownMenuEntry<Equipment>(
                        value: equipment,
                        label:
                            equipment.toString().split('.').last.toLowerCase(),
                        enabled: true,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
                final isSelected = selectedExercises.contains(exercise);

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Card(
                      color: isSelected ? Colors.grey : null,
                      child: ListTile(
                        onTap: () {
                          _toggleExerciseSelection(exercise);
                          widget.onExerciseSelected(exercise, !isSelected);
                        },
                        leading: Container(
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
                        title: Column(
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
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            _toggleExerciseSelection(exercise);
                            widget.onExerciseSelected(exercise, !isSelected);
                          },
                        ),
                      ),
                    ),
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
                onPressed: selectedExercises.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SelectedWorkoutPage()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text(
                  'Selected Exercises',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
