# 🎓 Student Score Calculator - Flutter CLI App

A comprehensive command-line application built with Flutter/Dart to manage and calculate student scores, grades, and class statistics.

## Features

### ✨ Core Features
- **Add Students**: Register new students with unique IDs
- **Record Scores**: Add subject-wise scores with weighted percentages
- **Calculate Grades**: Automatic grade calculation (A, B, C, D, F)
- **GPA Calculation**: Compute GPA on a 4.0 scale based on scores
- **Student Management**: View, update, and remove student records
- **Class Statistics**: Get comprehensive class-wide analytics
- **Grade Distribution**: Visualize grade distribution across the class

### 📊 Analytics & Reporting
- **Individual Student Details**: Complete score breakdown by subject
- **Class Average**: Calculate average performance across all students
- **Top/Bottom Students**: Identify highest and lowest performing students
- **Subject Averages**: View average performance in each subject
- **Grade Distribution**: See how many students fall into each grade category
- **Student Rankings**: Sorted list of students by performance

### 🛡️ Data Management
- **Input Validation**: Validates scores (0-100) and weights
- **Error Handling**: Comprehensive error messages for invalid inputs
- **Data Persistence**: In-memory storage of student records during session
- **Batch Operations**: Clear all records with confirmation

## Installation & Setup

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (included with Flutter)
- Windows, macOS, or Linux

### Project Structure
```
student_score_calculator/
├── bin/
│   └── main.dart          # CLI entry point
├── lib/
│   └── student_calculator.dart  # Core business logic
├── pubspec.yaml           # Project configuration
└── README.md              # This file
```

### Getting Started

1. **Clone or download the project**
   ```
   cd student_score_calculator
   ```

2. **Install dependencies** (if any)
   ```
   flutter pub get
   ```

3. **Run the application**
   ```
   dart bin/main.dart
   ```
   Or using Flutter:
   ```
   flutter run -d win (for Windows)
   flutter run -d macos (for macOS)
   flutter run -d linux (for Linux)
   ```

## Usage Guide

### Main Menu Options

#### 1. Add Student
- Enter a unique student ID
- Enter the student's full name
- Student record is created with no scores initially

```
Example:
Student ID: S001
Student Name: John Doe
✅ Student added successfully: John Doe (ID: S001)
```

#### 2. Add Score to Student
- Enter the student ID
- Specify the subject name (e.g., Math, English, Science)
- Enter score (0-100)
- Enter weight/percentage (0-100)

```
Example:
Student ID: S001
Subject: Math
Score: 85.5
Weight: 30%
✅ Score added successfully!
```

#### 3. View Student Details
- Enter student ID to see:
  - Overall average score
  - Overall grade
  - Overall GPA
  - Subject-wise breakdown with individual grades and GPAs

#### 4. View All Students
- Displays a table of all students
- Shows: Name, ID, Average Score, Grade, GPA
- Sorted by performance (highest to lowest)

#### 5. View Class Statistics
- Total number of students
- Class-wide average score
- Top performing student
- Bottom performing student
- Subject-wise class averages

#### 6. View Grade Distribution
- Visual representation of grade distribution
- Shows count and percentage for each grade (A-F)
- ASCII bar chart for quick visualization

#### 7. Remove Student
- Enter student ID to remove
- Requires confirmation before deletion
- Confirmation message upon successful removal

#### 8. Clear All Students
- Deletes all student records
- Requires explicit confirmation
- Use with caution!

#### 9. Exit
- Cleanly exits the application
- Goodbye message displayed

## Grade Calculation System

### Grade Scale
| Score Range | Grade | GPA |
|------------|-------|-----|
| 90-100     | A     | 4.0 |
| 80-89      | B     | 3.0 |
| 70-79      | C     | 2.0 |
| 60-69      | D     | 1.0 |
| Below 60   | F     | 0.0 |

### Score Calculation
The overall student score is calculated as a **weighted average**:

```
Total Score = (Score₁ × Weight₁ + Score₂ × Weight₂ + ... + Scoreₙ × Weightₙ) 
              / (Weight₁ + Weight₂ + ... + Weightₙ)
```

**Example:**
- Math: 85 with 30% weight = 25.5
- English: 90 with 40% weight = 36.0
- Science: 78 with 30% weight = 23.4
- Total = (25.5 + 36.0 + 23.4) / (30 + 40 + 30) = 84.9/100 → Grade B

## Class Architecture

### Student Class
Represents a single student with:
- `id`: Unique student identifier
- `name`: Student's full name
- `scores`: Map of subject scores
- `weights`: Map of subject weights

