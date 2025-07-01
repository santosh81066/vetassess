import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/screens/home_screen.dart';


class AdminHeader extends ConsumerWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Define breakpoints
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    // Check if user is logged in and not on login screen
    final loginState = ref.watch(loginProvider);
    final currentRoute = GoRouterState.of(context).uri.path;

    final shouldShowLogout =
        (loginState.isSuccess && loginState.response != null) &&
        currentRoute != '/login';

    // Responsive values
    final headerHeight = _getResponsiveHeight(screenHeight, isMobile, isTablet);
    final logoSize = _getResponsiveLogoSize(isMobile, isTablet);
    final titleFontSize = _getResponsiveTitleSize(isMobile, isTablet);
    final horizontalPadding = _getResponsivePadding(
      screenWidth,
      isMobile,
      isTablet,
    );
    final spacingBetweenElements = _getResponsiveSpacing(isMobile, isTablet);

    return Column(
      children: [
        // Header with logo, title, and logout button
        Container(
          height: headerHeight,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              // Main header content (logo and title)
              _buildHeaderContent(
                context,
                ref,
                isMobile,
                isTablet,
                logoSize,
                titleFontSize,
                spacingBetweenElements,
              ),
              // Logout button positioned in top-right corner (only if logged in and not on login screen)
              if (shouldShowLogout)
                Positioned(
                  top: 8,
                  right: horizontalPadding,
                  child: _buildLogoutButton(context, ref, isMobile, isTablet),
                ),
            ],
          ),
        ),

        // Teal border line
        Container(height: 2, width: double.infinity, color: Colors.teal[700]),

        // Navigation bar without logout button (since it's now in header)
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: _buildNavigationBar(context, ref, isMobile, isTablet),
        ),
      ],
    );
  }

  Widget _buildHeaderContent(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    bool isTablet,
    double logoSize,
    double titleFontSize,
    double spacing,
  ) {
    if (isMobile) {
      // Stack layout for mobile
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // In the _buildHeaderContent method, replace the GestureDetector onTap:
          GestureDetector(
            onTap: () {
              final currentRoute = GoRouterState.of(context).uri.path;

              // If on login page, just navigate to home
              if (currentRoute == '/login') {
                context.go('/');
              } else {
                // If logged in and not on login page, show logout dialog
                final loginState = ref.watch(loginProvider);
                if (loginState.isSuccess && loginState.response != null) {
                  _showLogoutDialogImage(context, ref);
                } else {
                  // Not logged in, navigate to home
                  context.go('/');
                }
              }
            },
            child: Image.asset(
              'assets/images/vetassess_logo.png',
              height: logoSize,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: spacing / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Skills Recognition General Occupations',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.teal[800],
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                height: 1.2,
              ),
            ),
          ),
        ],
      );
    } else {
      // Row layout for tablet and desktop
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // In the _buildHeaderContent method, replace the GestureDetector onTap:
          GestureDetector(
            onTap: () {
              final currentRoute = GoRouterState.of(context).uri.path;

              // If on login page, just navigate to home
              if (currentRoute == '/login') {
                context.go('/');
              } else {
                // If logged in and not on login page, show logout dialog
                final loginState = ref.watch(loginProvider);
                if (loginState.isSuccess && loginState.response != null) {
                  _showLogoutDialogImage(context, ref);
                } else {
                  // Not logged in, navigate to home
                  context.go('/');
                }
              }
            },
            child: Image.asset(
              'assets/images/vetassess_logo.png',
              height: logoSize,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: spacing),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: isTablet ? 8 : 14),
              child: Text(
                'Skills Recognition General Occupations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  color: Colors.teal[800],
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildNavigationBar(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    bool isTablet,
  ) {
    final iconSize = isMobile ? 20.0 : 24.0;
    final textSize = isMobile ? 12.0 : 14.0;

    if (isMobile) {
      // Mobile navigation without logout button (now in header)
      return SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.orange[900],
                  size: iconSize,
                ),
                onPressed: () {
                  context.go('/appli_opt');
                },
              ),
            ),
            for (final item in ['Contact', 'Links', 'FAQs'])
              TextButton(
                onPressed: () {},
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.orange[900],
                    fontSize: textSize,
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      // Original navigation for tablet and desktop
      return SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.orange[900], size: iconSize),
              onPressed: () {
                context.go('/appli_opt');
              },
            ),
            for (final item in ['Contact us', 'Useful links', 'FAQs'])
              TextButton(
                onPressed: () {
                  if (item == 'Contact us') {
                    _launchURL('https://www.vetassess.com.co/#/contact_us');
                  }
                  if (item == 'Useful links') {
                    showUsefulLinksDialog(context);
                  }
                },
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.orange[900],
                    fontSize: textSize,
                  ),
                ),
              ),
            SizedBox(width: isTablet ? 20 : 50),
          ],
        ),
      );
    }
  }

  Widget _buildLogoutButton(
    BuildContext context,
    WidgetRef ref,
    bool isMobile,
    bool isTablet,
  ) {
    // Responsive button sizing
    final buttonTextSize = isMobile ? 10.0 : (isTablet ? 11.0 : 12.0);
    final buttonPadding = isMobile ? 6.0 : (isTablet ? 8.0 : 10.0);
    final iconSize = isMobile ? 14.0 : (isTablet ? 16.0 : 18.0);
    final borderRadius = isMobile ? 3.0 : 4.0;

    return Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      child: TextButton(
        onPressed: () {
          _showLogoutDialog(context, ref);
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.orange[900],
          padding: EdgeInsets.symmetric(
            horizontal: buttonPadding,
            vertical: buttonPadding,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: Colors.orange[900]!, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout, size: iconSize, color: Colors.orange[900]),
            SizedBox(width: isMobile ? 3.0 : 4.0),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: buttonTextSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Consumer(
          builder: (context, ref, child) {
            final loginState = ref.watch(loginProvider);

            return AlertDialog(
              title: const Text('Logout'),
              content:
                  loginState.isLoading
                      ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Logging out...'),
                        ],
                      )
                      : const Text('Are you sure you want to logout?'),
              actions:
                  loginState.isLoading
                      ? []
                      : [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Perform logout using the provider
                            await ref.read(loginProvider.notifier).logout();

                            // Close dialog first
                            if (dialogContext.mounted) {
                              Navigator.of(dialogContext).pop();
                            }

                            // Navigate using GoRouter
                            if (context.mounted) {
                              // Use GoRouter to navigate and clear stack
                              context.go('/login');

                              // Show logout success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully logged out'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
            );
          },
        );
      },
    );
  }

  void _showLogoutDialogImage(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Consumer(
          builder: (context, ref, child) {
            final loginState = ref.watch(loginProvider);

            return AlertDialog(
              title: const Text('Logout'),
              content:
                  loginState.isLoading
                      ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Logging out...'),
                        ],
                      )
                      : const Text('Are you sure you want to logout?'),
              actions:
                  loginState.isLoading
                      ? []
                      : [
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Perform logout using the provider
                            await ref.read(loginProvider.notifier).logout();

                            // Close dialog first
                            if (dialogContext.mounted) {
                              Navigator.of(dialogContext).pop();
                            }

                            if (context.mounted) {
                              context.pushReplacement('/');

                              // Show logout success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully logged out'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
            );
          },
        );
      },
    );
  }

  double _getResponsiveHeight(
    double screenHeight,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) {
      return screenHeight * 0.15; // 15% of screen height
    } else if (isTablet) {
      return screenHeight * 0.12; // 12% of screen height
    } else {
      return screenHeight / 6; // Original desktop size
    }
  }

  double _getResponsiveLogoSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 40.0;
    } else if (isTablet) {
      return 50.0;
    } else {
      return 60.0; // Original size
    }
  }

  double _getResponsiveTitleSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 22.0;
    } else {
      return 30.0; // Original size
    }
  }

  double _getResponsivePadding(
    double screenWidth,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) {
      return 8.0;
    } else if (isTablet) {
      return 16.0;
    } else {
      return 24.0; // Original padding
    }
  }

  double _getResponsiveSpacing(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 28.0;
    } else {
      return 40.0; // Original spacing
    }
  }

  void showUsefulLinksDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54, // Dimmed background
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Useful Links',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Description text
                const Text(
                  'If you wish to find out more about your nominated occupation, the assessment process, or information about migration and working in Australia, please see the links below.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                // Application process section
                const Text(
                  'Application process',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'VETASSESS - ',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap:
                              () => _launchURL('https://www.vetassess.com.co'),
                          child: const Text(
                            'https://www.vetassess.com.co',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFE07A39),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Visa and migration information section
                const Text(
                  'Visa and migration information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'The Department of Home Affairs ',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap:
                              () =>
                                  _launchURL('https://www.homeaffairs.gov.au'),
                          child: const Text(
                            'https://www.homeaffairs.gov.au',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFE07A39),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Occupational information section
                const Text(
                  'Occupational information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'VETASSESS\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap:
                                  () => _launchURL(
                                    'http://www.vetassess.com.au/skills-assessment-for-migration/general-occupations/nominate-an-occupation',
                                  ),
                              child: const Text(
                                'http://www.vetassess.com.au/skills-assessment-for-migration/general-occupations/nominate-an-occupation',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFE07A39),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'The Department of Home Affairs\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap:
                                  () => _launchURL(
                                    'https://www.homeaffairs.gov.au',
                                  ),
                              child: const Text(
                                'https://www.homeaffairs.gov.au',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFE07A39),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text:
                                'The Australian Bureau of Statistics (ABS)\nnote this contains all occupations, not only those available for migration\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => _launchURL('http://www.abs.gov.au'),
                              child: const Text(
                                'http://www.abs.gov.au',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFE07A39),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Jobs guide\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap:
                                  () => _launchURL(
                                    'https://education.gov.au/job-guide',
                                  ),
                              child: const Text(
                                'https://education.gov.au/job-guide',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFE07A39),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Close button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00565B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
