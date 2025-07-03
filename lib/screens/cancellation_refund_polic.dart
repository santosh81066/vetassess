import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';
import 'package:go_router/go_router.dart';

class CancellationRefundPolicy extends StatelessWidget {
  const CancellationRefundPolicy({super.key});

  static const Color tealColor = Color(0xFF00565B);
  static const Color primaryColor = Color(0xFF2D7A7B);
  static const Color accentColor = Color(0xFF00BCD4);
  static const Color orangeColor = Color(0xFFFFA000);
  static const Color greyColor = Color(0xFF666666);

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
              children: [
                _buildPolicyHeader(size.width),
                const SizedBox(height: 40),
                _buildPolicyContent(isMobile),
              ],
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
                    "Cancellation & Refund Policy",
                    style: TextStyle(
                      color: orangeColor,
                      fontSize: _getFontSize(size.width, 42),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Please read our cancellation and refund policy carefully to understand your rights and obligations.",
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
          Text('Cancellation & Refund Policy', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildPolicyHeader(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cancellation & Refund Policy',
          style: TextStyle(
            fontSize: _getFontSize(screenWidth, 36),
            fontWeight: FontWeight.w600,
            color: primaryColor,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Last updated on 03-07-2025 17:39:37',
          style: TextStyle(
            fontSize: 14,
            color: greyColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIntroSection(),
        const SizedBox(height: 30),
        _buildPolicyPoints(),
        const SizedBox(height: 30),
        _buildContactSection(),
      ],
    );
  }

  Widget _buildIntroSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Text(
        'MRHOSTEL PRIVATE LIMITED believes in helping its customers as far as possible, and has therefore a liberal cancellation policy. Under this policy:',
        style: TextStyle(
          fontSize: 16,
          color: greyColor,
          height: 1.6,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPolicyPoints() {
    final policies = [
      {
        'title': 'Immediate Cancellation',
        'content': 'Cancellations will be considered only if the request is made immediately after placing the order. However, the cancellation request may not be entertained if the orders have been communicated to the vendors/merchants and they have initiated the process of shipping them.',
      },
      {
        'title': 'Perishable Items',
        'content': 'MRHOSTEL PRIVATE LIMITED does not accept cancellation requests for perishable items like flowers, eatables etc. However, refund/replacement can be made if the customer establishes that the quality of product delivered is not good.',
      },
      {
        'title': 'Damaged or Defective Items',
        'content': 'In case of receipt of damaged or defective items please report the same to our Customer Service team. The request will, however, be entertained once the merchant has checked and determined the same at his own end. This should be reported within 7 Days of receipt of the products. In case you feel that the product received is not as shown on the site or as per your expectations, you must bring it to the notice of our customer service within 7 Days of receiving the product. The Customer Service Team after looking into your complaint will take an appropriate decision.',
      },
      {
        'title': 'Warranty Products',
        'content': 'In case of complaints regarding products that come with a warranty from manufacturers, please refer the issue to them.',
      },
      {
        'title': 'Refund Processing',
        'content': 'In case of any Refunds approved by the MRHOSTEL PRIVATE LIMITED, it\'ll take 16-30 Days for the refund to be processed to the end customer.',
      },
    ];

    return Column(
      children: policies.asMap().entries.map((entry) {
        final index = entry.key;
        final policy = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryColor.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          policy['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          policy['content']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: greyColor,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Need Help?',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'If you have any questions about our cancellation and refund policy, please contact our customer service team.',
            style: TextStyle(
              fontSize: 14,
              color: greyColor,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildContactItem(Icons.phone, '+91 9392183747'),
              const SizedBox(width: 20),
              _buildContactItem(Icons.email, 'mrhostel09@gmail.com'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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