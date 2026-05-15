import 'dart:io';
import '../lib/student_calculator.dart';

class StudentScoreCalculatorCLI {
  final StudentManager manager = StudentManager();

  /// Display main menu
  void showMainMenu() {
    print('\n' + '=' * 60);
    print('🎓 STUDENT SCORE CALCULATOR APP');
    print('=' * 60);
    print('1. Add Student');
    print('2. Add Score to Student');
    print('3. View Student Details');
    print('4. View All Students');
    print('5. View Class Statistics');
    print('6. View Grade Distribution');
    print('7. Remove Student');
    print('8. Clear All Students');
    print('9. Exit');
    print('=' * 60);
  }

  /// Add a new student
  void addStudent() {
    print('\n--- Add Student ---');
    stdout.write('Enter Student ID: ');
    String? id = stdin.readLineSync();
    if (id == null || id.isEmpty) {
      print('❌ Error: Student ID cannot be empty');
      return;
    }

    stdout.write('Enter Student Name: ');
    String? name = stdin.readLineSync();
    if (name == null || name.isEmpty) {
      print('❌ Error: Student Name cannot be empty');
      return;
    }

    try {
      manager.addStudent(id, name);
      print('✅ Student added successfully: $name (ID: $id)');
    } catch (e) {
      print('❌ Error: $e');
    }
  }

  /// Add score to a student
  void addScoreToStudent() {
    print('\n--- Add Score to Student ---');
    stdout.write('Enter Student ID: ');
    String? studentId = stdin.readLineSync();
    if (studentId == null || studentId.isEmpty) {
      print('❌ Error: Student ID cannot be empty');
      return;
    }

    Student? student = manager.getStudent(studentId);
    if (student == null) {
      print('❌ Error: Student not found');
      return;
    }

    stdout.write('Enter Subject Name: ');
    String? subject = stdin.readLineSync();
    if (subject == null || subject.isEmpty) {
      print('❌ Error: Subject cannot be empty');
      return;
    }

    stdout.write('Enter Score (0-100): ');
    String? scoreInput = stdin.readLineSync();
    double? score = double.tryParse(scoreInput ?? '');
    if (score == null) {
      print('❌ Error: Invalid score. Please enter a number');
      return;
    }

    stdout.write('Enter Weight/Percentage (0-100): ');
    String? weightInput = stdin.readLineSync();
    double? weight = double.tryParse(weightInput ?? '');
    if (weight == null) {
      print('❌ Error: Invalid weight. Please enter a number');
      return;
    }

    try {
      manager.addScoreToStudent(studentId, subject, score, weight);
      print('✅ Score added successfully!');
      print('   Subject: $subject');
      print('   Score: ${score.toStringAsFixed(2)}/100');
      print('   Weight: ${weight.toStringAsFixed(2)}%');
    } catch (e) {
      print('❌ Error: $e');
    }
  }

  /// View details of a specific student
  void viewStudentDetails() {
    print('\n--- View Student Details ---');
    stdout.write('Enter Student ID: ');
    String? studentId = stdin.readLineSync();
    if (studentId == null || studentId.isEmpty) {
      print('❌ Error: Student ID cannot be empty');
      return;
    }

    Student? student = manager.getStudent(studentId);
    if (student == null) {
      print('❌ Error: Student not found');
      return;
    }

    print('\n📊 Student Information');
    print('-' * 50);
    print('Name: ${student.name}');
    print('ID: ${student.id}');
    print(
        'Total Score: ${student.calculateTotalScore().toStringAsFixed(2)}/100');
    print('Grade: ${student.getGrade(student.calculateTotalScore())}');
    print(
        'GPA: ${student.calculateGPA(student.calculateTotalScore()).toStringAsFixed(2)}/4.0');
    print('-' * 50);

    if (student.getSubjects().isEmpty) {
      print('No scores recorded yet.');
      return;
    }

    print('\n📝 Subject-wise Scores:');
    print('-' * 50);
    for (String subject in student.getSubjects()) {
      Map<String, dynamic> stats = student.getSubjectStatistics(subject);
      print('Subject: $subject');
      print('  Score: ${stats['score'].toStringAsFixed(2)}/100');
      print('  Grade: ${stats['grade']}');
      print('  GPA: ${stats['gpa'].toStringAsFixed(2)}');
      print('  Weight: ${stats['weight'].toStringAsFixed(2)}%');
      print('');
    }
  }

  /// View all students
  void viewAllStudents() {
    print('\n--- All Students ---');
    if (manager.students.isEmpty) {
      print('❌ No students found');
      return;
    }

    print('\n');
    print('-' * 80);
    print('Name                 | ID         | Score | Grade | GPA');
    print('-' * 80);

    List<Student> sortedStudents = manager.getStudentsByScore();
    for (var student in sortedStudents) {
      double avgScore = student.calculateTotalScore();
      String grade = student.getGrade(avgScore);
      double gpa = student.calculateGPA(avgScore);
      print(
          '${student.name.padRight(20)} | ${student.id.padRight(10)} | ${avgScore.toStringAsFixed(2).padRight(6)} | ${grade.padRight(5)} | ${gpa.toStringAsFixed(2)}');
    }
    print('-' * 80);
  }

