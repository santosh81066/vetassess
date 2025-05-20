import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/login.dart';
import 'package:vetassess/screens/login_page.dart';

import '../screens/application_forms/appli_occupation.dart';
import '../screens/application_forms/appli_personal_details.dart';
import '../screens/home_screen.dart';
import 'BusinessIndustryDropdownPanel.dart';
import 'SkillsAssessmentDropdownPanel.dart';
import 'SkillsAssessmentNonMigrationDropdownPanel.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  OverlayEntry? _dropdownOverlay;
  bool _isDropdownOpen = false;
  final GlobalKey _migrationNavKey = GlobalKey();
  final GlobalKey _nonMigrationNavKey = GlobalKey();
  final GlobalKey _businessNavKey = GlobalKey();

  void _showDropdown(GlobalKey key, Widget panel) {
    if (_isDropdownOpen) return;
    if (key.currentContext == null) return;

    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final overlay = Overlay.of(context);
    _dropdownOverlay = OverlayEntry(
      builder:
          (context) => Positioned(
            top: offset.dy + size.height,
            left: 0,
            right: 0,
            child: MouseRegion(
              onExit: (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _hideDropdown();
                });
              },
              child: panel,
            ),
          ),
    );

    overlay.insert(_dropdownOverlay!);
    setState(() => _isDropdownOpen = true);
  }

  void _hideDropdown() {
    if (!_isDropdownOpen) return;
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
    setState(() => _isDropdownOpen = false);
  }

  @override
  void dispose() {
    _dropdownOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current screen size
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;

    // Define responsive breakpoints
    final bool isLargeDesktop = width >= 1400;
    final bool isDesktop = width >= 1024;
    final bool isTablet = width >= 768 && width < 1024;
    final bool isSmallTablet = width >= 600 && width < 768;
    final bool isMobile = width < 600;

    // Calculate dynamic sizes based on screen width - using relative proportions
    final double logoHeight =
        isDesktop ? width * 0.08 : (isTablet ? width * 0.09 : width * 0.12);
    final double logoHeightClamped = logoHeight.clamp(
      70.0,
      110.0,
    ); // Prevent logo from getting too large or small

    final double topBarWidth =
        isDesktop ? width * 0.490 : (isTablet ? width * 0.7 : width * 0.85);

    final double navItemSpacing =
        isLargeDesktop
            ? width * 0.023
            : (isDesktop ? width * 0.022 : width * 0.02);
    final double navItemSpacingClamped = navItemSpacing.clamp(16.0, 32.0);

    // Dynamic heights for containers based on screen width
    final double topBarHeight = (isDesktop ? width * 0.043 : width * 0.05)
        .clamp(45.0, 60.0);
    final double navBarHeight = (isDesktop ? width * 0.05 : width * 0.06).clamp(
      50.0,
      70.0,
    );

    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Section (Left side) - responsive sizing
          Padding(
            padding: EdgeInsets.only(
              top: isDesktop ? 12.0 : 8.0,
              left: isDesktop ? 0 : 8.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/images/vetassess_logo.png',
                  height: logoHeightClamped,
                ),
              ),
            ),
          ),

          // Right side with two rows
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Top header with language, about, resources, etc.
                ClipPath(
                  clipper: TrapezoidClipper(),
                  child: Container(
                    color: const Color(0xFFf0f0f0),
                    height: topBarHeight,
                    width: topBarWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Left side empty space
                        if (isDesktop || isTablet)
                          Expanded(flex: 2, child: Container()),

                        // Right side - links and apply button
                        if (isDesktop || isTablet) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.language_outlined, size: 18),
                              const SizedBox(width: 6),
                              const Text(
                                "English",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                size: 14,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          SizedBox(width: isDesktop ? 24 : 16),

                          if (isDesktop) ...[
                            const _TopLink(text: "About"),
                            const SizedBox(width: 24),
                            const _TopLink(text: "Resources"),
                            const SizedBox(width: 24),
                            const _TopLink(text: "News & Updates"),
                            const SizedBox(width: 24),
                          ],

                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 18,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 6),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2, // Better vertical alignment
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: isDesktop ? 16 : 12),
                        ],

                        // Apply Now Button - now with flexible height
                        Container(
                          height: topBarHeight * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalDetailsForm(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA000),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 14 : 12,
                                vertical:
                                    0, // Let the container control the height
                              ),
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: isDesktop ? 14 : 12,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              "Apply Now",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main navigation header - Improved responsive design
                Container(
                  color: Colors.white,
                  height: navBarHeight,
                  width: width,
                  padding: EdgeInsets.only(
                    top: isDesktop ? width * 0.01 : width * 0.015,
                  ),
                  child:
                      isDesktop
                          ? _buildDesktopNavBar(
                            navItemSpacingClamped,
                            isLargeDesktop,
                            width,
                          )
                          : _buildMobileNavBar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavBar(
    double spacing,
    bool isLargeDesktop,
    double screenWidth,
  ) {
    // Dynamic font size based on screen width with min and max values
    final double fontSize = (isLargeDesktop
            ? screenWidth * 0.012
            : screenWidth * 0.011)
        .clamp(14.0, 17.0);
    final double iconSize = (isLargeDesktop
            ? screenWidth * 0.036
            : screenWidth * 0.032)
        .clamp(38.0, 50.0);
    final double searchIconSize = (isLargeDesktop ? 25.0 : 22.0);
    final double sideMargin = (isLargeDesktop
            ? screenWidth * 0.014
            : screenWidth * 0.012)
        .clamp(12.0, 24.0);

    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: sideMargin),
                _NavItem(
                  key: _migrationNavKey,
                  title: "Skills Assessment For\nMigration",
                  hasDropdown: true,
                  fontSize: fontSize,
                  onTap:
                      () => _showDropdown(
                        _migrationNavKey,
                        const SkillsAssessmentDropdownPanel(),
                      ),
                ),
                SizedBox(width: spacing),
                _NavItem(
                  key: _nonMigrationNavKey,
                  title: "Skills Assessment Non\nMigration",
                  hasDropdown: true,
                  fontSize: fontSize,
                  onTap:
                      () => _showDropdown(
                        _nonMigrationNavKey,
                        const SkillsAssessmentNonMigrationPanel(),
                      ),
                ),
                SizedBox(width: spacing),
                _NavItem(title: "Check my\nOccupation", fontSize: fontSize),
                SizedBox(width: spacing),
                _NavItem(
                  key: _businessNavKey,
                  title: "Business and\nIndustry",
                  hasDropdown: true,
                  fontSize: fontSize,
                  onTap:
                      () => _showDropdown(
                        _businessNavKey,
                        const BusinessIndustryDropdownPanel(),
                      ),
                ),
                SizedBox(width: spacing),
                _NavItem(title: "Contact", fontSize: fontSize),
                SizedBox(width: sideMargin),

                // Search icon with circle - now with relative sizing
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFFFFA000),
                    size: searchIconSize,
                  ),
                ),
                SizedBox(width: spacing),

                // Start Your Application - now with responsive sizing
                _NavItem(
                  title: "Start Your\nApplication",
                  isHighlighted: true,
                  fontSize: fontSize,
                ),
                SizedBox(width: sideMargin),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Search icon for mobile - now with proportional sizing
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFFFA000),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.search, color: Colors.white, size: 20),
        ),
        // Menu icon for mobile navigation
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: () {
              // Show mobile navigation drawer/menu
            },
            icon: const Icon(Icons.menu, color: Color(0xFF0D5E63), size: 28),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

