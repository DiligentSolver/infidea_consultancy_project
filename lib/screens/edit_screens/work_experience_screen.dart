/*
import 'package:flutter/material.dart';

import '../../core/constants/App_colors.dart';


class EditWorkExperienceScreen extends StatefulWidget {
  final List<Map<String, String>> experiences;
  final bool isAdding;
  final int? editIndex;

  const EditWorkExperienceScreen({
    Key? key,
    required this.experiences,
    this.isAdding = false,
    this.editIndex,
  }) : super(key: key);

  @override
  _EditWorkExperienceScreenState createState() => _EditWorkExperienceScreenState();
}

class _EditWorkExperienceScreenState extends State<EditWorkExperienceScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _responsibilitiesController = TextEditingController();

  bool _currentlyWorking = false;
  String _selectedCurrency = '₹';
  String _selectedSalaryType = 'CTC';

  @override
  void initState() {
    super.initState();

    if (!widget.isAdding && widget.editIndex != null) {
      final exp = widget.experiences[widget.editIndex!];

      _companyController.text = exp['company'] ?? '';
      _positionController.text = exp['position'] ?? '';

      final duration = exp['duration'] ?? '';
      final years = duration.split(' - ');
      if (years.length > 1) {
        _startYearController.text = years[0];
        if (years[1].toLowerCase() == 'present') {
          _currentlyWorking = true;
        } else {
          _endYearController.text = years[1];
        }
      }

      _salaryController.text = exp['salary']?.replaceAll(',', '') ?? '';
      _responsibilitiesController.text = exp['responsibilities'] ?? '';
    }
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _salaryController.dispose();
    _responsibilitiesController.dispose();
    super.dispose();
  }

  Map<String, String> _buildExperienceData() {
    String duration = '${_startYearController.text} - ';
    duration += _currentlyWorking ? 'Present' : _endYearController.text;

    return {
      'company': _companyController.text,
      'position': _positionController.text,
      'duration': duration,
      'salary': '$_selectedCurrency ${_salaryController.text} ($_selectedSalaryType)',
      'responsibilities': _responsibilitiesController.text,
    };
  }

  void _saveExperience() {
    if (_formKey.currentState!.validate()) {
      final newExp = _buildExperienceData();

      final updatedExperiences = List<Map<String, String>>.from(widget.experiences);

      if (widget.isAdding) {
        updatedExperiences.add(newExp);
      } else if (widget.editIndex != null) {
        updatedExperiences[widget.editIndex!] = newExp;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Work experience saved')),
      );

      Navigator.pop(context, updatedExperiences);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isAdding ? 'Add Work Experience' : 'Edit Work Experience';

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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
            onPressed: _saveExperience,
            child: Text('SAVE', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(controller: _companyController, label: 'Company Name'),
                _buildTextField(controller: _positionController, label: 'Position/Title'),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns both at the top
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _startYearController,
                        label: 'Start Year',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _currentlyWorking
                          ? Container(
                        height: 58, // Same height as TextFormField
                        alignment: Alignment.center, // Centers text inside
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary, width: 1), // Blue border
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Present',
                          style: TextStyle(fontSize: 16, color: Colors.black), // Black text
                        ),
                      )
                          : _buildTextField(
                        controller: _endYearController,
                        label: 'End Year',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                CheckboxListTile(
                  title: Text('I currently work here'),
                  value: _currentlyWorking,
                  onChanged: (value) {
                    setState(() {
                      _currentlyWorking = value ?? false;
                      if (_currentlyWorking) {
                        _endYearController.clear();
                      }
                    });
                  },
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                Row(
                  children: [
                    DropdownButton<String>(
                      value: _selectedCurrency,
                      items: ['₹', '\$'].map((currency) {
                        return DropdownMenuItem(value: currency, child: Text(currency));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value!;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField(controller: _salaryController, label: 'Monthly Salary', keyboardType: TextInputType.number),
                    ),
                    SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _selectedSalaryType,
                      items: ['CTC', 'In-hand', 'Gross'].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSalaryType = value!;
                        });
                      },
                    ),
                  ],
                ),

                _buildTextField(controller: _responsibilitiesController, label: 'Key Responsibilities', maxLines: 5),

                if (!widget.isAdding && widget.editIndex != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Center(
                      child: TextButton.icon(
                        icon: Icon(Icons.delete, color: Colors.red),
                        label: Text('Delete This Experience', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Experience'),
                              content: Text('Are you sure you want to delete this work experience?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    final updatedExperiences = List<Map<String, String>>.from(widget.experiences);
                                    updatedExperiences.removeAt(widget.editIndex!);
                                    Navigator.pop(context);
                                    Navigator.pop(context, updatedExperiences);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../../core/constants/App_colors.dart';

class EditWorkExperienceScreen extends StatefulWidget {
  final List<Map<String, String>> experiences;
  final bool isAdding;
  final int? editIndex;

  const EditWorkExperienceScreen({
    Key? key,
    required this.experiences,
    this.isAdding = false,
    this.editIndex,
  }) : super(key: key);

  @override
  _EditWorkExperienceScreenState createState() => _EditWorkExperienceScreenState();
}

class _EditWorkExperienceScreenState extends State<EditWorkExperienceScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _responsibilitiesController = TextEditingController();

  final FocusNode _companyFocus = FocusNode();
  final FocusNode _positionFocus = FocusNode();
  final FocusNode _startYearFocus = FocusNode();
  final FocusNode _endYearFocus = FocusNode();
  final FocusNode _salaryFocus = FocusNode();
  final FocusNode _responsibilitiesFocus = FocusNode();

  bool _currentlyWorking = false;
  String _selectedCurrency = '₹';
  String _selectedSalaryType = 'CTC';

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _salaryController.dispose();
    _responsibilitiesController.dispose();

    _companyFocus.dispose();
    _positionFocus.dispose();
    _startYearFocus.dispose();
    _endYearFocus.dispose();
    _salaryFocus.dispose();
    _responsibilitiesFocus.dispose();

    super.dispose();
  }

  void _saveExperience() {
    if (_formKey.currentState!.validate()) {
      final newExp = {
        'company': _companyController.text,
        'position': _positionController.text,
        'duration': '${_startYearController.text} - ${_currentlyWorking ? 'Present' : _endYearController.text}',
        'salary': '$_selectedCurrency ${_salaryController.text} ($_selectedSalaryType)',
        'responsibilities': _responsibilitiesController.text,
      };

      final updatedExperiences = List<Map<String, String>>.from(widget.experiences);

      if (widget.isAdding) {
        updatedExperiences.add(newExp);
      } else if (widget.editIndex != null) {
        updatedExperiences[widget.editIndex!] = newExp;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Work experience saved')),
      );

      Navigator.pop(context, updatedExperiences);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isAdding ? 'Add Work Experience' : 'Edit Work Experience';

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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
            onPressed: _saveExperience,
            child: Text('SAVE', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _companyController,
                  label: 'Company Name',
                  focusNode: _companyFocus,
                  nextFocus: _positionFocus,
                ),
                _buildTextField(
                  controller: _positionController,
                  label: 'Position/Title',
                  focusNode: _positionFocus,
                  nextFocus: _startYearFocus,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _startYearController,
                        label: 'Start Year',
                        focusNode: _startYearFocus,
                        nextFocus: _currentlyWorking ? _salaryFocus : _endYearFocus,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _currentlyWorking
                          ? Container(
                        height: 58,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Present',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      )
                          : _buildTextField(
                        controller: _endYearController,
                        label: 'End Year',
                        focusNode: _endYearFocus,
                        nextFocus: _salaryFocus,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                CheckboxListTile(
                  title: Text('I currently work here'),
                  value: _currentlyWorking,
                  onChanged: (value) {
                    setState(() {
                      _currentlyWorking = value ?? false;
                      if (_currentlyWorking) {
                        _endYearController.clear();
                      }
                    });
                  },
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                _buildTextField(
                  controller: _salaryController,
                  label: 'Monthly Salary',
                  focusNode: _salaryFocus,
                  nextFocus: _responsibilitiesFocus,
                  keyboardType: TextInputType.number,
                ),
                _buildTextField(
                  controller: _responsibilitiesController,
                  label: 'Key Responsibilities',
                  focusNode: _responsibilitiesFocus,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        focusNode: focusNode,
        textInputAction: nextFocus != null ? TextInputAction.next : TextInputAction.done,
        onFieldSubmitted: (value) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }
}
