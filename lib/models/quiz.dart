class Quiz extends Comparable<Quiz> {
  final String id;
  final String name;
  final int status;
  final String category;

  Quiz({ required this.id, required this.name, required this.status, required this.category });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json["id"] as String,
      name: json["name"] as String,
      status: json["status"] as int,
      category: json["category"] as String,
    );
  }

  @override
  String toString() {
    return 'Quiz{id: $id, name: $name, status: $status, category: $category }';
  }

  @override
  int compareTo(Quiz other) {
    return this.name.compareTo(other.name);
  }
}