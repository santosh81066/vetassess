import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'header.dart'; // your custom header
import 'footer.dart'; // your custom footer

class SkillsAssessmentPage extends StatelessWidget {
  const SkillsAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(), // your custom header

          // Hero section
          Container(
            color: Colors.blue.shade50,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Skills Assessment for Professional Occupations',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'VETASSESS is the largest skills assessment provider for migration to Australia. '
                      'We assess 360 professional occupations across various industries.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // Occupations carousel
          CarouselSlider(
            options: CarouselOptions(height: 180, autoPlay: true),
            items: [
              'Architects',
              'Engineers',
              'ICT Professionals',
              'Marketing Specialists',
              'Environmental Scientists'
            ].map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),


          const SizedBox(height: 30),

          // Search occupation section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'Search for your occupation',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter occupation name...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Steps section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'Application Process Steps',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                for (var step in [
                  '1. Check your occupation and requirements',
                  '2. Submit your application online',
                  '3. Await assessment outcome',
                  '4. Receive your result letter'
                ])
                  ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(step),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Help Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Need Help?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    HelpCard(title: 'Eligibility Checker'),
                    HelpCard(title: 'Document Checklist'),
                    HelpCard(title: 'Sample Letter'),
                    HelpCard(title: 'Application Portal'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // FAQ section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionPanelList.radio(
              children: [
                ExpansionPanelRadio(
                  value: 1,
                  headerBuilder: (context, isExpanded) =>
                  const ListTile(title: Text('What is VETASSESS?')),
                  body: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('VETASSESS is an Australian skills assessment authority.'),
                  ),
                ),
                ExpansionPanelRadio(
                  value: 2,
                  headerBuilder: (context, isExpanded) =>
                  const ListTile(title: Text('How long does assessment take?')),
                  body: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Processing time depends on occupation and document quality.'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
          const Footer(), // your custom footer
        ],
      ),
    );
  }
}

// Custom Help Card Widget
class HelpCard extends StatelessWidget {
  final String title;
  const HelpCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
