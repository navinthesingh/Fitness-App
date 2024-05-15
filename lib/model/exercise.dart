// Exercise is a data class representing an exercise with various attributes.
class Exercise {
  // Unique identifier for the exercise.
  final String id;

  // Name of the exercise.
  final String name;

  // URL pointing to a GIF image demonstrating the exercise.
  final String gifUrl;

  // Target area or muscle group the exercise focuses on.
  final String target;

  // Body part associated with the exercise.
  final String bodyPart;

  // Equipment required for performing the exercise.
  final String equipment;

  // Constructor for creating an Exercise instance with required attributes.
  Exercise({
    required this.id,
    required this.name,
    required this.gifUrl,
    required this.target,
    required this.bodyPart,
    required this.equipment,
  });

  // Factory method to create an Exercise instance from a JSON map.
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      gifUrl: json['gifUrl'],
      target: json['target'],
      bodyPart: json['bodyPart'],
      equipment: json['equipment'],
    );
  }
}
