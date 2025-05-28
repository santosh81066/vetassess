import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/applioptions.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  // Custom input field to reduce code duplication
  Widget _buildInputField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border(
              top: BorderSide(color: Colors.grey[400]!),
              left: BorderSide(color: Colors.grey[400]!),
              bottom: BorderSide(color: Colors.grey[400]!),
            ),
          ),
          child: Icon(icon, color: Colors.grey[800], size: 20),
        ),
        Expanded(
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to get responsive dimensions
  double _getResponsiveWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      // Mobile
      return screenWidth * 0.9; // 90% of screen width
    } else if (screenWidth < 1024) {
      // Tablet
      return screenWidth * 0.7; // 70% of screen width
    } else {
      // Desktop
      return 560; // Fixed width for desktop
    }
  }

  double _getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      // Mobile
      return 20.0;
    } else if (screenWidth < 1024) {
      // Tablet
      return 60.0;
    } else {
      // Desktop
      return 100.0;
    }
  }

  double _getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      // Mobile - slightly smaller fonts
      return baseFontSize * 0.9;
    } else {
      return baseFontSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;
    
    return LoginPageLayout(
      child: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16.0 : 0,
              vertical: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Welcome to the Skills Recognition Service',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 20),
                    color: Colors.grey[700],
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  width: _getResponsiveWidth(context),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      // Login header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: isSmallScreen ? 8 : 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 14),
                            color: Colors.grey[800],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Login form
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          _getResponsivePadding(context),
                          isSmallScreen ? 20.0 : 28.0,
                          _getResponsivePadding(context),
                          isSmallScreen ? 20.0 : 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Username field
                            _buildInputField(
                              icon: Icons.person,
                              hint: 'Username/Email',
                              controller: _usernameController,
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 20),

                            // Password field
                            _buildInputField(
                              icon: Icons.lock,
                              hint: 'Password',
                              controller: _passwordController,
                              isPassword: true,
                            ),

                            // Forgot password link
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.orange[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: _getResponsiveFontSize(context, 14),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 8 : 10),

                            // Verification image
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Verification image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: _getResponsiveFontSize(context, 14),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[400]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/captcha.jpg',
                                    height: isSmallScreen ? 32 : 36,
                                    width: isSmallScreen ? 200 : 250,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Captcha input
                            Text(
                              'Enter text shown in the image',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: _getResponsiveFontSize(context, 14),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 38,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]!),
                              ),
                              child: TextField(
                                controller: _captchaController,
                                decoration: const InputDecoration(
                                  hintText: 'Text shown in the image',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 24 : 30),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: isSmallScreen ? 44 : 38,
                              child: ElevatedButton(
                                onPressed: () => context.go('/appli_opt'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00897B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: _getResponsiveFontSize(context, 16),
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 8 : 10),

                            // Registration links - responsive layout
                            isSmallScreen
                                ? Column(
                                    children: [
                                      Text(
                                        'Not yet registered?',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: _getResponsiveFontSize(context, 12),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Sign up as ',
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: _getResponsiveFontSize(context, 12),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            child: Text(
                                              'applicant',
                                              style: TextStyle(
                                                color: Colors.orange[800],
                                                fontWeight: FontWeight.normal,
                                                fontSize: _getResponsiveFontSize(context, 12),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            ' or ',
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: _getResponsiveFontSize(context, 12),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            child: Text(
                                              'agent',
                                              style: TextStyle(
                                                color: Colors.orange[800],
                                                fontWeight: FontWeight.normal,
                                                fontSize: _getResponsiveFontSize(context, 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Not yet registered? Sign up as',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: _getResponsiveFontSize(context, 12),
                                        ),
                                      ),
                                      for (final type in ['applicant', 'agent'])
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                minimumSize: Size.zero,
                                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                              child: Text(
                                                type,
                                                style: TextStyle(
                                                  color: Colors.orange[800],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: _getResponsiveFontSize(context, 12),
                                                ),
                                              ),
                                            ),
                                            if (type == 'applicant')
                                              Text(
                                                'or',
                                                style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: _getResponsiveFontSize(context, 12),
                                                ),
                                              ),
                                          ],
                                        ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _captchaController.dispose();
    super.dispose();
  }
}