  /// View class statistics
  void viewClassStatistics() {
    print('\n--- Class Statistics ---');
    if (manager.students.isEmpty) {
      print('❌ No students found');
      return;
    }

    double classAverage = manager.getClassAverage();
    Student? topStudent = manager.getTopStudent();
    Student? bottomStudent = manager.getBottomStudent();

    print('\n📈 Class Overview');
    print('-' * 50);
    print('Total Students: ${manager.students.length}');
    print('Class Average: ${classAverage.toStringAsFixed(2)}/100');
    print('-' * 50);

    if (topStudent != null) {
      print('\n🏆 Top Student');
      print('   Name: ${topStudent.name}');
      print(
          '   Score: ${topStudent.calculateTotalScore().toStringAsFixed(2)}/100');
      print(
          '   Grade: ${topStudent.getGrade(topStudent.calculateTotalScore())}');
    }

    if (bottomStudent != null) {
      print('\n📉 Bottom Student');
      print('   Name: ${bottomStudent.name}');
      print(
          '   Score: ${bottomStudent.calculateTotalScore().toStringAsFixed(2)}/100');
      print(
          '   Grade: ${bottomStudent.getGrade(bottomStudent.calculateTotalScore())}');
    }

    print('\n');
    print('-' * 50);
    print('Subject-wise Class Average:');
    print('-' * 50);

    // Get all unique subjects
    Set<String> allSubjects = {};
    for (var student in manager.getAllStudents()) {
      allSubjects.addAll(student.getSubjects());
    }

    if (allSubjects.isEmpty) {
      print('No subject data available');
    } else {
      for (String subject in allSubjects) {
        double avg = manager.getSubjectAverage(subject);
        print('$subject: ${avg.toStringAsFixed(2)}/100');
      }
    }
  }

  /// View grade distribution
  void viewGradeDistribution() {
    print('\n--- Grade Distribution ---');
    if (manager.students.isEmpty) {
      print('❌ No students found');
      return;
    }

    Map<String, int> distribution = manager.getGradeDistribution();

    print('\n');
    print('-' * 50);
    print('Grade | Count | Percentage');
    print('-' * 50);

    int totalStudents = manager.students.length;
    for (String grade in ['A', 'B', 'C', 'D', 'F']) {
      int count = distribution[grade] ?? 0;
      double percentage = totalStudents > 0 ? (count / totalStudents) * 100 : 0;
      String bar = '█' * (count);
      print('$grade    | $count     | ${percentage.toStringAsFixed(1)}% $bar');
    }
    print('-' * 50);
  }

  /// Remove a student
  void removeStudent() {
    print('\n--- Remove Student ---');
    stdout.write('Enter Student ID to remove: ');
    String? studentId = stdin.readLineSync();
    if (studentId == null || studentId.isEmpty) {
      print('❌ Error: Student ID cannot be empty');
      return;
    }

    stdout.write('Are you sure? (yes/no): ');
    String? confirm = stdin.readLineSync();
    if (confirm != null && confirm.toLowerCase() == 'yes') {
      if (manager.removeStudent(studentId)) {
        print('✅ Student removed successfully');
      } else {
        print('❌ Error: Student not found');
      }
    } else {
      print('Operation cancelled');
    }
  }

  /// Clear all students
  void clearAllStudents() {
    print('\n--- Clear All Students ---');
    stdout.write('Are you sure you want to delete all students? (yes/no): ');
    String? confirm = stdin.readLineSync();
    if (confirm != null && confirm.toLowerCase() == 'yes') {
      manager.clearAllStudents();
      print('✅ All students cleared');
    } else {
      print('Operation cancelled');
    }
  }

  /// Run the CLI application
  void run() {
    bool isRunning = true;
    while (isRunning) {
      showMainMenu();
      stdout.write('Enter your choice (1-9): ');
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          addStudent();
          break;
        case '2':
          addScoreToStudent();
          break;
        case '3':
          viewStudentDetails();
          break;
        case '4':
          viewAllStudents();
          break;
        case '5':
          viewClassStatistics();
          break;
        case '6':
          viewGradeDistribution();
          break;
        case '7':
          removeStudent();
          break;
        case '8':
          clearAllStudents();
          break;
        case '9':
          print('\n👋 Thank you for using Student Score Calculator. Goodbye!');
          isRunning = false;
          break;
        default:
          print('❌ Invalid choice. Please enter a number between 1 and 9');
      }
    }
  }
}

void main() {
  StudentScoreCalculatorCLI app = StudentScoreCalculatorCLI();
  app.run();
}
