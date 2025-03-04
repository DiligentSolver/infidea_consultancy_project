import 'package:flutter/material.dart';
import '../core/constants/App_colors.dart';
import '../core/widgets/job_card.dart';
import '../core/widgets/search_bar.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Jobs For You',
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),

        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SearchBarWidget(),
            ),

            // Recommended Jobs Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recommended Jobs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // First 5 Recommended Jobs (Full Width)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: JobCard(
                    companyLogo: 'https://media-hosting.imagekit.io//5276feac64974917/Screenshot%202025-02-14%20144632.png?Expires=1834132607&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=xRxEUqHtVKb7HRdbN~6wKHD0I9jV8RzBmBqhR0xThLcQYqfvbJq3IMKnar6TxJUpaoql57K3M2EVYzrKlITU~3gFsoGgk-LlYSjbuHQZkamPs6ZpFv7WV~xnrtxLwi~FgS6Cf0hE-ijKHNGUZYwXmJfTtXwruwXW4269OKeWgF0ZRTDIk71ta49c6SCFci~zqpjN0dQNiCAFrYLNvCnWJ~ozhJBEoVaO0zOzGcu7PiJdBzLQc~OVNCAjEHgIlx~XDacfvHNv8GB2c3C3xdozRoNv2myaedw75y~5MgSAxnu0fbRDz3mo0W4rgD9FEMxVIbTUm8YKxRCbyZCio5pVWA__',
                    title: 'Customer Relationship Manager (CRM)',
                    company: 'ICICI Lombard',
                    location: 'Brilliant Convention Center, Indore',
                    workLocationType: 'Work from Office',
                    employmentType: 'Full Time',
                    experienceLevel: 'Any experience',
                    width: double.infinity, salary: 'INR 14,500-21,000CTC',
                  ),
                );
              },
            ),

            // Featured Jobs Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured Jobs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Horizontal Scrollable Featured Jobs
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: JobCard(
                      companyLogo: 'https://media-hosting.imagekit.io//c77f6c0e75f340fb/screenshot_1739772857756.png?Expires=1834380862&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=svZ1Wk81s~imruwa1QYxp0XYm6GwaZgS3U69xwtANWvv-Mus3lFX-UGD36jqyp61lQbehsoIoZlXQawKaKcxDitwO7yNlW34FDB2pK2ddcI5T36Jm15yAjIBr4KVi9-0IhqdT0YSBmvByB0GHCcGH8qnx8aGfQEqEI0Xv7RO9xfB64x2Q4bC~0FMlW7zqTplCrTkNTDUySRZmnwU1Z8rZecO4cOLUVev4AsBONYfRm1OhBWx4rpTp2pqNvNXKzs4PeG6onbfuKcHhhwoSeEONN8W3aje2uREzEjjmLOrXMkKi-vM06-1~nJ5pSreWzOLKD5B5FSPpNRXoC4wBOF4qQ__',
                      title: 'International Customer Care Executive',
                      company: 'Teleperformance',
                      location: 'Scheme 78, Indore',
                      workLocationType: 'Work From Office',
                      employmentType: 'Full Time',
                      experienceLevel: 'Fresher & Experienced Both Can Apply',
                      width: 300, salary: ': INR25,000 - INR35,000 Monthly',
                    ),
                  );
                },
              ),
            ),

            // Remaining Recommended Jobs
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7, // 12 - 5 = 7 remaining jobs
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: JobCard(
                      companyLogo: 'https://media-hosting.imagekit.io//4b0a9efa199e49c8/screenshot_1739772923905.png?Expires=1834380926&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=ZoeV-5C~02QC9CIEZ7kahGnPMLNJCvyADcI-e~GY-6ae9N-82BN2VTfgW6PQNLtyRvMh8sk7P-0xWdd1GxwnAUqnxirmhert-3onbCNiDmyU6qLUQX5zN68mCzmQ1Ub~sZbKGjEMbjXNx9qVYXc2m2Nu1oSkdRXxBXaxvAzU~mTSriUPJiX1aIckySZIXtNVFmlQWaaE4kNRF7zlKfQFc~xfwqM-udv3NCE5-9xxsYz6JGQ-0rG5gm-OpS3q00k1VSxDEDUNJMZpQxdH4hqW4w8RqZA~TaobaRaM1vCGp3YBben3g-CCOrOAPETasjNJkCS6dH9q7tpAW23WAWuu1A__',
                      title: 'Customer Relationship Manager (CRM)',
                      company: 'ICICI Lombard',
                      location: 'Brilliant Convention Center, Indore',
                      workLocationType: 'Work from Office',
                      employmentType: 'Full Time',
                      experienceLevel: 'Any experience',
                      width: double.infinity, salary: 'INR 14,500-21,000 CTC',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}