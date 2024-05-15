import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_fitness_application/model/exercise.dart';

// ExerciseController is a class responsible for fetching exercise data from an external API.
class ExerciseController {
  // Asynchronous method to fetch a list of Exercise objects from the external API.
  Future<List<Exercise>> fetchExercises() async {
    // Defining the URL for the external API.
    final url = Uri.parse('https://exercisedb.p.rapidapi.com/exercises');

    // Headers containing RapidAPI key and host information for making the API request.
    final headers = {
      'X-RapidAPI-Key': '1c8399d40emsh7e3a71b88811a5ap1aeb8bjsn9547a16c5dc1',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };

    // Making an HTTP GET request to the API with the specified URL and headers.
    final response = await http.get(url, headers: headers);

    // Checking if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // Parsing the JSON response into a list of dynamic objects.
      final data = jsonDecode(response.body) as List<dynamic>;

      // Mapping the dynamic objects to a list of Exercise objects using the Exercise.fromJson factory method.
      final List<Exercise> exercises =
          data.map((exercise) => Exercise.fromJson(exercise)).toList();

      // Returning the list of Exercise objects.
      return exercises;
    } else {
      // Throwing an exception if the API request fails, including the status code.
      throw Exception(
          'Failed to fetch exercise data. Status code: ${response.statusCode}');
    }
  }
}
