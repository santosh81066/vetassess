// ui/application_priority_processing.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../../models/priority_subtype_model.dart';
import '../../providers/priority_subtype_provider.dart';
import '../../widgets/application_nav.dart';
import '../../models/priority_process_model.dart';
import '../../providers/priority_process_provider.dart';

class ApplicationPriorityProcessing extends ConsumerStatefulWidget {
  const ApplicationPriorityProcessing({super.key});

  @override
  ConsumerState<ApplicationPriorityProcessing> createState() =>
      _ApplicationPriorityProcessingState();
}

class _ApplicationPriorityProcessingState
    extends ConsumerState<ApplicationPriorityProcessing> {
  final TextEditingController _otherController = TextEditingController();

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  // Method to handle form submission
  Future<void> _handleSubmit() async {
    final selectedOption = ref.read(selectedProcessingOptionProvider);
    final selectedSubtypes = ref.read(selectedSubtypesProvider);
    final otherText = ref.read(otherTextProvider);

    PriorityProcessRequest request;

    if (selectedOption == 'Standard Application') {
      request = PriorityProcessRequest(
        standardApplication: 'Standard Application',
      );
    } else if (selectedOption == 'Priority Processing') {
      // Get selected subtype IDs
      List<int> selectedIds =
          selectedSubtypes.entries
              .where((entry) => entry.value == true)
              .map((entry) => entry.key)
              .toList();

      if (selectedIds.isEmpty) {
        _showSnackBar('Please select at least one priority processing option.');
        return;
      }

      request = PriorityProcessRequest(
        prioritySubtypeId: selectedIds,
        otherDescription: otherText.isNotEmpty ? otherText : null,
      );
    } else {
      _showSnackBar('Please select a processing option.');
      return;
    }

    // Submit the request
    await ref
        .read(priorityProcessNotifierProvider.notifier)
        .submitPriorityProcess(request);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback? onPressed, bool isSmall) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 12 : 20,
          vertical: isSmall ? 8 : 10,
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildCheckbox(PrioritySubtype subtype, double fontSize) {
    final selectedSubtypes = ref.watch(selectedSubtypesProvider);
    final isSelected = selectedSubtypes[subtype.id] ?? false;
    final isOther = subtype.prioritySubtype.toLowerCase() == 'other';

    return CheckboxListTile(
      title: Text(
        subtype.prioritySubtype,
        style: TextStyle(fontSize: fontSize, color: const Color(0xFF4A4A4A)),
      ),
      value: isSelected,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      onChanged: (value) {
        ref.read(selectedSubtypesProvider.notifier).update((state) {
          final newState = Map<int, bool>.from(state);
          newState[subtype.id] = value!;
          return newState;
        });

        if (isOther && !value!) {
          _otherController.clear();
          ref.read(otherTextProvider.notifier).state = '';
        }
      },
    );
  }

  Widget _buildPrioritySubtypes(
    List<PrioritySubtype> subtypes,
    double contentFontSize,
    bool isSmall,
  ) {
    final selectedSubtypes = ref.watch(selectedSubtypesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...subtypes.map((subtype) => _buildCheckbox(subtype, contentFontSize)),
        // Show text field for "Other" option
        if (subtypes.any(
          (s) =>
              s.prioritySubtype.toLowerCase() == 'other' &&
              (selectedSubtypes[s.id] ?? false),
        ))
          Padding(
            padding: EdgeInsets.only(left: isSmall ? 20.0 : 32.0, top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Please specify:',
                  style: TextStyle(
                    fontSize: contentFontSize,
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    height: 35.0,
                    child: TextField(
                      controller: _otherController,
                      onChanged: (value) {
                        ref.read(otherTextProvider.notifier).state = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8.0,
                        ),
                        isDense: true,
                      ),
                      style: TextStyle(
                        fontSize: contentFontSize,
                        color: const Color(0xFF4A4A4A),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 600;
    final isMedium = screenWidth >= 600 && screenWidth < 900;

    final sideMargin = isSmall ? 16.0 : (isMedium ? 24.0 : 125.0);
    final titleFontSize = isSmall ? 24.0 : 32.0;
    final contentFontSize = isSmall ? 14.0 : 16.0;
    final buttonWidth = isSmall ? screenWidth * 0.8 : screenWidth * 0.35;
    final buttonDirection = isSmall ? Axis.vertical : Axis.horizontal;
    final buttonSpacing = isSmall ? 10.0 : 15.0;

    final selectedOption = ref.watch(selectedProcessingOptionProvider);
    final prioritySubtypesAsync = ref.watch(prioritySubtypesProvider);
    final priorityProcessState = ref.watch(priorityProcessNotifierProvider);

    // Listen to submission state changes
    ref.listen<PriorityProcessState>(priorityProcessNotifierProvider, (
      previous,
      next,
    ) {
      if (next.status == SubmissionStatus.success) {
        _showSnackBar(next.response?.message ?? 'Submitted successfully!');
        // Navigate to next page
        context.go('/doc_upload');
      } else if (next.status == SubmissionStatus.error) {
        _showSnackBar(next.error ?? 'An error occurred', isError: true);
      }
    });

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
                left: isSmall ? 16 : sideMargin,
                bottom: isSmall ? 16 : 100,
                right: isSmall ? 16 : sideMargin,
              ),
              padding: EdgeInsets.all(isSmall ? 8.0 : 16.0),
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
                  SizedBox(height: isSmall ? 16.0 : 24.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isSmall ? 12.0 : 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...[
                            'VETASSESS offer a Priority Processing service for General and Professional occupations.',
                            'This service gives you an opportunity to fast-track the assessment of your application.',
                            'Your Priority Processing request will be considered after you submit your application, because we only accept applications that we can assess within 10 business days.',
                          ].map(
                            (text) => Padding(
                              padding: EdgeInsets.only(
                                bottom: isSmall ? 12.0 : 16.0,
                              ),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: contentFontSize,
                                  color: const Color(0xFF4A4A4A),
                                ),
                              ),
                            ),
                          ),
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
                          SizedBox(height: isSmall ? 12.0 : 16.0),
                          Text(
                            'How would you like to proceed with your application?',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmall ? 12.0 : 16.0),
                          ...[
                            'Standard Application',
                            'Priority Processing',
                          ].map(
                            (option) => RadioListTile<String>(
                              title: Text(
                                option,
                                style: TextStyle(
                                  fontSize: contentFontSize,
                                  color: const Color(0xFF4A4A4A),
                                ),
                              ),
                              value: option,
                              groupValue: selectedOption,
                              contentPadding: EdgeInsets.zero,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                ref
                                    .read(
                                      selectedProcessingOptionProvider.notifier,
                                    )
                                    .state = value!;
                              },
                            ),
                          ),
                          if (selectedOption == 'Priority Processing')
                            Padding(
                              padding: EdgeInsets.only(
                                left: isSmall ? 16.0 : 32.0,
                              ),
                              child: prioritySubtypesAsync.when(
                                data:
                                    (subtypes) => _buildPrioritySubtypes(
                                      subtypes,
                                      contentFontSize,
                                      isSmall,
                                    ),
                                loading:
                                    () => Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: CircularProgressIndicator(
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                error:
                                    (error, stack) => Column(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Failed to load priority subtypes',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: contentFontSize,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        TextButton(
                                          onPressed: () {
                                            ref.refresh(
                                              prioritySubtypesProvider,
                                            );
                                          },
                                          child: Text('Retry'),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          SizedBox(height: isSmall ? 12.0 : 16.0),
                          Text(
                            'Important Note:',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmall ? 12.0 : 16.0),
                          Text(
                            'Please be aware that the submission of a request for Priority Processing does not guarantee that your application will be deemed eligible for priority processing. If you apply for Priority Processing, our assessors will verify whether your application meets the eligibility criteria for Priority Processing, which typically takes up to 2 business days.',
                            style: TextStyle(
                              fontSize: contentFontSize,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                          SizedBox(height: isSmall ? 16.0 : 24.0),
                          const Divider(),
                          SizedBox(height: isSmall ? 16.0 : 24.0),
                          Center(
                            child: SizedBox(
                              width: buttonWidth,
                              child: Flex(
                                direction: buttonDirection,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildButton('Back', () {}, isSmall),
                                  SizedBox(
                                    width: isSmall ? 0 : buttonSpacing,
                                    height: isSmall ? buttonSpacing : 0,
                                  ),
                                  _buildButton('Save & Exit', () {}, isSmall),
                                  SizedBox(
                                    width: isSmall ? 0 : buttonSpacing,
                                    height: isSmall ? buttonSpacing : 0,
                                  ),
                                  _buildButton(
                                    priorityProcessState.status ==
                                            SubmissionStatus.loading
                                        ? 'Submitting...'
                                        : 'Continue',
                                    priorityProcessState.status ==
                                            SubmissionStatus.loading
                                        ? null
                                        : _handleSubmit,
                                    isSmall,
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
