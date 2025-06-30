import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  static const Color tealColor = Color(0xFF00565B);
  static const Color primaryColor = Color(0xFF2D7A7B);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color orangeColor = Color(0xFFFFA000);
  static const Color greyColor = Color(0xFF666666);
  static const Color blackColor = Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildMainContent()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Terms & Conditions',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: blackColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 30),

        // Last updated
        Text(
          'Last updated on 30-06-2025 14:12:52',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: blackColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 30),

        // First paragraph
        Text(
          'These Terms and Conditions, along with privacy policy or other terms ("Terms") constitute a binding agreement by and between MRHOSTEL PRIVATE LIMITED, ( "Website Owner" or "we" or "us" or "our") and you ("you" or "your" or "User") and relate to your use of our website, goods (as applicable) or services (as applicable) (collectively, "Services").',
          style: TextStyle(fontSize: 16, color: blackColor, height: 1.6),
        ),
        const SizedBox(height: 20),

        // Second paragraph
        Text(
          'By using our website and availing the Services, you agree that you have read and accepted these Terms (including the Privacy Policy). We reserve the right to modify these Terms at any time and without assigning any reason. It is your responsibility to periodically review these Terms to stay informed of updates.',
          style: TextStyle(fontSize: 16, color: blackColor, height: 1.6),
        ),
        const SizedBox(height: 20),

        // Third paragraph
        Text(
          'The use of this website or availing of our Services is subject to the following terms of use:',
          style: TextStyle(fontSize: 16, color: blackColor, height: 1.6),
        ),
        const SizedBox(height: 30),

        // Bullet points
        _buildBulletPoint(
          'To access and use the Services, you agree to provide true, accurate and complete information to us during and after registration, and you shall be responsible for all acts done through the use of your registered account.',
        ),
        _buildBulletPoint(
          'Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness or suitability of the information and materials offered on this website or through the Services, for any specific purpose. You acknowledge that such information and materials may contain inaccuracies or errors and we expressly exclude liability for any such inaccuracies or errors to the fullest extent permitted by law.',
        ),
        _buildBulletPoint(
          'Your use of our Services and the websiteis solely at your own risk and discretion.. You are required to independently assess and ensure that the Services meet your requirements.',
        ),
        _buildBulletPoint(
          'The contents of the Website and the Services are proprietary to Us and you will not have any authority to claim any intellectual property rights, title, or interest in its contents.',
        ),
        _buildBulletPoint(
          'You acknowledge that unauthorized use of the Website or the Services may lead to action against you as per these Terms or applicable laws.',
        ),
        _buildBulletPoint(
          'You agree to pay us the charges associated with availing the Services.',
        ),
        _buildBulletPoint(
          'You agree not to use the website and/ or Services for any purpose that is unlawful, illegal or forbidden by these Terms, or Indian or local laws that might apply to you.',
        ),
        _buildBulletPoint(
          'You agree and acknowledge that website and the Services may contain links to other third party websites. On accessing these links, you will be governed by the terms of use, privacy policy and such other policies of such third party websites.',
        ),
        _buildBulletPoint(
          'You understand that upon initiating a transaction for availing the Services you are entering into a legally binding and enforceable contract with the us for the Services.',
        ),
        _buildBulletPoint(
          'You shall be entitled to claim a refund of the payment made by you in case we are not able to provide the Service. The timelines for such return and refund will be according to the specific Service you have availed or within the time period provided in our policies (as applicable). In case you do not raise a refund claim within the stipulated time, than this would make you ineligible for a refund.',
        ),
        _buildBulletPoint(
          'Notwithstanding anything contained in these Terms, the parties shall not be liable for any failure to perform an obligation under these Terms if performance is prevented or delayed by a force majeure event.',
        ),
        _buildBulletPoint(
          'These Terms and any dispute or claim relating to it, or its enforceability, shall be governed by and construed in accordance with the laws of India.',
        ),
        _buildBulletPoint(
          'All disputes arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts in Pargi, TELANGANA',
        ),
        _buildBulletPoint(
          'All concerns or communications relating to these Terms must be communicated to us using the contact information provided on this website.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 12),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: blackColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: blackColor, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner(Size size, bool isMobile) {
    return Container(
      width: size.width,
      height: size.height * (isMobile ? 0.35 : 0.45),
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          if (!isMobile)
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/internal_page_banner.png',
                height: size.height * 0.45,
                fit: BoxFit.fitHeight,
              ),
            ),
          Container(
            width: isMobile ? size.width * 0.9 : size.width * 0.66,
            padding: EdgeInsets.only(
              top: _getSpacing(size.height, 100),
              left: _getHorizontalPadding(size.width),
            ),
            child: Align(
              alignment: isMobile ? Alignment.center : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment:
                    isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: orangeColor,
                      fontSize: _getFontSize(size.width, 42),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Please read our terms and conditions carefully before using our services.",
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
            onPressed: () {
              context.go('/');
            },
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
          Text('Terms & Conditions', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Responsive helper methods
  double _getHorizontalPadding(double width) =>
      width < 768
          ? 16.0
          : width < 1024
          ? 32.0
          : 50.0;
  double _getContentPadding(double width) =>
      width < 768
          ? 16.0
          : width < 1024
          ? 32.0
          : 150.0;
  double _getFontSize(double width, double base) =>
      width < 768
          ? base * 0.8
          : width < 1024
          ? base * 0.9
          : base;
  double _getSpacing(double height, double base) =>
      height < 600
          ? base * 0.6
          : height < 800
          ? base * 0.8
          : base;
}