class _TopLink extends StatelessWidget {
  final String text;

  const _TopLink({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black54,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final bool hasDropdown;
  final bool isHighlighted;
  final double fontSize;
  final VoidCallback? onTap;

  const _NavItem({
    Key? key,
    required this.title,
    this.hasDropdown = false,
    this.isHighlighted = false,
    this.fontSize = 14.0,
    this.onTap,
  }) : super(key: key);

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive adjustments
    final double width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width >= 1200;

    // Colors based on highlighted state
    final Color defaultColor =
        widget.isHighlighted
            ? const Color(0xFF0D5E63)
            : const Color(0xFF0D5E63);

    final Color hoverColor =
        widget.isHighlighted
            ? const Color(0xFF0D5E63)
            : const Color(0xFFFFA000);

    // Responsive icon size
    final double iconSize = isLargeScreen ? 16.0 : 14.0;

    // Responsive letter spacing
    final double letterSpacing = isLargeScreen ? 0.3 : 0.2;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: (isLargeScreen ? width * 0.034 : width * 0.038).clamp(
            40.0,
            48.0,
          ),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  letterSpacing: letterSpacing,
                  color: _isHovering ? hoverColor : defaultColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.hasDropdown) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: iconSize,
                  color: _isHovering ? hoverColor : defaultColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Top-left corner
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width, size.height); // Bottom-right

    // Make the slope proportional to the width to maintain the trapezoid shape
    // at different screen sizes
    final double slopeOffset = size.width * 0.045;
    path.lineTo(slopeOffset, size.height); // Bottom-left (inward)
    path.close(); // back to top-left
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
