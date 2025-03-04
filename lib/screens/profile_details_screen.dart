/*
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../core/constants/App_colors.dart';

class ProfileDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProfileCard(),
              _buildJobPreferencesCard(),
              _buildResumeCard(),
              _buildAddOptionsRow(),
              _buildWorkExperienceCard(),
              _buildSkillsCard(),
              _buildEducationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    double profileCompletion = 70;
    Color gaugeColor = profileCompletion < 50
        ? Colors.red
        : profileCompletion < 80
        ? Colors.orange
        : Colors.green;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: SfRadialGauge(
                    axes: [
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 180,
                        endAngle: 0,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.15,
                          cornerStyle: CornerStyle.bothCurve,
                          thicknessUnit: GaugeSizeUnit.factor,
                          color: Colors.grey.shade300,
                        ),
                        ranges: [
                          GaugeRange(
                            startValue: 0,
                            endValue: profileCompletion,
                            color: gaugeColor,
                            startWidth: 10,
                            endWidth: 10,
                          ),
                        ],
                        annotations: [
                          GaugeAnnotation(
                            widget: CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage('assets/user.png'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Job Title', style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text('Salary | Location', style: TextStyle(fontSize: 14)),
                  Text('Contact Info', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobPreferencesCard() {
    return _buildCard('Job Preferences', ['Job Roles | Work Preference']);
  }

  Widget _buildResumeCard() {
    return _buildCard('Resume', ['', 'View | Edit'], isClickable: true);
  }

  Widget _buildAddOptionsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildAddOption('Add Skill'),
          _buildAddOption('Add Education'),
          _buildAddOption('Add Salary Expectation'),
        ],
      ),
    );
  }

  Widget _buildAddOption(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildWorkExperienceCard() {
    return _buildCard('Work Experience', ['Company Name | Position', 'From Year - To Year', 'Salary: Amount']);
  }

  Widget _buildSkillsCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Skills', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Flutter', 'Figma', 'Communication']
                    .map((skill) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Chip(label: Text(skill)),
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard() {
    return _buildCard('Education', ['Degree | Institution', 'From Year - To Year'], isClickable: true);
  }

  Widget _buildCard(String title, List<String> details, {bool isClickable = false}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(detail, style: TextStyle(fontSize: 14)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:animate_do/animate_do.dart';
import '../core/constants/App_colors.dart';
import '../core/widgets/nav_drawer.dart';
import '../core/widgets/profile_card_widget.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings, color: AppColors.primary, size: 28),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      endDrawer: const NavDrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInUp(duration: const Duration(milliseconds: 500), child: _buildProfileCard(context)),
              const SizedBox(height: 20),
              _buildSectionHeader("Preferences"),
              FadeInUp(duration: const Duration(milliseconds: 600), child: const ProfileCardWidget(title: 'Job Preferences', details: ['Job Roles | Work Preference'], navigationDestination: '/edit_job_preferences')),
              const SizedBox(height: 20),
              FadeInUp(duration: const Duration(milliseconds: 700), child: const ProfileCardWidget(title: 'Resume', details: ['', 'View | Edit'], navigationDestination: '/edit_resume')),
              const SizedBox(height: 20),
              _buildAddOptionsRow(context),
              const SizedBox(height: 20),
              _buildSectionHeader("Experience & Skills"),
              FadeInUp(duration: const Duration(milliseconds: 800), child: const ProfileCardWidget(title: 'Work Experience', details: ['Google | SDE 1', '2026 - Present', 'Salary: Rs. 200000'], navigationDestination: '/edit_work_experience')),
              const SizedBox(height: 20),
              FadeInUp(duration: const Duration(milliseconds: 900), child: _buildAnimatedSkillsCard()),
              const SizedBox(height: 20),
              _buildSectionHeader("Education & Details"),
              FadeInUp(duration: const Duration(milliseconds: 1000), child: const ProfileCardWidget(title: 'Education', details: ['B. Tech - Computer Science | AITR', '2022-2026'], navigationDestination: '/edit_education')),
              const SizedBox(height: 20),
              FadeInUp(duration: const Duration(milliseconds: 1100), child: const ProfileCardWidget(title: 'Personal Details', details: ['sakshiraut674@gmail.com | 9826421968', '06/07/2004 | Single'], navigationDestination: '/edit_personal_details')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    double profileCompletion = 92;
    Color gaugeColor = profileCompletion < 50 ? Colors.red : profileCompletion < 80 ? Colors.orange : Colors.green;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit_profile');  // Ensure this route is defined in your MaterialApp routes
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: SfRadialGauge(
                        axes: [
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            showLabels: false,
                            showTicks: false,
                            startAngle: 120,
                            endAngle: 60,
                            axisLineStyle: AxisLineStyle(
                              thickness: 0.15,
                              cornerStyle: CornerStyle.bothCurve,
                              thicknessUnit: GaugeSizeUnit.factor,
                              color: Colors.grey.shade300,
                            ),
                            ranges: [
                              GaugeRange(
                                startValue: 0,
                                endValue: profileCompletion,
                                color: gaugeColor,
                                startWidth: 12,
                                endWidth: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 36,
                            backgroundImage: AssetImage('assets/images/user.png'),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${profileCompletion.toInt()}%',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sakshi Raut', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Flutter Developer', style: TextStyle(fontSize: 18, color: Colors.white70)),
                      Text('Bangalore', style: TextStyle(fontSize: 18, color: Colors.white70)),
                      Text('7471141860', style: TextStyle(fontSize: 18, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }






  Widget _buildAnimatedSkillsCard() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        
      ),
      child: ProfileCardWidget(
        title: 'Skills',
        customContent: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ['Flutter', 'Firebase', 'Full Stack']
                .map((skill) => BounceIn(
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Chip(labelStyle: const TextStyle(color: AppColors.primary), label: Text(skill)),
              ),
            ))
                .toList(),
          ),
        ),
        navigationDestination: '/edit_skills',
      ),
    );
  }
  Widget _buildAddOptionsRow(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildBouncingButton(context, 'Skill', '/edit_skills'),
          const SizedBox(width: 8),
          _buildBouncingButton(context, 'Education', '/edit_education'),
          const SizedBox(width: 8),
          _buildBouncingButton(context, 'Email', '/edit_personal_details'),
          const SizedBox(width: 8),
          _buildBouncingButton(context, 'Languages', '/edit_personal_details'),
        ],
      ),
    );
  }

  Widget _buildBouncingButton(BuildContext context, String text, String route) {
    return BounceIn(
      child: OutlinedButton.icon(
        onPressed: () => Navigator.of(context).pushNamed(route),
        icon: const Icon(Icons.add, color: AppColors.primary),
        label: Text(text, style: const TextStyle(color: AppColors.primary)),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
    );
  }
}

