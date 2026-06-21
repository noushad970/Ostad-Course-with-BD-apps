import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xff9aa9b0),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff9aa9b0),
      body: Center(
        child: Container(
          width: 340,
          height: 480, // fixed square-like container (approx)
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // edge curve
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 22.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image (profile)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xfff3eef8),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.asset(
                        '../assets/profile.jpg', // fixed asset path
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.person,
                          size: 72,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'App Developer',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Passionate about creating beautiful and functional apps. Always learning and exploring new technologies.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13, height: 1.4, color: Colors.black87),
                  ),
                ),
                const Spacer(),
                // Row of icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      color: Colors.black54,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.language),
                      color: Colors.black54,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mail_outline),
                      color: Colors.black54,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.code),
                      color: Colors.black54,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Button that shows a toast (SnackBar)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Hello'),
                          content: const Text('Hello World'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2196f3),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:
                        const Text('Connect', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
