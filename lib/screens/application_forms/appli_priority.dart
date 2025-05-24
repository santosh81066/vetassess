import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../../widgets/application_nav.dart';
import 'appli_documents_uploaded.dart';

class ApplicationPriorityProcessing extends StatefulWidget {
  const ApplicationPriorityProcessing({super.key});

  @override
  State<ApplicationPriorityProcessing> createState() =>
      _ApplicationPriorityProcessingState();
}

class _ApplicationPriorityProcessingState
    extends State<ApplicationPriorityProcessing> {
  String _selectedOption = 'Priority Processing';
  List<bool> _checkboxValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 900;
    final isLargeScreen = screenWidth >= 900;

    // Responsive values
    final mainContainerWidth =
        isSmallScreen ? 1.0 : (isMediumScreen ? 0.7 : 0.5);
    final sideMargin = isSmallScreen ? 16.0 : (isMediumScreen ? 24.0 : 125.0);
    final titleFontSize = isSmallScreen ? 24.0 : 32.0;
    final contentFontSize = isSmallScreen ? 14.0 : 16.0;
    final buttonWidth = isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.35;
    final leftContainerWidth =
        isSmallScreen ? 0.0 : (isMediumScreen ? 0.2 : 0.3);
    final buttonDirection = isSmallScreen ? Axis.vertical : Axis.horizontal;
    final buttonSpacing = isSmallScreen ? 10.0 : 15.0;

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
              alignment: Alignment.topRight,
              child: ApplicationNav(),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 16,
                left: isSmallScreen ? 16 : sideMargin,
                bottom: isSmallScreen ? 16 : 100,
                right: isSmallScreen ? 16 : sideMargin,
              ),
              padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Priority Processing',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4A4A4A),
                      fontFamily: 'serif',
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 16.0 : 24.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VETASSESS offer a Priority Processing service for General and Professional occupations.',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          Text(
                            'This service gives you an opportunity to fast-track the assessment of your application.',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: contentFontSize,
                                color: const Color(0xFF4A4A4A),
                              ),
                              children: const [
                                TextSpan(
                                  text:
                                      'Your Priority Processing request will be considered after you submit your application, because we only accept applications that we can assess within 10 business days.',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          Wrap(
                            children: [
                              Text(
                                'There is an additional cost for this service. Please see further details on ',
                                style: TextStyle(
                                  fontSize: contentFontSize,
                                  color: const Color(0xFF4A4A4A),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'Priority Processing',
                                  style: TextStyle(
                                    fontSize: contentFontSize,
                                    color: const Color(0xFFB85C38),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'before proceeding further.',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          Text(
                            'How would you like to proceed with your application?',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          RadioListTile<String>(
                            title: Text(
                              'Standard Application',
                              style: TextStyle(
                                fontSize: contentFontSize,
                                color: const Color(0xFF4A4A4A),
                              ),
                            ),
                            value: 'Standard Application',
                            groupValue: _selectedOption,
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Priority Processing',
                              style: TextStyle(
                                fontSize: contentFontSize,
                                color: const Color(0xFF4A4A4A),
                              ),
                            ),
                            value: 'Priority Processing',
                            groupValue: _selectedOption,
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value!;
                              });
                            },
                          ),
                          if (_selectedOption == 'Priority Processing')
                            Padding(
                              padding: EdgeInsets.only(
                                left: isSmallScreen ? 16.0 : 32.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CheckboxListTile(
                                    title: Text(
                                      'I would like to expedite my application outcome',
                                      style: TextStyle(
                                        fontSize: contentFontSize,
                                        color: const Color(0xFF4A4A4A),
                                      ),
                                    ),
                                    value: _checkboxValues[0],
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkboxValues[0] = value!;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      'I am turning 33, 40, or 45 soon',
                                      style: TextStyle(
                                        fontSize: contentFontSize,
                                        color: const Color(0xFF4A4A4A),
                                      ),
                                    ),
                                    value: _checkboxValues[1],
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkboxValues[1] = value!;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      'My current visa is expiring soon',
                                      style: TextStyle(
                                        fontSize: contentFontSize,
                                        color: const Color(0xFF4A4A4A),
                                      ),
                                    ),
                                    value: _checkboxValues[2],
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkboxValues[2] = value!;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      'My or my partner\'s skills assessment or IELTS test results are expiring soon',
                                      style: TextStyle(
                                        fontSize: contentFontSize,
                                        color: const Color(0xFF4A4A4A),
                                      ),
                                    ),
                                    value: _checkboxValues[3],
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkboxValues[3] = value!;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      'Other',
                                      style: TextStyle(
                                        fontSize: contentFontSize,
                                        color: const Color(0xFF4A4A4A),
                                      ),
                                    ),
                                    value: _checkboxValues[4],
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    dense: true,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checkboxValues[4] = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          Text(
                            'Important Note:',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12.0 : 16.0),
                          Text(
                            'Please be aware that the submission of a request for Priority Processing does not guarantee that your application will be deemed eligible for priority processing. If you apply for Priority Processing, our assessors will verify whether your application meets the eligibility criteria for Priority Processing, which typically takes up to 2 business days.',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 16.0 : 24.0),
                          const Divider(),
                          SizedBox(height: isSmallScreen ? 16.0 : 24.0),
                          // Bottom buttons
                          Center(
                            child: SizedBox(
                              width: buttonWidth,
                              child: Flex(
                                direction: buttonDirection,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 12 : 20,
                                        vertical: isSmallScreen ? 8 : 10,
                                      ),
                                    ),
                                    child: const Text('Back'),
                                  ),
                                  SizedBox(
                                    width: isSmallScreen ? 0 : buttonSpacing,
                                    height: isSmallScreen ? buttonSpacing : 0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 12 : 20,
                                        vertical: isSmallScreen ? 8 : 10,
                                      ),
                                    ),
                                    child: const Text('Save & Exit'),
                                  ),
                                  SizedBox(
                                    width: isSmallScreen ? 0 : buttonSpacing,
                                    height: isSmallScreen ? buttonSpacing : 0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.go('/doc_upload');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 12 : 20,
                                        vertical: isSmallScreen ? 8 : 10,
                                      ),
                                    ),
                                    child: const Text('Continue'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
