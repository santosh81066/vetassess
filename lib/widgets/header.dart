import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'SkillsAssessmentDropdownPanel.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  OverlayEntry? _dropdownOverlay;
  bool _isDropdownOpen = false;
  final GlobalKey _migrationNavKey = GlobalKey();

  void _showDropdown() {
    if (_isDropdownOpen) return;

    // ✅ SAFETY CHECK: prevent crash if widget not laid out yet
    if (_migrationNavKey.currentContext == null) return;

    final RenderBox renderBox = _migrationNavKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    print('Dropdown Offset: $offset');
    print('Dropdown Size: $size');
    final overlay = Overlay.of(context);
    _dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + size.height + 8,
        left: offset.dx,
        child: MouseRegion(
          onExit: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _hideDropdown();
            });
          },
          child: const SkillsAssessmentDropdownPanel(),
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

    return Column(
      children: [
        // Top Utility Bar
        Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isMobile) ...[
                const _TopLink(icon: Icons.language, text: "English"),
                const SizedBox(width: 24),
                const _TopLink(text: "About"),
                const SizedBox(width: 24),
                const _TopLink(text: "Resources"),
                const SizedBox(width: 24),
                const _TopLink(text: "News & Updates"),
                const SizedBox(width: 24),
                const _TopLink(icon: Icons.person_outline, text: "Login"),
              ],
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA000),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Apply Now"),
              ),
            ],
          ),
        ),

        // Main Navigation Bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                height: isMobile ? 40 : 55,
              ),
              const SizedBox(width: 32),
              if (isDesktop)
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 32,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _NavItem(
                        key: _migrationNavKey,
                        title: "Skills Assessment For Migration",
                        onTap: _showDropdown,
                      ),
                      const _NavItem(title: "Skills Assessment Non Migration"),
                      const _NavItem(title: "Check my Occupation"),
                      const _NavItem(title: "Business and Industry"),
                      const _NavItem(title: "Contact"),
                      const _NavItem(title: "Start Your Application"),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, color: Color(0xFFFFA000)),
                      ),
                    ],
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
    );
  }
}

class _TopLink extends StatelessWidget {
  final IconData? icon;
  final String text;

  const _TopLink({this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.black),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _NavItem({Key? key, required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onTap?.call(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF004D40),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

