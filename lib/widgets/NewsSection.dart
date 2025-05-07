import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // optional if using go_router

class NewsUpdatesSection extends StatelessWidget {
  const NewsUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal:60),
      color: Colors.white, // White background from reference image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "News & Updates",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Get helpful tips, practical information and stay up-to-date with the latest migration news.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  //flex: ,
                  child: _FeaturedArticle(
                    image: 'assets/images/featured_news.png',
                    tags: ['News', 'Updates'],
                    title:
                    'VETASSESS New Webinar – Engineering Trades | May 6',
                    description:
                    'VETASSESS will hold a Skills Assessment Webinar on Tuesday, May 6, with a focus on Engineering Trades and a live Q&A session.',
                    link: '/news/vetassess-new-webinar-engineering-trades-may-6',
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _NewsItem(
                        
                        tags: ['News'],
                        title:
                        'VETASSESS New Webinar – Pharmacy Technician & Microbiologist Skills Assessment Process | April 2',
                        link:
                        '/news/vetassess-new-webinar-pharmacy-technician-microbiologist-skills-assessment-process-april-2',
                      ),
                      const SizedBox(height: 20),
                      _NewsItem(
                       
                        tags: ['News'],
                        title:
                        'VETASSESS and Australian Institute of Health and Safety partner on qualifications recognition',
                        link:
                        '/news/vetassess-and-australian-institute-of-health-and-safety-partner-on-qualifications-recognition',
                      ),
                      const SizedBox(height: 20),
                      _NewsItem(
                       
                        tags: ['News'],
                        title:
                        'Massage & Myotherapy Australia endorses VETASSESS criteria',
                        link:
                        '/news/massage-myotherapy-australia-endorses-vetassess-criteria',
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturedArticle extends StatelessWidget {
  final String image;
  final List<String> tags;
  final String title;
  final String description;
  final String link;

  const _FeaturedArticle({
    required this.image,
    required this.tags,
    required this.title,
    required this.description,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 6,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF004D40), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'News',
                style: TextStyle(fontSize: 12, color: Color(0xFF004D40)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF004D40), width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Updates',
                style: TextStyle(fontSize: 12, color: Color(0xFF004D40)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => context.go(link),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Read article',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF004D40),
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF004D40),
                ),
                child: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 14),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _NewsItem extends StatelessWidget {
  
  final List<String> tags;
  final String title;
  final String link;

  const _NewsItem({
    
    required this.tags,
    required this.title,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image thumbnail
        ClipRect(
          child: SizedBox(
            width: 70,
            height: 70,
           // child: Image.asset( fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 16),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tag
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF004D40), width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tags.first,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF004D40)),
                ),
              ),
              // Title
              Text(
                title,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 8),
              // Read article link
              GestureDetector(
                onTap: () => context.go(link),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Read article',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF004D40),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF004D40),
                      ),
                      child: const Icon(Icons.arrow_forward,
                          color: Colors.white, size: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}