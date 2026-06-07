import 'package:flutter/material.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({Key? key}) : super(key: key);

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final List<String> _categories = ['Science', 'Math', 'History', 'Sports'];
  String _selectedCategory = 'Science';

  final List<Map<String, dynamic>> _quizzes = [
    {'title': 'Flutter Basics', 'count': 10, 'category': 'Science'},
    {'title': 'General Knowledge', 'count': 20, 'category': 'Math'},
    {'title': 'World History', 'count': 15, 'category': 'History'},
    {'title': 'Sports Trivia', 'count': 12, 'category': 'Sports'},
  ];

  void _showHelloToast(BuildContext context) {
    // Using SnackBar as a simple toast alternative
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hello World')),
    );
  }

  // New helper to show dialog with a safe fallback
  Future<void> _showHelloDialog(BuildContext context) async {
    debugPrint('showHelloDialog called');
    try {
      await showDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: true,
        builder: (ctx) => AlertDialog(
          title: const Text('Hello'),
          content: const Text('Hello World'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('dialog error: $e');
      // fallback to snackbar if dialog fails for any reason
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Hello World')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        _quizzes.where((q) => q['category'] == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Home'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Choose Category',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 12),

            // Row of chips inside a horizontal scroll (uses Row)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((c) {
                  final selected = c == _selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = c;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue.shade100,
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            const Divider(),

            const SizedBox(height: 12),

            // Use Expanded with ListView
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final quiz = filtered[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        title: Text(quiz['title'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        subtitle: Text('${quiz['count']} Questions'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  QuizDetailPage(title: quiz['title'])));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // Row with two buttons demonstrating Flexible/Expanded usage
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showHelloToast(context),
                      child: const Text('Create Quiz'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        _showHelloDialog(context);
                      },
                      child: const Text('Start Quiz'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showHelloToast(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class QuizDetailPage extends StatelessWidget {
  final String title;
  const QuizDetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Description: This quiz will test your knowledge.'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Hello World')));
              },
              child: const Text('Start Quiz (toast)'),
            ),
          ],
        ),
      ),
    );
  }
}
