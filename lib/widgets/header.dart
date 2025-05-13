import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/login.dart';
import 'package:vetassess/screens/login_page.dart';

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
    final double height = mediaQuery.size.height;

    // Define responsive breakpoints
    final bool isLargeDesktop = width >= 1400;
    final bool isDesktop = width >= 1024;
    final bool isTablet = width >= 768 && width < 1024;
    final bool isSmallTablet = width >= 600 && width < 768;
    final bool isMobile = width < 600;

    // Calculate dynamic sizes based on screen width
    final double logoHeight = isDesktop ? 110 : (isTablet ? 90 : 70);
    final double topBarWidth =
        isDesktop ? width * 0.490 : (isTablet ? width * 0.7 : width * 0.85);
    final double navItemSpacing = isLargeDesktop ? 32 : (isDesktop ? 24 : 16);

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
                  height: logoHeight,
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
                    height: isDesktop ? 60 : 50,
                    width: topBarWidth,
                    child: Row(
                      children: [
                        // Left side empty space
                        const Spacer(),

                        // Right side - links and apply button
                        if (isDesktop || isTablet) ...[
                          Row(
                            mainAxisSize: MainAxisSize.max,
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
                                  child: Text(
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
                        Container(
                          height: isDesktop ? 48 : 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA000),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 14 : 12,
                                vertical: isDesktop ? 12 : 8,
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

                // Main navigation header - UPDATED to match screenshot with responsive design
                Container(
                  color: Colors.white,
                  height: isDesktop ? 70 : 60,
                  width: width,
                  padding: EdgeInsets.only(top: isDesktop ? 12 : 8),
                  child:
                      isDesktop
                          ? _buildDesktopNavBar(navItemSpacing, isLargeDesktop)
                          : _buildMobileNavBar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavBar(double spacing, bool isLargeDesktop) {
    // Dynamic font size based on screen width
    final double fontSize = isLargeDesktop ? 17.0 : 15.0;
    final double iconSize = isLargeDesktop ? 50.0 : 40.0;
    final double searchIconSize = isLargeDesktop ? 25.0 : 25.0;
    final double sideMargin = isLargeDesktop ? 20.0 : 12.0;

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
                // Search icon with circular background
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: const BoxDecoration(
                    //color: Color(0xFFFFA000),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Color(0xFFFFA000),
                    size: searchIconSize,
                  ),
                ),
                SizedBox(width: spacing),
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
        // Search icon for mobile
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
              // Implementation would go here
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
          height: 48,
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
    path.lineTo(size.width * 0.045, size.height); // Bottom-left (inward)
    path.close(); // back to top-left
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
