import 'package:flutter/material.dart';
import '../../core/constants/App_colors.dart';

class EditEducationScreen extends StatefulWidget {
  final List<Map<String, String>> educations;
  final bool isAdding;
  final int? editIndex;

  const EditEducationScreen({
    Key? key,
    this.educations = const [],
    this.isAdding = false,
    this.editIndex,
  }) : super(key: key);

  @override
  _EditEducationScreenState createState() => _EditEducationScreenState();
}

class _EditEducationScreenState extends State<EditEducationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  bool _currentlyStudying = false;
  String _degreeLevel = 'Bachelor\'s';

  final List<String> _degreeLevels = [
    'High School',
    'Associate\'s',
    'Bachelor\'s',
    'Master\'s',
    'Doctorate',
    'Certificate',
    'Diploma',
    'Other'
  ];

  @override
  void initState() {
    super.initState();

    // If editing an existing education
    if (!widget.isAdding && widget.editIndex != null) {
      final edu = widget.educations[widget.editIndex!];

      _degreeController.text = edu['degree']
          ?.split(' in ')
          .last ?? '';

      // Try to determine degree level from degree name
      final degreeName = edu['degree'] ?? '';
      if (degreeName.contains('Bachelor')) {
        _degreeLevel = 'Bachelor\'s';
      } else if (degreeName.contains('Master')) {
        _degreeLevel = 'Master\'s';
      } else if (degreeName.contains('Doctor') || degreeName.contains('PhD')) {
        _degreeLevel = 'Doctorate';
      }

      _institutionController.text = edu['institution'] ?? '';

      // Parse duration
      final duration = edu['duration'] ?? '';
      final years = duration.split(' - ');
      if (years.length > 1) {
        _startYearController.text = years[0];
        if (years[1].toLowerCase() == 'present') {
          _currentlyStudying = true;
        } else {
          _endYearController.text = years[1];
        }
      }

      _gradeController.text = edu['grade'] ?? '';
    }
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _institutionController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  Map<String, String> _buildEducationData() {
    String fullDegree = '$_degreeLevel in ${_degreeController.text}';

    String duration = '${_startYearController.text} - ';
    duration += _currentlyStudying ? 'Present' : _endYearController.text;

    return {
      'degree': fullDegree,
      'institution': _institutionController.text,
      'duration': duration,
      'grade': _gradeController.text,
    };
  }

  void _saveEducation() {
    if (_formKey.currentState!.validate()) {
      final newEdu = _buildEducationData();

      // Create copy of educations list
      final updatedEducations = List<Map<String, String>>.from(
          widget.educations);

      if (widget.isAdding) {
        updatedEducations.add(newEdu);
      } else if (widget.editIndex != null) {
        updatedEducations[widget.editIndex!] = newEdu;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Education details saved')),
      );

      // Return updated list to previous screen
      Navigator.pop(context, updatedEducations);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isAdding ? 'Add Education' : 'Edit Education';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0, // Instead of using 'primary: false'
      ),
      body:SingleChildScrollView(
    child:
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Degree Level Dropdown
              DropdownButtonFormField<String>(
                value: _degreeLevel,
                items: _degreeLevels.map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _degreeLevel = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Degree Level',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _degreeController,
                decoration: InputDecoration(
                  labelText: 'Field of Study',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your field of study';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _institutionController,
                decoration: InputDecoration(
                  labelText: 'Institution',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an institution name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startYearController,
                      decoration: InputDecoration(
                        labelText: 'Start Year',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _currentlyStudying
                        ? Container()
                        : TextFormField(
                      controller: _endYearController,
                      decoration: InputDecoration(
                        labelText: 'End Year',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (!_currentlyStudying &&
                            (value == null || value.isEmpty)) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              CheckboxListTile(
                title: Text('Currently Studying'),
                value: _currentlyStudying,
                onChanged: (bool? value) {
                  setState(() {
                    _currentlyStudying = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _gradeController,
                decoration: InputDecoration(
                  labelText: 'Grade/GPA (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveEducation,
                child: Text('Save Education'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}