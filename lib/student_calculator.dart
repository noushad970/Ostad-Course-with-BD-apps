/// Student class to hold student information and scores
class Student {
  final String id;
  final String name;
  final Map<String, double> scores; // subject -> score
  final Map<String, double> weights; // subject -> weight percentage

  Student({
    required this.id,
    required this.name,
    Map<String, double>? scores,
    Map<String, double>? weights,
  })  : scores = scores ?? {},
        weights = weights ?? {};

  /// Calculate total score based on weighted average
  double calculateTotalScore() {
    if (scores.isEmpty || weights.isEmpty) return 0.0;

    double totalWeightedScore = 0.0;
    double totalWeight = 0.0;

    scores.forEach((subject, score) {
      double weight = weights[subject] ?? 0.0;
      totalWeightedScore += score * weight;
      totalWeight += weight;
    });

    if (totalWeight == 0) return 0.0;
    return totalWeightedScore / totalWeight;
  }

  /// Get grade based on score (A, B, C, D, F)
  String getGrade(double score) {
    if (score >= 90) return 'A';
    if (score >= 80) return 'B';
    if (score >= 70) return 'C';
    if (score >= 60) return 'D';
    return 'F';
  }

  /// Calculate GPA (assuming 4.0 scale)
  double calculateGPA(double score) {
    if (score >= 90) return 4.0;
    if (score >= 80) return 3.0;
    if (score >= 70) return 2.0;
    if (score >= 60) return 1.0;
    return 0.0;
  }

  /// Add a score for a subject
  void addScore(String subject, double score, double weight) {
    if (score < 0 || score > 100) {
      throw ArgumentError('Score must be between 0 and 100');
    }
    if (weight < 0 || weight > 100) {
      throw ArgumentError('Weight must be between 0 and 100');
    }
    scores[subject] = score;
    weights[subject] = weight;
  }

  /// Get score for a specific subject
  double? getScore(String subject) {
    return scores[subject];
  }

  /// Get all subject names
  List<String> getSubjects() {
    return scores.keys.toList();
  }

  /// Get subject statistics (average, highest, lowest)
  Map<String, dynamic> getSubjectStatistics(String subject) {
    double? score = scores[subject];
    if (score == null) {
      return {'error': 'Subject not found'};
    }

    return {
      'subject': subject,
      'score': score,
      'grade': getGrade(score),
      'gpa': calculateGPA(score),
      'weight': weights[subject] ?? 0.0,
    };
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, avgScore: ${calculateTotalScore().toStringAsFixed(2)})';
  }
}

/// StudentManager class to manage multiple students
class StudentManager {
  final Map<String, Student> students = {};

  /// Add a new student
  void addStudent(String id, String name) {
    if (students.containsKey(id)) {
      throw ArgumentError('Student with ID $id already exists');
    }
    students[id] = Student(id: id, name: name);
  }

  /// Get a student by ID
  Student? getStudent(String id) {
    return students[id];
  }

  /// Remove a student
  bool removeStudent(String id) {
    return students.remove(id) != null;
  }

  /// Add score for a student
  void addScoreToStudent(
      String studentId, String subject, double score, double weight) {
    Student? student = students[studentId];
    if (student == null) {
      throw ArgumentError('Student not found');
    }
    student.addScore(subject, score, weight);
  }

  /// Get all students
  List<Student> getAllStudents() {
    return students.values.toList();
  }

  /// Get class average
  double getClassAverage() {
    if (students.isEmpty) return 0.0;
    double total = 0.0;
    for (var student in students.values) {
      total += student.calculateTotalScore();
    }
    return total / students.length;
  }

  /// Get top student
  Student? getTopStudent() {
    if (students.isEmpty) return null;
    Student topStudent = students.values.first;
    for (var student in students.values) {
      if (student.calculateTotalScore() > topStudent.calculateTotalScore()) {
        topStudent = student;
      }
    }
    return topStudent;
  }

  /// Get bottom student
  Student? getBottomStudent() {
    if (students.isEmpty) return null;
    Student bottomStudent = students.values.first;
    for (var student in students.values) {
      if (student.calculateTotalScore() < bottomStudent.calculateTotalScore()) {
        bottomStudent = student;
      }
    }
    return bottomStudent;
  }

  /// Get students sorted by score (highest to lowest)
  List<Student> getStudentsByScore() {
    List<Student> sortedStudents = students.values.toList();
    sortedStudents.sort(
        (a, b) => b.calculateTotalScore().compareTo(a.calculateTotalScore()));
    return sortedStudents;
  }

  /// Get subject average across all students
  double getSubjectAverage(String subject) {
    List<double> scores = [];
    for (var student in students.values) {
      double? score = student.getScore(subject);
      if (score != null) {
        scores.add(score);
      }
    }
    if (scores.isEmpty) return 0.0;
    return scores.reduce((a, b) => a + b) / scores.length;
  }

  /// Get grade distribution
  Map<String, int> getGradeDistribution() {
    Map<String, int> distribution = {'A': 0, 'B': 0, 'C': 0, 'D': 0, 'F': 0};
    for (var student in students.values) {
      String grade = student.getGrade(student.calculateTotalScore());
      distribution[grade] = (distribution[grade] ?? 0) + 1;
    }
    return distribution;
  }

  /// Clear all students
  void clearAllStudents() {
    students.clear();
  }
}