**Key Methods:**
- `calculateTotalScore()`: Returns weighted average score
- `getGrade(score)`: Returns letter grade for a score
- `calculateGPA(score)`: Returns GPA value (0-4.0)
- `addScore(subject, score, weight)`: Records a new subject score
- `getScore(subject)`: Retrieves score for a specific subject
- `getSubjects()`: Returns list of all subjects
- `getSubjectStatistics(subject)`: Returns detailed stats for a subject

### StudentManager Class
Manages multiple students and provides analytics:

**Key Methods:**
- `addStudent(id, name)`: Creates a new student
- `getStudent(id)`: Retrieves a student by ID
- `removeStudent(id)`: Deletes a student
- `addScoreToStudent(studentId, subject, score, weight)`: Records a score
- `getAllStudents()`: Returns list of all students
- `getClassAverage()`: Calculates class-wide average
- `getTopStudent()`: Finds highest-performing student
- `getBottomStudent()`: Finds lowest-performing student
- `getStudentsByScore()`: Returns students sorted by score
- `getSubjectAverage(subject)`: Calculates average for a subject across all students
- `getGradeDistribution()`: Returns count of each grade

## Error Handling

The application includes robust error handling for:

- **Empty Inputs**: Validates that required fields are not empty
- **Invalid Scores**: Ensures scores are between 0-100
- **Invalid Weights**: Ensures weights are between 0-100
- **Duplicate Students**: Prevents adding students with duplicate IDs
- **Missing Students**: Handles attempts to access non-existent students
- **Invalid Choices**: Guides user with menu options

## Example Usage Scenario

```
1. Add Student
   ID: S001, Name: Alice Johnson

2. Add Student
   ID: S002, Name: Bob Smith

3. Add Score to Alice
   Subject: Math, Score: 92, Weight: 30%

4. Add Score to Alice
   Subject: English, Score: 88, Weight: 40%

5. Add Score to Alice
   Subject: Science, Score: 95, Weight: 30%

6. Add Score to Bob
   Subject: Math, Score: 78, Weight: 30%

7. Add Score to Bob
   Subject: English, Score: 85, Weight: 40%

8. Add Score to Bob
   Subject: Science, Score: 82, Weight: 30%

9. View Class Statistics
   - Total Students: 2
   - Class Average: 86.15
   - Top Student: Alice Johnson (91.80/100, Grade A)
   - Bottom Student: Bob Smith (81.30/100, Grade B)

10. View Grade Distribution
    A: 1 student (50%)
    B: 1 student (50%)
    C-F: 0 students
```

## Technical Details

### Language & Framework
- **Language**: Dart 3.0.0+
- **Platform**: Flutter (CLI mode)
- **UI**: Command-line interface (CLI) with console I/O

### Key Technologies
- `dart:io` library for console input/output
- Collections (Map, List) for data management
- Exception handling for error management
- String formatting and manipulation

### Code Quality
- Clean code architecture with separation of concerns
- Comprehensive documentation with comments
- Input validation and error handling
- Extensible design for future enhancements

## Limitations & Future Enhancements

### Current Limitations
- Data is stored in-memory (not persisted)
- Single-session operation
- Console-based UI only

### Potential Future Enhancements
- 📁 File-based data persistence (JSON/CSV export)
- 🎨 GUI using Flutter widgets (not CLI)
- 📧 Email integration for grade reports
- 🔐 User authentication and role-based access
- 📱 Mobile app version
- ☁️ Cloud-based data storage
- 📈 Advanced analytics and visualization
- 🌐 Multi-language support
- 📊 Generate PDF reports
- ⚙️ Configurable grading scales

## Troubleshooting

### Application won't start
- Ensure Flutter/Dart is properly installed
- Verify project files are in correct locations
- Run `flutter pub get` to fetch dependencies

### Import errors
- Check that `lib/student_calculator.dart` exists
- Verify correct import paths in `bin/main.dart`
- Ensure file paths use correct separators

### Input validation errors
- Verify you're entering numeric values for scores/weights
- Ensure IDs and names are not empty
- Remember scores must be 0-100, weights 0-100

## Contributing

Feel free to fork this project and submit enhancements!

## License

This project is open-source and available for educational and personal use.

## Support

For issues, questions, or suggestions:
1. Review the Usage Guide section above
2. Check the error message carefully for hints
3. Verify input formatting matches requirements
4. Try running a fresh instance of the application

---

**Happy Calculating! 📚✨**
#   O s t a d - C o u r s e - w i t h - B D - a p p s  
 