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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left section
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Business and Industry",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF004D40),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Leverage the expertise of VETASSESS, a trusted partner to industry and governments in skills assessment and educational services.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA000),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
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
                  _linkColumn("Local", [
                    "Assessment Peer Review",
                    "Education and consultancy services",
                    "Online Learning & Content Development",
                    "Recognition of Prior Learning for business",
                  ]),

                  const SizedBox(width: 60),

                  // Global Column
                  _linkColumn("Global", [
                    "Mapping overseas qualifications to Australian standards",
                    "International Qualifications Assessment Service",
                    "Pioneering global initiatives",
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _linkColumn(String heading, List<String> links) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 12),
          ...links.map(
                (text) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
