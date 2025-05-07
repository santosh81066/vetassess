import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 680,
      decoration: const BoxDecoration(
        color:  Color(0xFF0d5257),
        image: DecorationImage(
          image: AssetImage('assets/images/hero-img.png'),
          alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1244),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100, 160, 132, 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 450),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Australia’s largest skills\nassessment service.",
                        style: GoogleFonts.poppins(
                          fontSize: 40,
                          height: 64 / 54,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Check your occupation",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFA000),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Find out if we can assess your skills and experience.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 1.48,
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
                          fontSize: 18,
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
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2), // Adjust spacing here
                              Container(
                                height: 3,
                                width: 500, // Adjust to match text width or wrap dynamically
                                color: const Color.fromARGB(255, 69, 198, 221),
                              ),
                            ],
                          ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
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
                fontSize: 16.8,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF54555A),
              ),
              decoration: const InputDecoration(
                hintText: "Enter your occupation",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Color(0xFFFFA000),size: 30,weight: 20,),
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
                  fontSize: 16,
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
