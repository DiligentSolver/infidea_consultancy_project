import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../core/widgets/audio_card.dart';
import '../core/widgets/interview_card.dart';
import '../core/constants/App_colors.dart';

class InterviewTipsScreen extends StatefulWidget {
  @override
  _InterviewTipsScreenState createState() => _InterviewTipsScreenState();
}

class _InterviewTipsScreenState extends State<InterviewTipsScreen> {
  final List<Map<String, String>> tips = [
    {
      "title": "Research the Company",
      "description": "Understand the company’s mission, values, and recent developments before the interview."
    },
    {
      "title": "Practice Common Questions",
      "description": "Prepare answers for commonly asked interview questions like 'Tell me about yourself' or 'Why should we hire you?'"
    },
    {
      "title": "Dress Professionally",
      "description": "Choose an outfit that aligns with the company culture and dress professionally."
    },
    {
      "title": "Arrive on Time",
      "description": "Being punctual shows professionalism. Aim to arrive 10-15 minutes early."
    },
    {
      "title": "Show Confidence",
      "description": "Maintain eye contact, offer a firm handshake, and speak with confidence."
    },
    {
      "title": "Ask Thoughtful Questions",
      "description": "Prepare questions to ask the interviewer about the role, team, or company culture."
    },
    {
      "title": "Follow Up",
      "description": "Send a thank-you email within 24 hours to express gratitude and reaffirm your interest."
    },
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  bool showSlider = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  Future<void> _toggleAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('audio/demo_intro.mp3'));
    }
    setState(() {
      isPlaying = !isPlaying;
      showSlider = true;
    });
  }

  Future<void> _seekAudio(double value) async {
    final newPosition = Duration(seconds: value.toInt());
    await _audioPlayer.seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interview Tips',
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
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 100.0, left: 12.0, right: 12.0, top: 12.0),
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return InterviewCard(
                title: tips[index]['title']!,
                description: tips[index]['description']!,
              );
            },
          ),

          // Floating Audio Player
          Positioned(
            bottom: 10,
            left: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: GestureDetector(
                      onTap: _toggleAudio,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.2),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                          color: AppColors.primary,
                          size: 40,
                        ),
                      ),
                    ),
                    title: Text(
                      'Nail Your First Impression – A Strong Introduction Gets You Hired!',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${_position.inMinutes}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')} / '
                          '${_duration.inMinutes}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),

                  // Seek Slider (Only visible when audio is played/stopped)
                  if (showSlider)
                    Slider(
                      value: _position.inSeconds.toDouble(),
                      max: _duration.inSeconds.toDouble(),
                      activeColor: AppColors.primary,
                      inactiveColor: AppColors.primary.withOpacity(0.3),
                      onChanged: (double value) {
                        _seekAudio(value);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Interview Tips',
          style: TextStyle(
              color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        /*
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
         */
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0, top: 12.0),
              itemCount: tips.length,
              itemBuilder: (context, index) {
                return InterviewCard(
                  title: tips[index]['title']!,
                  description: tips[index]['description']!,
                );
              },
            ),
          ),

          // Floating Audio Player - Scrollable Row
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              height: 150, // Adjusted to fit within screen
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    AudioCard(
                      title: "Nail Your First Impression – A Strong Introduction Gets You Hired!",
                      audioPath: "audio/demo_intro.mp3",
                    ),
                    AudioCard(
                      title: "How to Answer a Career Gap?",
                      audioPath: "audio/career_gap.mp3",
                    ),
                    AudioCard(
                      title: "Why Did You Leave Your Previous Job?",
                      audioPath: "audio/why_left.mp3",
                    ),
                    AudioCard(
                      title: "How to Negotiate Your Salary?",
                      audioPath: "audio/salary_negotiation.mp3",
                    ),
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}