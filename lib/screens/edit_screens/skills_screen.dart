import 'package:flutter/material.dart';
import '../../core/constants/App_colors.dart';

class EditSkillsScreen extends StatefulWidget {
  final List<String> skills;

  const EditSkillsScreen({Key? key, required this.skills}) : super(key: key);

  @override
  _EditSkillsScreenState createState() => _EditSkillsScreenState();
}

class _EditSkillsScreenState extends State<EditSkillsScreen> {
  late List<String> _skills;
  final TextEditingController _newSkillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _skills = List.from(widget.skills);
  }

  void _addSkill(String skill) {
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
        _newSkillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  @override
  void dispose() {
    _newSkillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Skills',
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          TextButton(
            onPressed: () {
              // Save skills
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Skills updated')),
              );
              Navigator.pop(context);
            },
            child: Text('SAVE', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
    child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Skills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _skills.map((skill) => Chip(
                label: Text(skill),
                deleteIcon: Icon(Icons.close, size: 18),
                onDeleted: () => _removeSkill(skill),
                backgroundColor: AppColors.primary.withOpacity(0.1),
                labelStyle: TextStyle(color: AppColors.primary),
                deleteIconColor: AppColors.primary,
              )).toList(),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newSkillController,
                    decoration: InputDecoration(
                      hintText: 'Add a new skill',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                    onSubmitted: _addSkill,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addSkill(_newSkillController.text),
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Popular Skills',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'React Native', 'JavaScript', 'Dart', 'UI/UX', 'Swift',
                'Kotlin', 'Firebase', 'REST API', 'Git', 'Agile'
              ].map((skill) => ActionChip(
                label: Text(skill),
                onPressed: () => _addSkill(skill),
                backgroundColor: Colors.grey.shade200,
              )).toList(),
            ),
          ],
        ),
      ),
    ));
  }
}