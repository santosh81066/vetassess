import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(15, (index) => GlobalKey());

  static const Color tealColor = Color(0xFF00565B);
  static const Color primaryColor = Color(0xFF2D7A7B);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color orangeColor = Color(0xFFFFA000);
  static const Color greyColor = Color(0xFF666666);

  final List<String> _sectionTitles = [
    'Introduction',
    'Registration Requirements',
    'Warranty Disclaimer',
    'Risk and Discretion',
    'Intellectual Property',
    'Unauthorized Use',
    'Payment Terms',
    'Lawful Use',
    'Third Party Links',
    'Legal Contract',
    'Refund Policy',
    'Force Majeure',
    'Governing Law',
    'Jurisdiction',
    'Contact Information',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1024;

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(size, isMobile),
          _buildBreadcrumb(size.width, context),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: _getContentPadding(size.width),
            ),
            color: Colors.white,
            child: isMobile
                ? _buildMobileLayout()
                : _buildDesktopLayout(isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPageTitle(),
        const SizedBox(height: 20),
        _buildLastUpdated(),
        const SizedBox(height: 30),
        _buildTableOfContents(true),
        const SizedBox(height: 40),
        _buildTermsContent(),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table of Contents Sidebar
        SizedBox(
          width: isTablet ? 280 : 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageTitle(),
              const SizedBox(height: 10),
              _buildLastUpdated(),
              const SizedBox(height: 30),
              _buildTableOfContents(false),
            ],
          ),
        ),
        SizedBox(width: isTablet ? 30 : 60),
        // Main Content
        Expanded(
          child: _buildTermsContent(),
        ),
      ],
    );
  }

  Widget _buildHeaderBanner(Size size, bool isMobile) {
    return Container(
      width: size.width,
      height: size.height * (isMobile ? 0.25 : 0.35),
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          if (!isMobile)
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/internal_page_banner.png',
                height: size.height * 0.35,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
            ),
          Container(
            width: isMobile ? size.width * 0.9 : size.width * 0.66,
            padding: EdgeInsets.only(
              top: _getSpacing(size.height, 60),
              left: _getHorizontalPadding(size.width),
            ),
            child: Align(
              alignment: isMobile ? Alignment.center : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: orangeColor,
                      fontSize: _getFontSize(size.width, 36),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Please read these terms carefully before using our services.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _getFontSize(size.width, 16),
                      height: 1.5,
                      letterSpacing: 0.3,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb(double screenWidth, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: _getHorizontalPadding(screenWidth),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text(
              'Home',
              style: TextStyle(
                color: Color(0xFF0d5257),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          TextButton(
            onPressed: () => context.go('/contact'),
            child: const Text(
              'Contact',
              style: TextStyle(
                color: Color(0xFF0d5257),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          Text('Terms & Conditions', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildPageTitle() {
    return Text(
      'Terms & Conditions',
      style: TextStyle(
        fontSize: _getFontSize(MediaQuery.of(context).size.width, 32),
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Text(
      'Last updated on 30-06-2025 14:12:52',
      style: TextStyle(
        color: greyColor,
        fontSize: 14,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget _buildTableOfContents(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Table of Contents',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(_sectionTitles.length, (index) {
            return InkWell(
              onTap: () => _scrollToSection(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      child: Text(
                        '${index + 1}.',
                        style: TextStyle(
                          fontSize: 14,
                          color: accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _sectionTitles[index],
                        style: const TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: accentColor,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTermsContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Introduction
          _buildSection(
            0,
            'Introduction',
            'These Terms and Conditions, along with privacy policy or other terms ("Terms") constitute a binding agreement by and between MRHOSTEL PRIVATE LIMITED, ( "Website Owner" or "we" or "us" or "our") and you ("you" or "your") and relate to your use of our website, goods (as applicable) or services (as applicable) (collectively, "Services").\n\nBy using our website and availing the Services, you agree that you have read and accepted these Terms (including the Privacy Policy). We reserve the right to modify these Terms at any time and without assigning any reason. It is your responsibility to periodically review these Terms to stay informed of updates.\n\nThe use of this website or availing of our Services is subject to the following terms of use:',
          ),

          // All other sections
          _buildSection(
            1,
            'Registration Requirements',
            'To access and use the Services, you agree to provide true, accurate and complete information to us during and after registration, and you shall be responsible for all acts done through the use of your registered account.',
          ),

          _buildSection(
            2,
            'Warranty Disclaimer',
            'Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness or suitability of the information and materials offered on this website or through the Services, for any specific purpose. You acknowledge that such information and materials may contain inaccuracies or errors and we expressly exclude liability for any such inaccuracies or errors to the fullest extent permitted by law.',
          ),

          _buildSection(
            3,
            'Risk and Discretion',
            'Your use of our Services and the website is solely at your own risk and discretion. You are required to independently assess and ensure that the Services meet your requirements.',
          ),

          _buildSection(
            4,
            'Intellectual Property',
            'The contents of the Website and the Services are proprietary to Us and you will not have any authority to claim any intellectual property rights, title, or interest in its contents.',
          ),

          _buildSection(
            5,
            'Unauthorized Use',
            'You acknowledge that unauthorized use of the Website or the Services may lead to action against you as per these Terms or applicable laws.',
          ),

          _buildSection(
            6,
            'Payment Terms',
            'You agree to pay us the charges associated with availing the Services.',
          ),

          _buildSection(
            7,
            'Lawful Use',
            'You agree not to use the website and/ or Services for any purpose that is unlawful, illegal or forbidden by these Terms, or Indian or local laws that might apply to you.',
          ),

          _buildSection(
            8,
            'Third Party Links',
            'You agree and acknowledge that website and the Services may contain links to other third party websites. On accessing these links, you will be governed by the terms of use, privacy policy and such other policies of such third party websites.',
          ),

          _buildSection(
            9,
            'Legal Contract',
            'You understand that upon initiating a transaction for availing the Services you are entering into a legally binding and enforceable contract with the us for the Services.',
          ),

          _buildSection(
            10,
            'Refund Policy',
            'You shall be entitled to claim a refund of the payment made by you in case we are not able to provide the Service. The timelines for such return and refund will be according to the specific Service you have availed or within the time period provided in our policies (as applicable). In case you do not raise a refund claim within the stipulated time, than this would make you ineligible for a refund.',
          ),

          _buildSection(
            11,
            'Force Majeure',
            'Notwithstanding anything contained in these Terms, the parties shall not be liable for any failure to perform an obligation under these Terms if performance is prevented or delayed by a force majeure event.',
          ),

          _buildSection(
            12,
            'Governing Law',
            'These Terms and any dispute or claim relating to it, or its enforceability, shall be governed by and construed in accordance with the laws of India.',
          ),

          _buildSection(
            13,
            'Jurisdiction',
            'All disputes arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts in Pargi, TELANGANA',
          ),

          _buildSection(
            14,
            'Contact Information',
            'All concerns or communications relating to these Terms must be communicated to us using the contact information provided on this website.',
          ),

          const SizedBox(height: 40),
          _buildBackToTopButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(int index, String title, String content) {
    return Container(
      key: _sectionKeys[index],
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: greyColor,
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackToTopButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        },
        icon: const Icon(Icons.keyboard_arrow_up),
        label: const Text('Back to Top'),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      );
    }
  }

  // Responsive helper methods
  double _getHorizontalPadding(double width) =>
      width < 768 ? 16.0 : width < 1024 ? 32.0 : 50.0;

  double _getContentPadding(double width) =>
      width < 768 ? 16.0 : width < 1024 ? 32.0 : 80.0;

  double _getFontSize(double width, double base) =>
      width < 768 ? base * 0.8 : width < 1024 ? base * 0.9 : base;

  double _getSpacing(double height, double base) =>
      height < 600 ? base * 0.6 : height < 800 ? base * 0.8 : base;
}