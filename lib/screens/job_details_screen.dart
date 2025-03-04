import 'package:flutter/material.dart';

import '../core/constants/App_colors.dart';
import '../core/widgets/job_card.dart';


class JobDetailsScreen extends StatefulWidget {
  final JobCard jobCard;

  const JobDetailsScreen({
    super.key,
    required this.jobCard,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isDescriptionExpanded = false;

  Widget _buildFullWidthJobCard() {
    return JobCard(
      companyLogo: widget.jobCard.companyLogo,
      title: widget.jobCard.title,
      company: widget.jobCard.company,
      location: widget.jobCard.location,
      workLocationType: widget.jobCard.workLocationType,
      employmentType: widget.jobCard.employmentType,
      experienceLevel: widget.jobCard.experienceLevel,
      width: double.infinity,
      height: widget.jobCard.height, salary: widget.jobCard.salary,
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
    bool showDivider = true,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: showDivider
              ? BorderSide(color: Colors.grey[200]!, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Job Card Section
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildFullWidthJobCard(),
                    ),

                    const SizedBox(height: 8),

                    // Job Description Section
                    _buildSectionContainer(
                      title: 'Job description',
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'International Customer Care Executive',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text('Roles & Responsibilities:'),
                              AnimatedCrossFade(
                                firstChild: const Text(
                                  'building and maintaining relationships with clients and customers, ensuring their needs are met and satisfaction levels are high.',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                secondChild: const Text(
                                  'Managing a customer support team, Determining the process of customer support, Creating policies and procedures and Resolving customer pain points',
                                ),
                                crossFadeState: isDescriptionExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isDescriptionExpanded = !isDescriptionExpanded;
                                  });
                                },
                                child: Text(
                                  isDescriptionExpanded ? 'Show less' : 'Show more',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Job Role Section
                    _buildSectionContainer(
                      title: 'Job role',
                      children: [
                        _buildInfoRow(
                          Icons.location_on,
                          'Work location',
                          'Scheme 78, Indore',
                        ),
                        _buildInfoRow(
                          Icons.business,
                          'Department',
                          'Customer Support',
                        ),
                        _buildInfoRow(
                          Icons.work,
                          'Role / Category',
                          'International Customer Care Executive',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Job Requirements Section
                    _buildSectionContainer(
                      title: 'Job requirements',
                      children: [
                        _buildInfoRow(
                          Icons.star,
                          'Experience',
                          'Freshers only',
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // About Company Section
                    _buildSectionContainer(
                      title: 'About company',
                      showDivider: false,
                      children: [
                        _buildInfoRow(
                          Icons.business_center,
                          'Name',
                          'Teleperformance',
                        ),
                      ],
                    ),

                    // Bottom padding for the apply button
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),

          // Fixed Apply Button at Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle apply button tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Apply on company website',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.open_in_new, size: 20),
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