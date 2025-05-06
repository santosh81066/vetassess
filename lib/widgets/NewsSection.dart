import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // optional if using go_router

class NewsUpdatesSection extends StatelessWidget {
  const NewsUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "News & Updates",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Get helpful tips, practical information and stay up-to-date with the latest migration news.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 32),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
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
              const SizedBox(width: 32, height: 32),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _NewsItem(
                      image: 'assets/images/featured_news.png',
                      tags: ['News'],
                      title:
                      'VETASSESS New Webinar – Pharmacy Technician & Microbiologist Skills Assessment Process | April 2',
                      link:
                      '/news/vetassess-new-webinar-pharmacy-technician-microbiologist-skills-assessment-process-april-2',
                    ),
                    const SizedBox(height: 24),
                    _NewsItem(
                      image: 'assets/images/featured_news.png',
                      tags: ['News'],
                      title:
                      'VETASSESS and Australian Institute of Health and Safety partner on qualifications recognition',
                      link:
                      '/news/vetassess-and-australian-institute-of-health-and-safety-partner-on-qualifications-recognition',
                    ),
                    const SizedBox(height: 24),
                    _NewsItem(
                      image: 'assets/images/featured_news.png',
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
        Image.asset(image, fit: BoxFit.cover),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: tags
              .map((tag) => Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF004D40)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF004D40)),
            ),
          ))
              .toList(),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 8),
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
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF004D40),
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFF004D40),
                child: Icon(Icons.arrow_forward,
                    color: Colors.white, size: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _NewsItem extends StatelessWidget {
  final String image;
  final List<String> tags;
  final String title;
  final String link;

  const _NewsItem({
    required this.image,
    required this.tags,
    required this.title,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, width: 120, height: 80, fit: BoxFit.cover),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: tags
                    .map((tag) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF004D40)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                        fontSize: 10, color: Color(0xFF004D40)),
                  ),
                ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => context.go(link),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Read article',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF004D40),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Color(0xFF004D40),
                      child: Icon(Icons.arrow_forward,
                          color: Colors.white, size: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
