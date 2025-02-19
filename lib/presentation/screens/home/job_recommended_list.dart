import 'package:flutter/material.dart';

class JobList extends StatelessWidget {
  final String type;
  const JobList({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      {"title": "Flutter Developer", "company": "Google", "location": "Remote"},
      {"title": "Backend Engineer", "company": "Amazon", "location": "USA"},
      {"title": "UI/UX Designer", "company": "Adobe", "location": "Remote"},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Card(
          child: ListTile(
            title: Text(job["title"]!),
            subtitle: Text("${job["company"]!} • ${job["location"]!}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {}, // Navigate to job details
          ),
        );
      },
    );
  }
}
