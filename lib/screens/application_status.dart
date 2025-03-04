
import 'package:flutter/material.dart';
import '../core/constants/App_colors.dart';

class ApplicationStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: 5, // Dummy count
          itemBuilder: (context, index) {
            String status = ['Pending', 'Active', 'Declined', 'Pending', 'Active'][index % 5];
            Color? statusColor = status == 'Pending'
                ? AppColors.secondary
                : status == 'Active'
                ? Colors.green
                : Colors.red[900];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  'Job Title $index',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text('Company Name', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ),
                trailing: Text(
                  status,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


