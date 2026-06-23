import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bd_app_coding/models/auth_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await Provider.of<AuthProvider>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, '/');
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
