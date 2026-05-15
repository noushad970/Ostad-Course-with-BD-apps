import 'dart:io';

// ─── Grade model ────────────────────────────────────────────────────────────

class Student {
  final String name;
  final double mark;

  Student(this.name, this.mark);

  String get grade {
    if (mark >= 90) return 'A+';
    if (mark >= 80) return 'A';
    if (mark >= 70) return 'B';
    if (mark >= 60) return 'C';
    if (mark >= 50) return 'D';
    return 'F';
  }

  String get status => mark >= 50 ? 'PASS' : 'FAIL';

  String get remark {
    if (mark >= 90) return 'Excellent';
    if (mark >= 80) return 'Very Good';
    if (mark >= 70) return 'Good';
    if (mark >= 60) return 'Average';
    if (mark >= 50) return 'Below Average';
    return 'Fail';
  }
}

// ─── Styling helpers ─────────────────────────────────────────────────────────

const _reset  = '\x1B[0m';
const _bold   = '\x1B[1m';
const _cyan   = '\x1B[96m';
const _green  = '\x1B[92m';
const _yellow = '\x1B[93m';
const _red    = '\x1B[91m';
const _blue   = '\x1B[94m';
const _gray   = '\x1B[90m';

String colored(String text, String color) => '$color$text$_reset';
String bold(String text)                  => '$_bold$text$_reset';

String gradeColor(String grade) {
  switch (grade) {
    case 'A+': return _green;
    case 'A':  return _green;
    case 'B':  return _cyan;
    case 'C':  return _yellow;
    case 'D':  return _yellow;
    default:   return _red;
  }
}

// ─── Display helpers ─────────────────────────────────────────────────────────

void printBanner() {
  print('');
  print(colored('╔══════════════════════════════════════════════════╗', _cyan));
  print(colored('║', _cyan) +
        bold(colored('       🎓  STUDENT SCORE CALCULATOR              ', _blue)) +
        colored('║', _cyan));
  print(colored('╚══════════════════════════════════════════════════╝', _cyan));
  print('');
}

void printSeparator({String char = '─', int width = 52, String color = _gray}) {
  print(colored(char * width, color));
}

void printTableHeader() {
  print('');
  printSeparator(char: '═', color: _cyan);
  print(
    colored('  #', _gray) +
    '  ' +
    bold('Name'.padRight(20)) +
    bold('Mark'.padRight(8)) +
    bold('Grade'.padRight(8)) +
    bold('Status'.padRight(10)) +
    bold('Remark'),
  );
  printSeparator(char: '─', color: _gray);
}

void printStudentRow(int index, Student s) {
  final gc   = gradeColor(s.grade);
  final sc   = s.status == 'PASS' ? _green : _red;
  final name = s.name.length > 18
      ? '${s.name.substring(0, 17)}…'
      : s.name;

  print(
    colored('  ${index.toString().padLeft(2)}', _gray) +
    '  ' +
    name.padRight(20) +
    colored(s.mark.toStringAsFixed(1).padRight(8), _cyan) +
    colored(s.grade.padRight(8), gc) +
    colored(s.status.padRight(10), sc) +
    colored(s.remark, _gray),
  );
}

void printSummary(List<Student> students) {
  if (students.isEmpty) return;

  final marks   = students.map((s) => s.mark).toList();
  final avg     = marks.reduce((a, b) => a + b) / marks.length;
  final highest = marks.reduce((a, b) => a > b ? a : b);
  final lowest  = marks.reduce((a, b) => a < b ? a : b);
  final passed  = students.where((s) => s.status == 'PASS').length;
  final failed  = students.length - passed;

  final topStudent = students.firstWhere((s) => s.mark == highest);

  printSeparator(char: '═', color: _cyan);
  print('');
  print(bold(colored('  📊  Summary', _blue)));
  print('');
  print('  ${colored('Total Students :', _gray)}  ${students.length}');
  print('  ${colored('Average Mark   :', _gray)}  ${colored(avg.toStringAsFixed(2), _cyan)}');
  print('  ${colored('Highest Mark   :', _gray)}  ${colored(highest.toStringAsFixed(1), _green)}  (${topStudent.name})');
  print('  ${colored('Lowest Mark    :', _gray)}  ${colored(lowest.toStringAsFixed(1), _red)}');
  print('  ${colored('Passed         :', _gray)}  ${colored(passed.toString(), _green)}');
  print('  ${colored('Failed         :', _gray)}  ${colored(failed.toString(), _red)}');
  print('');
  printSeparator(char: '─', color: _gray);

  // Grade distribution bar
  print('');
  print(bold(colored('  📈  Grade Distribution', _blue)));
  print('');
  final gradeCounts = <String, int>{};
  for (final s in students) {
    gradeCounts[s.grade] = (gradeCounts[s.grade] ?? 0) + 1;
  }
  for (final grade in ['A+', 'A', 'B', 'C', 'D', 'F']) {
    final count = gradeCounts[grade] ?? 0;
    final bar   = '█' * count;
    final gc    = gradeColor(grade);
    print('  ${grade.padRight(4)} ${colored(bar.padRight(students.length), gc)} $count');
  }
  print('');
  printSeparator(char: '═', color: _cyan);
  print('');
}

// ─── Input helpers ────────────────────────────────────────────────────────────

String prompt(String message) {
  stdout.write(message);
  return stdin.readLineSync()?.trim() ?? '';
}

double? parseScore(String input) {
  final score = double.tryParse(input);
  if (score == null) return null;
  if (score < 0 || score > 100) return null;
  return score;
}

// ─── Main ─────────────────────────────────────────────────────────────────────

void main() {
  printBanner();

  final students = <Student>[];

  print(colored('  Grade Scale:', _gray));
  print(colored('  90–100 → A+   80–89 → A   70–79 → B', _gray));
  print(colored('  60–69  → C    50–59 → D   0–49  → F', _gray));
  print('');
  print(colored('  Type "${bold("done")}" as a name to finish and see results.', _gray));
  print('');
  printSeparator();

  int count = 1;
  while (true) {
    print('');
    final name = prompt(colored('  Student $count Name : ', _cyan));

    if (name.toLowerCase() == 'done' || name.isEmpty && students.isNotEmpty) {
      if (students.isEmpty) {
        print(colored('\n  ⚠  No students entered. Exiting.\n', _yellow));
        return;
      }
      break;
    }

    if (name.isEmpty) {
      print(colored('  ✖  Name cannot be empty. Try again.', _red));
      continue;
    }

    double? score;
    while (score == null) {
      final input = prompt(colored('  Mark (0–100)       : ', _cyan));
      score = parseScore(input);
      if (score == null) {
        print(colored('  ✖  Enter a valid number between 0 and 100.', _red));
      }
    }

    students.add(Student(name, score));
    final s = students.last;
    print(
      colored('  ✔  ', _green) +
      bold(name) +
      colored(' → Grade: ', _gray) +
      colored(bold(s.grade), gradeColor(s.grade)) +
      colored(' (${s.remark})', _gray),
    );
    count++;
  }

  printTableHeader();
  for (var i = 0; i < students.length; i++) {
    printStudentRow(i + 1, students[i]);
  }

  printSummary(students);
}
