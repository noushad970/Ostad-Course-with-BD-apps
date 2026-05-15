<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Student Score Calculator - Copilot Instructions

## Project Overview
This is a Flutter/Dart CLI application for managing and calculating student scores. The project uses a clean architecture with separation between business logic and CLI interface.

## Architecture
- **`lib/student_calculator.dart`**: Core business logic containing `Student` and `StudentManager` classes
- **`bin/main.dart`**: CLI interface and user interactions using `dart:io`

## Key Classes and Their Purpose

### Student Class
- Manages individual student data and calculations
- Calculates weighted averages, grades, and GPA
- Stores subject-wise scores and weights

### StudentManager Class
- Manages collection of students
- Provides analytics and reporting functions
- Handles class-wide statistics

### StudentScoreCalculatorCLI Class
- Handles all CLI interactions
- Displays menus and processes user input
- Calls StudentManager methods to perform operations

## Code Standards
- Use meaningful variable and method names
- Include comments for complex logic
- Handle all user input with validation
- Provide clear error messages
- Use emoji indicators (✅ ❌ 📊 etc.) for visual feedback

## When Adding Features
1. Add calculation logic to `Student` or `StudentManager` class
2. Add corresponding CLI menu option in `StudentScoreCalculatorCLI`
3. Validate all user inputs before processing
4. Use appropriate error messages
5. Update README.md with new features

## Common Patterns
- Always validate input before using it (check null, type, range)
- Use try-catch blocks for error handling
- Provide visual feedback with emoji and clear messages
- Format output with consistent spacing and alignment
- Ask for confirmation before destructive operations

## Testing Recommendations
- Test with various score combinations
- Test edge cases (0, 100, empty, invalid inputs)
- Test with single and multiple students
- Test class statistics with different class sizes

## Performance Considerations
- Current implementation uses in-memory storage (sufficient for CLI use)
- For large datasets, consider implementing pagination or filtering
- Grade distribution calculation is O(n) - acceptable for typical class sizes

## Future Extension Points
- Add file I/O for data persistence
- Implement data export (CSV, JSON, PDF)
- Add more granular grade calculation options
- Implement student search and filtering
- Add batch score import functionality
