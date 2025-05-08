import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isMobile = width < 600;

    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Section (Left side)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: GestureDetector(
              onTap: () {
                context.go('/');
              },
              child: Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/images/vetassess_logo.png',
                  height: 110,
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
                    height: 50,
                    width: width * 0.425,
                    child: Row(
                      children: [
                        // Left side empty space
                        const Spacer(),

                        // Right side - links and apply button
                        if (!isMobile) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.language_outlined),
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
                          const SizedBox(width: 24),
                          const _TopLink(text: "About"),
                          const SizedBox(width: 24),
                          const _TopLink(text: "Resources"),
                          const SizedBox(width: 24),
                          const _TopLink(text: "News & Updates"),
                          const SizedBox(width: 24),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 16,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                        ],
                        Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA000),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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

                // Main navigation header
                Container(
                  color: Colors.white,
                  height: 72,
                  padding: const EdgeInsets.only(top: 28, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Navigation items
                      if (isDesktop)
                        Expanded(
                          child: DefaultTextStyle(
                            style: const TextStyle(color: Color(0xFF0D5E63)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Main navigation items
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _NavItem(
                                      key: _migrationNavKey,
                                      title: "Skills Assessment For Migration",
                                      hasDropdown: true,
                                      onTap:
                                          () => _showDropdown(
                                            _migrationNavKey,
                                            const SkillsAssessmentDropdownPanel(),
                                          ),
                                    ),
                                    const SizedBox(width: 28),
                                    _NavItem(
                                      key: _nonMigrationNavKey,
                                      title: "Skills Assessment Non Migration",
                                      hasDropdown: true,
                                      onTap:
                                          () => _showDropdown(
                                            _nonMigrationNavKey,
                                            const SkillsAssessmentNonMigrationPanel(),
                                          ),
                                    ),
                                    const SizedBox(width: 28),
                                    const _NavItem(
                                      title: "Check my Occupation",
                                    ),
                                    const SizedBox(width: 28),
                                    _NavItem(
                                      key: _businessNavKey,
                                      title: "Business and Industry",
                                      hasDropdown: true,
                                      onTap:
                                          () => _showDropdown(
                                            _businessNavKey,
                                            const BusinessIndustryDropdownPanel(),
                                          ),
                                    ),
                                    const SizedBox(width: 28),
                                    const _NavItem(title: "Contact"),
                                    Container(
                                      width: 48,
                                      height: 72,
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.search,
                                          color: Color(0xFFFFA000),
                                          size: 28,
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                    const SizedBox(width: 28),
                                    const _NavItem(
                                      title: "Start Your Application",
                                    ),
                                    const SizedBox(width: 14),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.menu, color: Colors.black),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
  final VoidCallback? onTap;

  const _NavItem({
    Key? key,
    required this.title,
    this.hasDropdown = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 72,
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.3,
                  color:
                      _isHovering
                          ? const Color(0xFFFFA000)
                          : const Color(0xFF0D5E63),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (widget.hasDropdown) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color:
                      _isHovering
                          ? const Color(0xFFFFA000)
                          : const Color(0xFF0D5E63),
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
