import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class HowToPreparePage extends StatelessWidget {
  const HowToPreparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            const Text(
              'How to prepare your application',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF004D40),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Tabs
            Container(
              alignment: Alignment.center,
              child: TabBar(
                labelColor: const Color(0xFF004D40),
                unselectedLabelColor: Colors.black54,
                indicatorColor: Color(0xFFFFA000),
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Professional Occupations'),
                  Tab(text: 'Trade Occupations'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 400, // adjust height as needed
              child: TabBarView(
                children: [
                  _StepsSection(
                    description:
                    "If you're a professional choosing to migrate to Australia, chances are you're likely to be assessed by us. We assess 361 different professional occupations, assessing your skills, experience and qualifications.",
                    steps: [
                      StepData(number: '1', title: 'Find', description: 'Find the VETASSESS occupation that most closely fits your skills and experience.'),
                      StepData(number: '2', title: 'Match', description: 'Match your skills and experience to your chosen occupation.'),
                      StepData(number: '3', title: 'Prepare', description: 'Get ready to apply by preparing all the information and documents you need.'),
                      StepData(number: '4', title: 'Apply', description: 'Apply online when you’re ready. If you’re still unsure, skills assessment support is available when you need it.'),
                    ],
                  ),
                  _StepsSection(
                    description:
                    "If you're a tradesperson, your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications. VETASSESS is Australia's leading assessment body for trades and we can assess 27 different trade occupations.",
                    steps: [
                      StepData(number: '1', title: 'Step 1', description: 'Check your eligibility to apply for a Trade Skills Assessment.'),
                      StepData(number: '2', title: 'Step 2', description: 'Understand the Assessment Process.'),
                      StepData(number: '3', title: 'Step 3', description: 'Confirm the type of evidence you may be asked to provide.'),
                      StepData(number: '4', title: 'Step 4', description: 'Find the cost you’ll need to pay up front for your trade skills assessment.'),
                      StepData(number: '5', title: 'Step 5', description: 'Apply now.'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StepsSection extends StatelessWidget {
  final String description;
  final List<StepData> steps;

  const _StepsSection({required this.description, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: steps.map((step) {
              return Row(
                children: [
                  _StepCard(step: step),
                  if (step != steps.last)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DottedLine(
                        dashColor: Color(0xFFFFA000),
                        dashLength: 4,
                        lineThickness: 1,
                        direction: Axis.horizontal,
                        lineLength: 30,
                      ),
                    ),

                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class StepData {
  final String number;
  final String title;
  final String description;

  StepData({required this.number, required this.title, required this.description});
}

class _StepCard extends StatelessWidget {
  final StepData step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            step.number,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          step.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 160,
          child: Text(
            step.description,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
