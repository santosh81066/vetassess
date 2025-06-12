// screens/login.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/login_model.dart';
import '../providers/login_provider.dart';
import '../widgets/login_page_layout.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  String _selectedRole = "applicant"; // Default role
  bool _hasCheckedInitialAuth = false;

  @override
  void initState() {
    super.initState();
    // Check if user is already logged in first
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInitialAuthState();
    });
  }

  Future<void> _checkInitialAuthState() async {
    final loginNotifier = ref.read(loginProvider.notifier);
    final isLoggedIn = await loginNotifier.isLoggedIn();

    if (mounted) {
      setState(() {
        _hasCheckedInitialAuth = true;
      });

      if (isLoggedIn) {
        // User is already logged in, navigate to appropriate route based on role
        final navigationRoute = loginNotifier.getNavigationRouteForRole();
        context.go(navigationRoute);
        return;
      }
    }

    // Reset state and fetch captcha for fresh login
    ref.read(loginProvider.notifier).resetState();
    ref.read(loginProvider.notifier).fetchCaptcha();
  }

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

  void _handleLogin() {
    final loginState = ref.read(loginProvider);

    // Validate inputs
    if (_usernameController.text.trim().isEmpty) {
      _showSnackBar('Please enter username/email');
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      _showSnackBar('Please enter password');
      return;
    }
    if (_captchaController.text.trim().isEmpty) {
      _showSnackBar('Please enter captcha');
      return;
    }
    if (loginState.captcha == null) {
      _showSnackBar('Captcha not loaded. Please refresh.');
      return;
    }

    final loginRequest = LoginRequest(
      email: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      captchaInput: _captchaController.text.trim(),
      captchaOriginal: loginState.captcha!,
      role: _selectedRole,
    );

    ref.read(loginProvider.notifier).login(loginRequest);
  }

  void _refreshCaptcha() {
    ref.read(loginProvider.notifier).fetchCaptcha();
    _captchaController.clear();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red[600]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while checking initial authentication
    if (!_hasCheckedInitialAuth) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final loginState = ref.watch(loginProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Listen to login state changes for navigation
    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.isSuccess &&
          next.response != null &&
          previous?.isSuccess != true) {
        // Login just succeeded, navigate based on role
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final loginNotifier = ref.read(loginProvider.notifier);
            final navigationRoute = loginNotifier.getNavigationRouteForRole();
            context.go(navigationRoute);

            // Show success message with role info
            final roleName =
                next.userRole == 'admin'
                    ? 'Admin'
                    : next.userRole == 'agent'
                    ? 'Agent'
                    : 'Applicant';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login successful! Welcome $roleName'),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      } else if (next.error != null && next.error != previous?.error) {
        // New error occurred
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSnackBar(next.error!);
          }
        });
      }
    });

    return LoginPageLayout(
      child: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Welcome to the Skills Recognition services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 18 : 20,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: screenWidth < 600 ? screenWidth - 32 : 560,
                  constraints: const BoxConstraints(maxWidth: 560),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      // Login header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
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
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      // Login form
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          screenWidth < 600 ? 20.0 : 100.0,
                          28.0,
                          screenWidth < 600 ? 20.0 : 100.0,
                          24.0,
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
                            const SizedBox(height: 20),

                            // Password field
                            _buildInputField(
                              icon: Icons.lock,
                              hint: 'Password',
                              controller: _passwordController,
                              isPassword: true,
                            ),

                            // Role selection
                            const SizedBox(height: 10),
                            screenWidth < 600
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Role: ',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Radio<String>(
                                              value: 'applicant',
                                              activeColor: const Color(
                                                0xFF0d5257,
                                              ),
                                              groupValue: _selectedRole,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedRole = value!;
                                                });
                                              },
                                            ),
                                            const Text('Applicant'),
                                            const SizedBox(width: 20),
                                            Radio<String>(
                                              value: 'agent',
                                              activeColor: const Color(
                                                0xFF0d5257,
                                              ),
                                              groupValue: _selectedRole,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedRole = value!;
                                                });
                                              },
                                            ),
                                            const Text('Agent'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                              value: 'admin',
                                              activeColor: const Color(
                                                0xFF0d5257,
                                              ),
                                              groupValue: _selectedRole,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedRole = value!;
                                                });
                                              },
                                            ),
                                            const Text('Admin'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                : Row(
                                  children: [
                                    Text(
                                      'Role: ',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                    Radio<String>(
                                      value: 'applicant',
                                      activeColor: const Color(0xFF0d5257),
                                      groupValue: _selectedRole,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedRole = value!;
                                        });
                                      },
                                    ),
                                    const Text('Applicant'),
                                    const SizedBox(width: 10),
                                    Radio<String>(
                                      value: 'agent',
                                      activeColor: const Color(0xFF0d5257),
                                      groupValue: _selectedRole,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedRole = value!;
                                        });
                                      },
                                    ),
                                    const Text('Agent'),
                                    const SizedBox(width: 10),
                                    Radio<String>(
                                      value: 'admin',
                                      activeColor: const Color(0xFF0d5257),
                                      groupValue: _selectedRole,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedRole = value!;
                                        });
                                      },
                                    ),
                                    const Text('Admin'),
                                  ],
                                ),

                            // Forgot password link
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Navigate to forgot password screen
                                  context.go('/forgot-password');
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.orange[800],
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Verification image
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Verification image',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    TextButton(
                                      onPressed: _refreshCaptcha,
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.refresh,
                                            size: 16,
                                            color: Colors.orange[800],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Refresh',
                                            style: TextStyle(
                                              color: Colors.orange[800],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 36,
                                  width:
                                      screenWidth < 600
                                          ? screenWidth * 0.6
                                          : 250,
                                  constraints: const BoxConstraints(
                                    maxWidth: 250,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[400]!,
                                      width: 1,
                                    ),
                                    color: Colors.grey[100],
                                  ),
                                  child:
                                      loginState.isLoadingCaptcha
                                          ? const Center(
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                          : loginState.captcha != null
                                          ? Center(
                                            child: Text(
                                              loginState.captcha!,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 4,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                          : const Center(
                                            child: Text(
                                              'Failed to load captcha',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Captcha input
                            const Text(
                              'Enter text shown in the image',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14,
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

                            const SizedBox(height: 30),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: 38,
                              child: ElevatedButton(
                                onPressed:
                                    loginState.isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00897B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  elevation: 0,
                                ),
                                child:
                                    loginState.isLoading
                                        ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Registration links
                            screenWidth < 600
                                ? Column(
                                  children: [
                                    Text(
                                      'Not yet registered?',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign up as ',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 12,
                                          ),
                                        ),
                                        for (final type in [
                                          'applicant',
                                          'agent',
                                        ])
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  context.go(
                                                    '/register?role=$type',
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                  minimumSize: Size.zero,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                      ),
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                ),
                                                child: Text(
                                                  type,
                                                  style: TextStyle(
                                                    color: Colors.orange[800],
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              if (type == 'applicant')
                                                Text(
                                                  ' or ',
                                                  style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 12,
                                                  ),
                                                ),
                                            ],
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
                                        fontSize: 12,
                                      ),
                                    ),
                                    for (final type in ['applicant', 'agent'])
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              context.go(
                                                '/register?role=$type',
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                  ),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: Text(
                                              type,
                                              style: TextStyle(
                                                color: Colors.orange[800],
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          if (type == 'applicant')
                                            Text(
                                              ' or ',
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 12,
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
                const SizedBox(height: 30),
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
