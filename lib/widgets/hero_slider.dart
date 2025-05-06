import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 660,
      decoration: const BoxDecoration(
        color: Color(0xFF006064),
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
                const SizedBox(width: 300),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Australia’s largest skills\nassessment service.",
                        style: GoogleFonts.poppins(
                          fontSize: 54,
                          height: 64 / 54,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 34),
                      Text(
                        "Check your occupation",
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFA000),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Find out if we can assess your skills and experience.",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          height: 1.48,
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const _SearchBar(),
                      const SizedBox(height: 32),
                      Text(
                        "QUICK LINKS",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
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
                        child: Text(
                          "VETASSESS New Webinar – May 6 | Engineering Trades",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.lightBlueAccent,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
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
    return SizedBox(
      height: 57,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFFFFA000), width: 2),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: GoogleFonts.poppins(
                  fontSize: 16.8,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF54555A),
                ),
                decoration: const InputDecoration(
                  hintText: "Enter your occupation",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA000),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              elevation: 0,
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
        ],
      ),
    );
  }
}
