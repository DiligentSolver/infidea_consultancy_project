import 'package:flutter/material.dart';

class EditSalaryExpectationScreen extends StatefulWidget {
  @override
  _EditSalaryExpectationScreenState createState() => _EditSalaryExpectationScreenState();
}

class _EditSalaryExpectationScreenState extends State<EditSalaryExpectationScreen> {
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Salary Expectation'),
      ),
      body: SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your expected salary:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Salary in USD',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _salaryController.text);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    ));
  }
}
