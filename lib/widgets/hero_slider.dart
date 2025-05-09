import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    return Container(
      width: double.infinity,
      height: isMobile ? height * 0.9 : 675,
      decoration: BoxDecoration(
  color: const Color(0xFF0d5257),
  image: width >= 100
      ? const DecorationImage(
          image: AssetImage('assets/images/hero-img.png'),
          alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
        )
      : null,
),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isMobile = width < 600;
          final isTablet = width >= 600 && width < 1024;
      
          return Padding(
            padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 16 : isTablet ? 40 : 100,
      vertical: isMobile ? 24 : isTablet ? 60 : 100,
            ),
            
          child: isMobile
              ? _buildMobileLayout(context)
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMobile) SizedBox(width: isTablet ? 100 : 450),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildContent(context, width, isMobile, isTablet),
                      ),
                    ),
                  ],
                ),
        );
        },
      ),
    
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildContent(context, width, true, false),
    ),
  );
}


  List<Widget> _buildContent(BuildContext context, double screenWidth, bool isMobile, bool isTablet) {
    return [
      Text(
        "Australia’s largest skills\nassessment service.",
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 24 : isTablet ? 32 : 40,
          height: isMobile ? 1.3 : 1.4,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 24),
      Text(
        "Check your occupation",
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 18 : isTablet ? 24 : 30,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFA000),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        "Find out if we can assess your skills and experience.",
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 14 : 16,
          height: 1.5,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 24),
      const _SearchBar(),
      const SizedBox(height: 28),
      Text(
        "QUICK LINKS",
        style: GoogleFonts.poppins(
          fontSize: isMobile ? 16 : 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () {
          // TODO: Add navigation
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "VETASSESS New Webinar – May 6 | Engineering Trades",
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              height: 3,
              width: isMobile ? screenWidth * 0.7 : 500,
              color: const Color.fromARGB(255, 69, 198, 221),
            ),
          ],
        ),
      ),
    ];
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    return Container(
      height: 57,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFFFA000), width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16.8,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF54555A),
              ),
              decoration: const InputDecoration(
                hintText: "Enter your occupation",
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFFFA000),
                  size: 28,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFA000),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                "Search",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
