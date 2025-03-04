import 'package:flutter/material.dart';
import '../../core/constants/App_colors.dart';

class EditResumeScreen extends StatefulWidget {
  @override
  _EditResumeScreenState createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen> {
  bool _isUploading = false;
  String? _currentResumePath;

  @override
  void initState() {
    super.initState();
    // Initialize with existing resume if any
    _currentResumePath = 'resume_v1.pdf';
  }

  Future<void> _pickAndUploadResume() async {
    setState(() {
      _isUploading = true;
    });

    // Simulate file picking and uploading
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _currentResumePath = 'new_resume.pdf';
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Resume',
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Resume',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              if (_currentResumePath != null)
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description, color: AppColors.primary, size: 36),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentResumePath!,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Uploaded on: Feb 15, 2025',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.remove_red_eye),
                                label: Text('Preview'),
                                onPressed: () {
                                  // Action to preview resume
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.share),
                                label: Text('Share'),
                                onPressed: () {
                                  // Action to share resume
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              else
                Center(
                  child: Text('No resume uploaded yet'),
                ),

              SizedBox(height: 32),

              Text(
                'Upload New Resume',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              InkWell(
                onTap: _isUploading ? null : _pickAndUploadResume,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _isUploading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 48,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Click to upload your resume',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Supports PDF, DOCX (Max 5MB)',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),
              Text(
                'Resume Tips',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildTipItem(
                'Keep it concise - 1-2 pages is ideal for most positions',
                Icons.format_align_left,
              ),
              _buildTipItem(
                'Highlight relevant skills and experiences that match job descriptions',
                Icons.lightbulb_outline,
              ),
              _buildTipItem(
                'Quantify achievements with numbers where possible',
                Icons.bar_chart,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}