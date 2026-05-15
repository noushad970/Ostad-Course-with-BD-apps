import 'dart:io';

void main() {
  List<Map<String, dynamic>> students = [];
  Set<String> contactNumbers = {};

  stdout.write("How many students do you want to add? ");
  int totalStudents = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= totalStudents; i++) {
    print("\nEnter information for Student $i");

    stdout.write("Name: ");
    String name = stdin.readLineSync()!;

    stdout.write("Details/About: ");
    String details = stdin.readLineSync()!;

    stdout.write("Present Address: ");
    String presentAddress = stdin.readLineSync()!;

    stdout.write("Permanent Address: ");
    String permanentAddress = stdin.readLineSync()!;

    String contact;
    while (true) {
      stdout.write("Contact Number: ");
      contact = stdin.readLineSync()!;

      if (!contactNumbers.contains(contact)) {
        contactNumbers.add(contact);
        break;
      } else {
        print("This contact number already exists. Enter a unique number.");
      }
    }

    stdout.write("Age: ");
    int age = int.parse(stdin.readLineSync()!);

    Map<String, dynamic> student = {
      "Name": name,
      "Details": details,
      "Present Address": presentAddress,
      "Permanent Address": permanentAddress,
      "Contact Number": contact,
      "Age": age
    };

    students.add(student);
  }

  print("\nAll Student Information:");

  for (int i = 0; i < students.length; i++) {
    print("\nStudent ${i + 1}:");
    students[i].forEach((key, value) {
      print("$key: $value");
    });
  }
}
