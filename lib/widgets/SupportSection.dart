import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/under_maintenance.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;
    
    return Container(
      color: const Color(0xFF00565A), // Base teal background color
      child: Stack(
        children: [
          // Background pattern - positioned to cover the right side
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/block-bg.svg',
              width: MediaQuery.of(context).size.width * 0.5, // Cover about 70% of the width
              height: MediaQuery.of(context).size.height * 0.8, // Cover most of the height
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
            ),
          ),
          
          // Content container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 26),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1244),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "I need help, what support is available?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    isDesktop
                        ? IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                 Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: _SupportCard(
                                      title: "Help with a Skills Assessment",
                                      description:
                                          "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
                                      linkText: "Skills Assessment Support",
                                       onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MaintenancePage()));
                                }
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: _SupportCard(
                                      title: "Help with an urgent application",
                                      description:
                                          "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
                                      linkText: "Fast-track applications",
                                      onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MaintenancePage()));
                                }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                               _SupportCard(
                                title: "Help with a Skills Assessment",
                                description:
                                    "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
                                linkText: "Skills Assessment Support",
                                 onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MaintenancePage()));
                                }
                              ),
                              const SizedBox(height: 24),
                              _SupportCard(
                                title: "Help with an urgent application",
                                description:
                                    "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
                                linkText: "Fast-track applications",
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MaintenancePage()));
                                }
                                    
                              ),
                            ],
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

class _SupportCard extends StatelessWidget {
  final String title;
  final String description;
  final String linkText;
  final VoidCallback onTap;

  const _SupportCard({
    required this.title,
    required this.description,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 260),
      decoration: BoxDecoration(
        
        color: Colors.white,
        borderRadius: BorderRadius.circular(4), // Slight rounding of corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00565A),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        linkText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00565A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 26,
                        width: 26,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00565A),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 2,
                    width: 210,
                    margin: const EdgeInsets.only(top: 8),
                    color: const Color(0xFF00565A),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}