import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Add this import
import '../providers/login_provider.dart';

class LoginHeader extends ConsumerWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    // Define breakpoints
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;
    
    // Responsive values
    final headerHeight = _getResponsiveHeight(screenHeight, isMobile, isTablet);
    final logoSize = _getResponsiveLogoSize(isMobile, isTablet);
    final titleFontSize = _getResponsiveTitleSize(isMobile, isTablet);
    final horizontalPadding = _getResponsivePadding(screenWidth, isMobile, isTablet);
    final spacingBetweenElements = _getResponsiveSpacing(isMobile, isTablet);
    
    return Column(
      children: [
        // Header with logo and title
        Container(
          height: headerHeight,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: _buildHeaderContent(
            context,
            ref,
            isMobile,
            isTablet,
            logoSize,
            titleFontSize,
            spacingBetweenElements,
          ),
        ),

        // Teal border line
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.teal[700],
        ),

        // Navigation bar with logout button
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
          Image.asset(
            'assets/images/vetassess_logo.png',
            height: logoSize,
            fit: BoxFit.contain,
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
          Image.asset(
            'assets/images/vetassess_logo.png',
            height: logoSize,
            fit: BoxFit.contain,
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
          // Logout button positioned on the right for tablet and desktop
          if (!isMobile) _buildLogoutButton(context, ref, isTablet),
        ],
      );
    }
  }

  Widget _buildNavigationBar(BuildContext context, WidgetRef ref, bool isMobile, bool isTablet) {
    final iconSize = isMobile ? 20.0 : 24.0;
    final textSize = isMobile ? 12.0 : 14.0;
    
    if (isMobile) {
      // More compact navigation for mobile with logout button
      return SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.orange[900],
                      size: iconSize,
                    ),
                    onPressed: () {
                       context.go('/');
                    },
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
            ),
            // Logout button for mobile
            _buildLogoutButton(context, ref, false),
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
              icon: Icon(
                Icons.home,
                color: Colors.orange[900],
                size: iconSize,
              ),
              onPressed: () {},
            ),
            for (final item in ['Contact us', 'Useful links', 'FAQs'])
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
            SizedBox(width: isTablet ? 20 : 50),
          ],
        ),
      );
    }
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref, bool isTablet) {
    final buttonTextSize = isTablet ? 12.0 : 14.0;
    final buttonPadding = isTablet ? 8.0 : 12.0;
    
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: TextButton(
        onPressed: () {
          _showLogoutDialog(context, ref);
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.orange[900],
          padding: EdgeInsets.symmetric(
            horizontal: buttonPadding,
            vertical: 4.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: Colors.orange[900]!,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout,
              size: buttonTextSize + 2,
              color: Colors.orange[900],
            ),
            const SizedBox(width: 4.0),
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
              content: loginState.isLoading 
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Logging out...'),
                    ],
                  )
                : const Text('Are you sure you want to logout?'),
              actions: loginState.isLoading 
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

  double _getResponsiveHeight(double screenHeight, bool isMobile, bool isTablet) {
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

  double _getResponsivePadding(double screenWidth, bool isMobile, bool isTablet) {
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
}