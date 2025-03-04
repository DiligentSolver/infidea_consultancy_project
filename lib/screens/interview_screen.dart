// interview_screen.dart
import 'package:flutter/material.dart';

import '../core/constants/App_colors.dart';

class InterviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: 3, // Dummy count
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Interview with Company $index'),
              subtitle: Text('Date: 2025-02-20 | Time: 10:00 AM'),
              trailing: Icon(Icons.video_call),
            ),
          );
        },
      ),
    );
  }
}
