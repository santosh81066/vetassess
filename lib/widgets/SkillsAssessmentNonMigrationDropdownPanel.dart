import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/under_maintenance.dart';

class SkillsAssessmentNonMigrationPanel extends StatelessWidget {
  const SkillsAssessmentNonMigrationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 120),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left section
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Skills Assessment for\nNon Migration',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00574B),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const SizedBox(
                            width: 380,
                            child: Text(
                              'Already in Australia? Here\'s how to get your skills and experience assessed with VETASSESS',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                context.go('/maintenance');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFA000),
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Center(
                                child: Text(
                                  'View All',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 60),

                    // Right section
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Popular Pages',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00574B),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Two columns layout
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left column links
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLinkText(
                                      context,
                                      'Australian Technical Competencies Statement Assessment',
                                    ),
                                    const SizedBox(height: 24),
                                    _buildLinkText(
                                      context,
                                      'Post Gap Assessment',
                                    ),
                                    const SizedBox(height: 24),
                                    _buildLinkText(
                                      context,
                                      'Complementary Health Therapies Assessment',
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 40),

                              // Right column links
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLinkText(
                                      context,
                                      'Psychotherapy and Counselling Qualifications Assessment',
                                    ),
                                    const SizedBox(height: 24),
                                    _buildLinkText(
                                      context,
                                      'Financial Adviser Licensing Qualifications Comparison to the AQF',
                                    ),
                                    const SizedBox(height: 24),
                                    _buildLinkText(
                                      context,
                                      'Marketing Credentials',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLinkText(BuildContext context, String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.go('/maintenance');
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF009688),
            decoration: TextDecoration.underline,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
