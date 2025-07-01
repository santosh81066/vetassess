import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  static const Color tealColor = Color(0xFF00565B);
  static const Color primaryColor = Color(0xFF2D7A7B);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color orangeColor = Color(0xFFFFA000);
  static const Color greyColor = Color(0xFF666666);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose how you would like to contact us from\nthe options below.',
                  style: TextStyle(
                    fontSize: _getFontSize(size.width, 36),
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),
                _buildResponsiveContent(isMobile, isTablet, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveContent(
    bool isMobile,
    bool isTablet,
    BuildContext context,
  ) {
    final sections = [
      _buildEnquiriesSection(),
      _buildCurrentApplicationsSection(context),
      _buildBusinessEnquiriesSection(),
    ];

    if (isMobile) {
      return Column(
        children:
            sections
                .expand((section) => [section, const SizedBox(height: 40)])
                .take(5)
                .toList(),
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: sections[0]),
              const SizedBox(width: 30),
              Expanded(child: sections[1]),
            ],
          ),
          const SizedBox(height: 40),
          sections[2],
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            sections
                .expand(
                  (section) => [
                    Expanded(child: section),
                    const SizedBox(width: 60),
                  ],
                )
                .take(5)
                .toList(),
      );
    }
  }

  Widget _buildEnquiriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Enquiries'),
        const SizedBox(height: 20),
        _buildInfoText(
          'Monday to Friday, 9am to 5pm AEDT\nexcept Public Holidays',
        ),
        const SizedBox(height: 24),
        _buildContactRow(Icons.phone, 'VETASSESS', '+91 9392183747'),
        const SizedBox(height: 32),
        _buildSubTitle('International'),
        const SizedBox(height: 16),
        _buildSimpleContactRow(Icons.phone, '+91 9392 183 747'),
        const SizedBox(height: 24),
        _buildInfoText(
          'Webchat available Monday to Friday,\n9am to 4:30pm AEDT except Public\nHolidays',
        ),
        const SizedBox(height: 20),
        _buildSubTitle('Mail'),
        const SizedBox(height: 16),
        _buildSimpleContactRow(Icons.mail_outline, 'mrhostel09@gmail.com'),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCurrentApplicationsSection(BuildContext context) {
    final options = [
      ('Check your status online', () {}),
      ('View current processing times', () {}),
      ('View FAQs page', () {}),
      (
    // Your existing Terms link in ContactUs works perfectly
    'Terms & Conditions',
    () async {
    final Uri termsUrl = Uri.parse('${Uri.base.origin}/#/terms-conditions');
    if (await canLaunchUrl(termsUrl)) {
    await launchUrl(termsUrl, mode: LaunchMode.externalApplication);
    }

          if (await canLaunchUrl(termsUrl)) {
            await launchUrl(
              termsUrl,
              mode: LaunchMode.externalApplication, // Opens in new tab/window
            );
          }
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('For current applications'),
        const SizedBox(height: 40),
        ...options.asMap().entries.map(
          (entry) =>
              _buildOptionRow(entry.value.$1, entry.key < 3, entry.value.$2),
        ),
      ],
    );
  }

  Widget _buildBusinessEnquiriesSection() {
    final addressInfo = [
      (
        'Registered Address',
        "Govindapur,Pargi, Vikarabad, Purgi S.O, Pargi, Telangana, India, 501501, Pargi, TELANGANA, PIN: 501501",
      ),
      (
        'Operational Address',
        "Govindapur,Pargi, Vikarabad, Purgi S.O, Pargi, Telangana, India, 501501, Pargi, TELANGANA, PIN: 501501",
      ),
      ('Merchant Legal entity name', "MRHOSTEL PRIVATE LIMITED"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Business & industry\nenquiries'),
        const SizedBox(height: 20),
        _buildInfoText(
          'If you are a business, government or\neducational customer or have an inquiry.',
        ),
        const SizedBox(height: 10),
        _buildSimpleContactRow(Icons.phone, '+91 9392183747'),
        const SizedBox(height: 28),
        ...addressInfo.expand(
          (info) => [
            _buildSectionTitle(info.$1),
            const SizedBox(height: 15),
            Text(
              info.$2,
              style: TextStyle(
                fontSize: info.$1.contains('entity') ? 18 : 16,
                color: greyColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ],
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
                    "Contact us",
                    style: TextStyle(
                      color: orangeColor,
                      fontSize: _getFontSize(size.width, 42),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "All office opening hours are Monday - Friday, 9:00 a.m to 5:00 p.m, except \nPublic Holidays.",
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
          Text('Contact', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        height: 1.2,
      ),
    );
  }

  Widget _buildSubTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: greyColor, height: 1.4),
    );
  }

  Widget _buildContactRow(IconData icon, String title, String contact) {
    return Row(
      children: [
        _buildIconContainer(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUnderlinedText(title),
              const SizedBox(height: 4),
              _buildUnderlinedText(contact),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleContactRow(IconData icon, String contact) {
    return Row(
      children: [
        _buildIconContainer(icon),
        const SizedBox(width: 12),
        Expanded(child: _buildUnderlinedText(contact)),
      ],
    );
  }

  Widget _buildOptionRow(String text, bool showBorder, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration:
            showBorder
                ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFFFB74D), width: 1),
                  ),
                )
                : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
            _buildArrowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildUnderlinedText(String text) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: accentColor, width: 2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }

  Widget _buildArrowButton() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
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
