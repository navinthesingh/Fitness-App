import 'package:flutter/material.dart';
import 'package:smart_fitness_application/model/firestore_workout_history.dart';

// This class is rsponsible for displaying the workout history page of the application
class WorkoutHistoryPage extends StatefulWidget {
  @override
  _WorkoutHistoryPageState createState() => _WorkoutHistoryPageState();
}

class _WorkoutHistoryPageState extends State<WorkoutHistoryPage> {
  final WorkoutHistoryService _workoutHistoryService = WorkoutHistoryService();
  List<Map<String, dynamic>> workoutDataList = [];

  @override
  void initState() {
    super.initState();
    _loadWorkoutData();
  }

  Future<void> _loadWorkoutData() async {
    try {
      // Fetch workout data from Firebase
      List<Map<String, dynamic>> initialData =
          await _workoutHistoryService.getWorkoutData();

      // Sort the data based on 'workoutDate'
      initialData.sort((a, b) => b['workoutDate'].compareTo(a['workoutDate']));

      // Update the state with the initial data
      setState(() {
        workoutDataList = initialData;
      });
    } catch (e) {
      // Handle any errors that occur during the initial data load
      print('Error loading workout data: $e');
    }
  }

  Future<void> _refresh() async {
    try {
      // Fetch new workout data from Firebase
      List<Map<String, dynamic>> refreshedData =
          await _workoutHistoryService.getWorkoutData();

      // Sort the refreshed data based on 'workoutDate'
      refreshedData
          .sort((a, b) => b['workoutDate'].compareTo(a['workoutDate']));

      // Update the state with the refreshed data
      setState(() {
        workoutDataList = refreshedData;
      });

      // Show a snackbar or toast to indicate a successful refresh
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Workout history refreshed successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Handle any errors that occur during the refresh process
      print('Error refreshing workout data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error refreshing workout data. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: workoutDataList.isEmpty
          ? Center(child: Text('No workout data available.'))
          : ListView.builder(
              itemCount: workoutDataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> workoutData = workoutDataList[index];
                List<dynamic> exerciseList = workoutData['exerciseList'];

                return ExpansionTile(
                  title: Text('Workout Date: ${workoutData['workoutDate']}'),
                  subtitle: Text('Duration: ${workoutData['duration']}'),
                  children: [
                    for (var exerciseDetails in exerciseList)
                      ListTile(
                        title: Row(
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.lightBlueAccent,
                                  width: 2.0,
                                ),
                              ),
                              child: Image(
                                image: NetworkImage(exerciseDetails['gifUrl']),
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${exerciseDetails['name']}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  'Sets: ${exerciseDetails['sets']}, Reps: ${exerciseDetails['reps']}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons
                                        .fitness_center), // Replace with an appropriate icon
                                    Text(
                                      '${exerciseDetails['equipment']}',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons
                                        .accessibility), // Replace with an appropriate icon
                                    Text(
                                      '${exerciseDetails['target']}',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
