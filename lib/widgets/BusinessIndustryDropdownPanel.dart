import 'package:flutter/material.dart';

class BusinessIndustryDropdownPanel extends StatelessWidget {
  const BusinessIndustryDropdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      color: Colors.white,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Business and Industry Section
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Business and Industry",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Leverage the expertise of VETASSESS, a trusted partner to industry and governments in skills assessment and educational services.",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA000),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("View All"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 60),

                    // Local Column
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Local",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildLink("Assessment Peer Review"),
                          const SizedBox(height: 12),
                          _buildLink("Education and consultancy services"),
                          const SizedBox(height: 12),
                          _buildLink("Online Learning & Content Development"),
                          const SizedBox(height: 12),
                          _buildLink("Recognition of Prior Learning for business"),
                        ],
                      ),
                    ),

                    const SizedBox(width: 60),

                    // Global Column
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Global",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildLink("Mapping overseas qualifications to Australian standards"),
                          const SizedBox(height: 12),
                          _buildLink("International Qualifications Assessment Service"),
                          const SizedBox(height: 12),
                          _buildLink("Pioneering global initiatives"),
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

  Widget _buildLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Color(0xFF009688),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}