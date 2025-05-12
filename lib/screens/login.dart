import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Header with logo and title
          Container(
            height: MediaQuery.of(context).size.height / 6,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/vetassess_logo.png', height: 60),
                const SizedBox(width: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(
                    'Skills Recognition General Occupations',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.teal[800],
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Teal border line
          Container(height: 2, color: Colors.teal[700]),

          // Navigation bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.orange[900]),
                  onPressed: () {},
                ),
                for (final item in ['Contact us', 'Useful links', 'FAQs'])
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.orange[900]),
                    ),
                  ),
                const SizedBox(width: 175),
              ],
            ),
          ),

          // Main content
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Welcome to the Skills Recognition Service',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 560,
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
                          padding: const EdgeInsets.fromLTRB(
                            100,
                            28.0,
                            100.0,
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

                              // Forgot password link
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
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
                                  const Text(
                                    'Verification image',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
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
                                      height: 36,
                                      width: 250,
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
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00897B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
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
                              Row(
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
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            minimumSize: Size.zero,
                                            padding: const EdgeInsets.symmetric(
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
                                            'or',
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
        ],
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
