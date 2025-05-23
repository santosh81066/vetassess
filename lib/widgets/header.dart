import 'package:flutter/material.dart';
import 'package:vetassess/screens/apply_screen.dart';
import 'package:vetassess/screens/login_page.dart';
import '../screens/home_screen.dart';
import 'BusinessIndustryDropdownPanel.dart';
import 'SkillsAssessmentDropdownPanel.dart';
import 'SkillsAssessmentNonMigrationDropdownPanel.dart';

// Responsive utility class to maintain consistency across the app
class ResponsiveUtils {
  static bool isSmallMobile(BuildContext context) => MediaQuery.of(context).size.width < 480;
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
  static bool isLargeDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1400;
  
  static double getResponsiveValue({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
    double? largeDesktop,
  }) {
    if (isLargeDesktop(context)) return largeDesktop ?? desktop;
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }
}

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

    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final overlay = Overlay.of(context);
    _dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
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
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;
    
    // Enhanced responsive breakpoints
    final bool isSmallMobile = ResponsiveUtils.isSmallMobile(context);
    final bool isMobile = ResponsiveUtils.isMobile(context);
    final bool isTablet = ResponsiveUtils.isTablet(context);
    final bool isDesktop = ResponsiveUtils.isDesktop(context);
    final bool isLargeDesktop = ResponsiveUtils.isLargeDesktop(context);

    // Responsive logo sizing with better scaling
    final double logoHeight = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: isSmallMobile ? width * 0.14 : width * 0.12,
      tablet: width * 0.09,
      desktop: width * 0.08,
      largeDesktop: width * 0.07,
    ).clamp(60.0, 120.0);

    // Responsive top bar width
    final double topBarWidth = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: width * 0.9,
      tablet: width * 0.75,
      desktop: width * 0.52,
      largeDesktop: width * 0.48,
    );

    // Responsive spacing
    final double navItemSpacing = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: width * 0.015,
      tablet: width * 0.018,
      desktop: width * 0.022,
      largeDesktop: width * 0.023,
    ).clamp(12.0, 35.0);

    // Responsive container heights
    final double topBarHeight = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: width * 0.06,
      tablet: width * 0.055,
      desktop: width * 0.045,
      largeDesktop: width * 0.042,
    ).clamp(40.0, 65.0);

    final double navBarHeight = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: width * 0.07,
      tablet: width * 0.065,
      desktop: width * 0.052,
      largeDesktop: width * 0.048,
    ).clamp(45.0, 75.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Section with enhanced responsive padding
              Padding(
                padding: EdgeInsets.only(
                  top: ResponsiveUtils.getResponsiveValue(
                    context: context,
                    mobile: 6.0,
                    tablet: 8.0,
                    desktop: 12.0,
                  ),
                  left: ResponsiveUtils.getResponsiveValue(
                    context: context,
                    mobile: 8.0,
                    tablet: 4.0,
                    desktop: 0.0,
                  ),
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
                      fit: BoxFit.contain, // Ensures proper scaling
                    ),
                  ),
                ),
              ),

              // Main content area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Top header with enhanced responsive design
                    ClipPath(
                      clipper: TrapezoidClipper(),
                      child: Container(
                        color: const Color(0xFFf0f0f0),
                        height: topBarHeight,
                        width: topBarWidth,
                        child: _buildTopHeader(isDesktop, isTablet, isMobile, topBarHeight),
                      ),
                    ),

                    // Main navigation with improved responsive handling
                    Container(
                      color: Colors.white,
                      height: navBarHeight,
                      width: width,
                      padding: EdgeInsets.only(
                        top: ResponsiveUtils.getResponsiveValue(
                          context: context,
                          mobile: width * 0.02,
                          tablet: width * 0.018,
                          desktop: width * 0.012,
                          largeDesktop: width * 0.01,
                        ),
                      ),
                      child: isDesktop
                          ? _buildDesktopNavBar(navItemSpacing, isLargeDesktop, width)
                          : _buildMobileNavBar(isMobile, isSmallMobile),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopHeader(bool isDesktop, bool isTablet, bool isMobile, double topBarHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Flexible spacer
        if (isDesktop || isTablet) Expanded(flex: 2, child: Container()),

        // Top navigation items with responsive sizing
        if (isDesktop || isTablet) ...[
          _buildLanguageSelector(),
          SizedBox(width: ResponsiveUtils.getResponsiveValue(
            context: context,
            mobile: 12.0,
            tablet: 16.0,
            desktop: 24.0,
          )),

          // Desktop-only links
          if (isDesktop) ...[
            const _TopLink(text: "About"),
            const SizedBox(width: 24),
            const _TopLink(text: "Resources"),
            const SizedBox(width: 24),
            const _TopLink(text: "News & Updates"),
            const SizedBox(width: 24),
          ],

          _buildLoginSection(),
          SizedBox(width: ResponsiveUtils.getResponsiveValue(
            context: context,
            mobile: 8.0,
            tablet: 12.0,
            desktop: 16.0,
          )),
        ],

        // Apply Now Button with responsive sizing
        Container(
          height: topBarHeight * 0.8,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApplyScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA000),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getResponsiveValue(
                  context: context,
                  mobile: 10.0,
                  tablet: 12.0,
                  desktop: 14.0,
                ),
                vertical: 0,
              ),
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveUtils.getResponsiveValue(
                  context: context,
                  mobile: 11.0,
                  tablet: 12.0,
                  desktop: 14.0,
                ),
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
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.language_outlined,
          size: ResponsiveUtils.getResponsiveValue(
            context: context,
            mobile: 16.0,
            tablet: 17.0,
            desktop: 18.0,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          "English",
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveValue(
              context: context,
              mobile: 12.0,
              tablet: 12.5,
              desktop: 13.0,
            ),
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          size: ResponsiveUtils.getResponsiveValue(
            context: context,
            mobile: 13.0,
            tablet: 13.5,
            desktop: 14.0,
          ),
          color: Colors.black54,
        ),
      ],
    );
  }

  Widget _buildLoginSection() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            size: ResponsiveUtils.getResponsiveValue(
              context: context,
              mobile: 16.0,
              tablet: 17.0,
              desktop: 18.0,
            ),
            color: Colors.black54,
          ),
          const SizedBox(width: 6),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: ResponsiveUtils.getResponsiveValue(
                  context: context,
                  mobile: 13.0,
                  tablet: 13.5,
                  desktop: 14.0,
                ),
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopNavBar(double spacing, bool isLargeDesktop, double screenWidth) {
    final double fontSize = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: 13.0,
      tablet: 14.0,
      desktop: screenWidth * 0.011,
      largeDesktop: screenWidth * 0.012,
    ).clamp(13.0, 18.0);

    final double iconSize = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: 35.0,
      tablet: 38.0,
      desktop: screenWidth * 0.032,
      largeDesktop: screenWidth * 0.036,
    ).clamp(35.0, 52.0);

    final double searchIconSize = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: 20.0,
      tablet: 22.0,
      desktop: 22.0,
      largeDesktop: 25.0,
    );

    final double sideMargin = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: screenWidth * 0.012,
      largeDesktop: screenWidth * 0.014,
    ).clamp(8.0, 26.0);

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
                  onTap: () => _showDropdown(
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
                  onTap: () => _showDropdown(
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
                  onTap: () => _showDropdown(
                    _businessNavKey,
                    const BusinessIndustryDropdownPanel(),
                  ),
                ),
                SizedBox(width: spacing),
                _NavItem(title: "Contact", fontSize: fontSize),
                SizedBox(width: sideMargin),

                // Search icon with enhanced responsive sizing
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

                // Start Your Application with responsive sizing
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

  Widget _buildMobileNavBar(bool isMobile, bool isSmallMobile) {
    final double searchIconSize = isSmallMobile ? 18.0 : 20.0;
    final double containerSize = isSmallMobile ? 36.0 : 40.0;
    final double menuIconSize = isSmallMobile ? 24.0 : 28.0;
    final double marginRight = isSmallMobile ? 12.0 : 16.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Search icon for mobile with responsive sizing
        Container(
          width: containerSize,
          height: containerSize,
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFFFA000),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: searchIconSize,
          ),
        ),
        // Menu icon with responsive sizing
        Container(
          margin: EdgeInsets.only(right: marginRight),
          child: IconButton(
            onPressed: () {
              // Show mobile navigation drawer/menu
              _showMobileMenu();
            },
            icon: Icon(
              Icons.menu,
              color: Color(0xFF0D5E63),
              size: menuIconSize,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  void _showMobileMenu() {
    // Enhanced mobile menu implementation
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildMobileMenuSheet(),
    );
  }

  Widget _buildMobileMenuSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Mobile menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMobileMenuItem("Skills Assessment For Migration"),
                _buildMobileMenuItem("Skills Assessment Non Migration"),
                _buildMobileMenuItem("Check my Occupation"),
                _buildMobileMenuItem("Business and Industry"),
                _buildMobileMenuItem("Contact"),
                const Divider(),
                _buildMobileMenuItem("About"),
                _buildMobileMenuItem("Resources"),
                _buildMobileMenuItem("News & Updates"),
                _buildMobileMenuItem("Login"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0D5E63),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        // Handle navigation based on title
      },
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
      style: TextStyle(
        fontSize: ResponsiveUtils.getResponsiveValue(
          context: context,
          mobile: 12.0,
          tablet: 12.5,
          desktop: 13.0,
        ),
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
    final double width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width >= 1200;

    final Color defaultColor = widget.isHighlighted
        ? const Color(0xFF0D5E63)
        : const Color(0xFF0D5E63);

    final Color hoverColor = widget.isHighlighted
        ? const Color(0xFF0D5E63)
        : const Color(0xFFFFA000);

    final double iconSize = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: 13.0,
      tablet: 14.0,
      desktop: 14.0,
      largeDesktop: 16.0,
    );

    final double letterSpacing = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: 0.1,
      tablet: 0.2,
      desktop: 0.2,
      largeDesktop: 0.3,
    );

    final double containerHeight = ResponsiveUtils.getResponsiveValue(
      context: context,
      mobile: width * 0.04,
      tablet: width * 0.038,
      desktop: width * 0.034,
      largeDesktop: width * 0.034,
    ).clamp(35.0, 50.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: containerHeight,
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
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    
    // Enhanced responsive slope calculation
    final double slopeOffset = size.width * 0.045;
    path.lineTo(slopeOffset, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}