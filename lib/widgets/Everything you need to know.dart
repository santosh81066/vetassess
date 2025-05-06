import 'package:flutter/material.dart';

class EverythingYouNeedToKnow extends StatelessWidget {
  const EverythingYouNeedToKnow({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Everything you need to know:',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 24),
            TabBar(
              labelColor: const Color(0xFF004D40),
              unselectedLabelColor: Colors.black54,
              indicatorColor: const Color(0xFFFFA000),
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'For professional skilled migration'),
                Tab(text: 'For trades skilled migration'),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 600, // give it enough height for content
              child: TabBarView(
                children: [
                  _TabContent(
                    title: 'For professional skilled migration',
                    description:
                    'Browse the resources below to help you understand the professional skills migration assessment journey. They have essential information about the process, what fees you may need to pay and frequently asked questions.',
                    links: [
                      'Fees',
                      'Check my eligibility',
                      'Understand the Assessment Process',
                      'Renew my assessment',
                      'Required Documents',
                      'Skills Assessment Support Service',
                    ],
                    buttonText:
                    'View all information about Professional Occupations',
                    imageAsset: 'assets/images/EverythingYouNeedToKnow.png',
                  ),
                  _TabContent(
                    title: 'For trades skilled migration',
                    description:
                    'Browse resources below to understand the trades skills migration assessment process. This includes assessment fees, eligibility criteria, required documents and FAQs.',
                    links: [
                      'Fees',
                      'Assessment Locations',
                      'Required Documents',
                      'Understand the Assessment Process',
                    ],
                    buttonText: 'View all information about Trade Occupations',
                    imageAsset: 'assets/images/EverythingYouNeedToKnow2.png',
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

class _TabContent extends StatelessWidget {
  final String title;
  final String description;
  final List<String> links;
  final String buttonText;
  final String imageAsset;

  const _TabContent({
    required this.title,
    required this.description,
    required this.links,
    required this.buttonText,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 800;

      return SingleChildScrollView(
        child: Column(
          children: [
            isWide
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.65,
                  child: _LeftContent(
                    title: title,
                    description: description,
                    links: links,
                    buttonText: buttonText,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.3,
                  child: Image.asset(imageAsset),
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LeftContent(
                  title: title,
                  description: description,
                  links: links,
                  buttonText: buttonText,
                ),
                const SizedBox(height: 20),
                Image.asset(imageAsset),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _LeftContent extends StatelessWidget {
  final String title;
  final String description;
  final List<String> links;
  final String buttonText;

  const _LeftContent({
    required this.title,
    required this.description,
    required this.links,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: links
              .map(
                (link) => InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      link,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF004D40),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: Color(0xFF004D40),
                  ),
                ],
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFA000),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: () {},
          child: Text(buttonText),
        ),
      ],
    );
  }
}
