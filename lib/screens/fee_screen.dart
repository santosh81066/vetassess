import 'package:flutter/material.dart';
import 'package:vetassess/theme.dart';
import '../widgets/BasePageLayout.dart';

class FeeScreen extends StatelessWidget {
  const FeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    
    return BasePageLayout(
      child: Container(
        color: AppColors.color12,
        child: SingleChildScrollView(
          child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 35.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // Full Skills Assessment Fees Section
                SizedBox(height: 90,),
                Text(
                  'Full Skills Assessment Fees',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0d5257), // Dark teal color
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 20),
        
                // Exact Table Representation
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('For both qualifications and employment - Australian or Overseas'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)'),
                      ],
                    ),
                    // Online Application Row
                    _buildTableDataRow(
                      label: 'Online application',
                      australiaPrice: 'AUD \$1177.00',
                      overseasPrice: 'AUD \$1070.00',
                    ),
                    // Priority Processing Fee Row
                    _buildTableDataRow(
                      label: '**Priority Processing Fee',
                      australiaPrice: 'AUD \$886.60',
                      overseasPrice: 'AUD \$806.00',
                      isLastRow: true,
                    ),
                  ],
                ),
        
                // Footnotes
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '**This fee is in addition to the Full Skills Assessment fee.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        
                // Space between sections
                const SizedBox(height: 90),
        
                // Points Test Advice Section
                Text(
                  'Points Test Advice only (for applicants with non VETASSESS Occupations)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                        
                      ),
                ),
                const SizedBox(height: 10),
        
                // Click here link
                GestureDetector(
                  onTap: () {
                    // Add navigation or link functionality
                  },
                  child: RichText(
                   text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                       
                        TextSpan(
                          text: 'Click Here',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: const Color(0xFF0d5257),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' to apply or find out more about this application process',
                           
                        ),
                      ],
                    ),
                  ),
                ),
        
                const SizedBox(height: 10),
        
                // Points Test Advice Table
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Qualifications Online application'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)*'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)*'),
                      ],
                    ),
                    // Qualifications Online Application Row
                    _buildTableDataRow(
                      label: 'Qualifications online application',
                      australiaPrice: 'AUD \$334.40',
                      overseasPrice: 'AUD \$304.00',
                      isLastRow: true,
                    ),
                  ],
                ),
        
                // Footnote for Points Test Advice
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
        
                  const SizedBox(height: 90),
                  
                  Text(
                  'Post-Vocational Education Work Visa (Subclass 485) visas',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0d5257), // Dark teal color
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 20),
        
                // Visa Fees Table
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Application Type'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)*'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)*'),
                      ],
                    ),
                    // Post-Vocational Education Work Visa Row
                    _buildTableDataRow(
                      label: 'Post-Vocational Education Work Visa (Subclass 485) visas',
                      australiaPrice: 'AUD \$446.60',
                      overseasPrice: 'AUD \$406.00',
                    ),
                    // Review Visa Row
                    _buildTableDataRow(
                      label: 'Review – Post-Vocational Education Work Visa (Subclass 485) visas',
                      australiaPrice: 'AUD \$284.90',
                      overseasPrice: 'AUD \$259.00',
                    ),
                    // Change of Occupation Row
                    _buildTableDataRow(
                      label: 'Change of Occupation – Post-Vocational Education Work Visa (Subclass 485) visas',
                      australiaPrice: 'AUD \$407.00',
                      overseasPrice: 'AUD \$370.00',
                      isLastRow: true,
                    ),
                  ],
                ),
        
                // Footnote
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
        
                 const SizedBox(height: 90),
                 Text(
                   'Post - 485 assessment under the same occupation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 10),
        
                // Points Test Advice Table
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Application Method'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)*'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)*'),
                      ],
                    ),
                    // Qualifications Online Application Row
                    _buildTableDataRow(
                      label: 'Assessment of employment for final Skills Assessment',
                      australiaPrice: 'AUD \$915.20',
                      overseasPrice: 'AUD \$832.00',
                      isLastRow: true,
                    ),
                  ],
                ),
        
                // Footnote for Points Test Advice
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                         color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
                 const SizedBox(height: 40),
                Text(
                  'Post - 485 assessment under a different occupation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                        fontSize: 20 
                        )
                  
                ),
                 const SizedBox(height: 8),
                Text(
                   'If you are applying for a Post 485 assessment and wish to change your nominated occupation, you will need to lodge a new application online.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                
                // Space between sections
                const SizedBox(height: 90),
        
                 Text(
                  'Review of assessment outcome',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0d5257), // Dark teal color
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 20),
        
                // Assessment Outcome Review Table
                _buildReviewTable(context, isSmallScreen),
        
        
                  const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
                 const SizedBox(height: 8),
                Text(
                  '**You should hold sufficient years of highly relevant employment within last five years to compensate for the lack of a highly relevant major field of study.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                 const SizedBox(height: 8),
                Text(
                   'Review applications lodged outside of the 90-day timeframe will incur full skills assessment fees..',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                
                // Space between sections
                const SizedBox(height: 90),
        
                 Text(
                   'Reassessment - Change of Occupation (within 90-day timeframe)',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 10),
        
                // Points Test Advice Table
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Application type'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)'),
                      ],
                    ),
                    // Qualifications Online Application Row
                    _buildTableDataRow(
                      label: 'Full skills assessment for change of occupation',
                      australiaPrice: 'AUD \$800.80',
                      overseasPrice: 'AUD \$728.00',
                      isLastRow: true,
                    ),
                  ],
                ),
                  const SizedBox(height: 8),
                Text(
                  'Applicants may lodge a new skills assessment application outside the 90-day timeframe.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Footnote for Points Test Advice
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                         color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
               
        
               const SizedBox(height: 90),
        
                Text(
                   'Reissue of Outcome Letter',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                       color: const Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 10),
        
                // Points Test Advice Table
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257),// Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Purpose'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)*'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)*'),
                      ],
                    ),
                    // Qualifications Online Application Row
                    _buildTableDataRow(
                      label: 'Reissue Outcome Letter',
                      australiaPrice: 'AUD \$80.30',
                      overseasPrice: 'AUD \$73.00',
                      isLastRow: true,
                    ),
                  ],
                ),
        
                // Footnote for Points Test Advice
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
               
        
                  const SizedBox(height: 90),
        
                Text(
                   'Appeal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 10),
        
                // Points Test Advice Table
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Application method - Appeal'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)*'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)*'),
                      ],
                    ),
                    // Qualifications Online Application Row
                    _buildTableDataRow(
                      label: 'Appeal of Negative Assessment Outcome',
                      australiaPrice: 'AUD \$1162.70',
                      overseasPrice: 'AUD \$1057.00',
                      isLastRow: true,
                    ),
                  ],
                ),
        
                // Footnote for Points Test Advice
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 90),
                
                Text(
                  'Renewal of Skills Assessment Application Fee',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0d5257), // Dark teal color
                        fontSize: 30
                      ),
                ),
                const SizedBox(height: 20),
        
                // Exact Table Representation
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    // Header Row
                    TableRow(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0d5257), // Dark teal header
                      ),
                      children: [
                        _buildTableHeaderCell('Renewal of Skills Assessment'),
                        _buildTableHeaderCell('Applying from within Australia (includes GST)*'),
                        _buildTableHeaderCell('Applicant is not a resident of Australia for tax purposes (excludes GST)*'),
                      ],
                    ),
                    // Online Application Row
                    _buildTableDataRow(
                      label: 'Within 3 years',
                      australiaPrice: 'AUD \$508.20',
                      overseasPrice: 'AUD \$462.00',
                    ),
                    // Priority Processing Fee Row
                    _buildTableDataRow(
                      label: 'Outside of 3 years',
                      australiaPrice: 'AUD \$1177.00',
                      overseasPrice: 'AUD \$1070.00',
                      isLastRow: true,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Renewal applications lodged outside of the 3-year timeframe will incur a full skills assessment fee, please lodge a new application',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        
                // Footnotes
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: '*Refer to the ',
                      ),
                      TextSpan(
                        text: 'Australian Taxation Office',
                        style: TextStyle(
                          color: const Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        // You could add onTap functionality here to launch URL
                      ),
                      const TextSpan(
                        text: ' website for more information.',
                      ),
                    ],
                  ),
                ),              
        
                // Space between sections
                const SizedBox(height: 90),
        
                
        
        
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create table header cells
  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper method to create table data rows
  TableRow _buildTableDataRow({
    required String label,
    required String australiaPrice,
    required String overseasPrice,
    bool isLastRow = false,
  }) {
    return TableRow(
      decoration: isLastRow 
        ? null 
        : BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            australiaPrice,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            overseasPrice,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

   Widget _buildReviewTable(BuildContext context, bool isSmallScreen) {
    return isSmallScreen 
        ? _buildMobileReviewTable(context) 
        : _buildDesktopReviewTable(context);
  }

  // Desktop version of the review table
  Widget _buildDesktopReviewTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1), // Occupation Group
          1: FlexColumnWidth(1.2), // Review application type
          2: FlexColumnWidth(1.5), // Qualification outcome
          3: FlexColumnWidth(1.5), // Employment outcome
          4: FlexColumnWidth(1), // Additional Supporting Evidence
          5: FlexColumnWidth(0.8), // Fees (including GST)
          6: FlexColumnWidth(0.8), // Fees (excluding GST)
        },
        border: TableBorder.all(color: Colors.grey.shade300),
        children: [
          // Header Row
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xFF005F73), // Dark teal header
            ),
            children: [
              _buildTableHeaderCell('Occupation Group'),
              _buildTableHeaderCell('Review application type'),
              _buildTableHeaderCell('Qualification outcome for initial application'),
              _buildTableHeaderCell('Employment outcome for initial application'),
              _buildTableHeaderCell('Additional Supporting Evidence required'),
              _buildTableHeaderCell('Fees (including GST)*'),
              _buildTableHeaderCell('Fees (excluding GST)*'),
            ],
          ),
          
          // Group A and E - Qualification only
          TableRow(
            children: [
              _buildMultiRowCell('Group\nA and E', 3, TextAlign.center),
              _buildTableDataCell('Qualification only'),
              _buildTableDataCell('Negative\n(not highly relevant or\nnot at the required level)'),
              _buildTableDataCell('Negative due to qualification'),
              _buildTableDataCell('Qualification'),
              _buildTableDataCell('AUD \$365.20', TextAlign.center),
              _buildTableDataCell('AUD \$332.00', TextAlign.center),
            ],
          ),
          
          // Group A and E - Employment only
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Employment only'),
              _buildTableDataCell('Positive'),
              _buildTableDataCell('Negative due to any reason\n(except qualification)'),
              _buildTableDataCell('Employment'),
              _buildTableDataCell('AUD \$654.50', TextAlign.center),
              _buildTableDataCell('AUD \$595.00', TextAlign.center),
            ],
          ),
          
          // Group A and E - Both
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Both\nQualification and Employment'),
              _buildTableDataCell('Negative\n(not highly relevant or\nnot at the required level)'),
              _buildTableDataCell('Negative due to any reason\n(including qualification)'),
              _buildTableDataCell('Qualification and Employment'),
              _buildTableDataCell('AUD \$981.20', TextAlign.center),
              _buildTableDataCell('AUD \$892.00', TextAlign.center),
            ],
          ),
          
          // Group B, C, D and F - First Employment only row
            TableRow(
            children: [
              _buildMultiRowCell('Group\nB, C, D and F', 3, TextAlign.center),
              _buildTableDataCell('Qualification only'),
              _buildTableDataCell('Negative\n(not highly relevant or\nnot at the required level)'),
              _buildTableDataCell('Negative due to qualification'),
              _buildTableDataCell('Qualification'),
              _buildTableDataCell('AUD \$365.20', TextAlign.center),
              _buildTableDataCell('AUD \$332.00', TextAlign.center),
            ],
          ),

          TableRow(
            children: [
               _buildHiddenCell(),
              _buildTableDataCell('Employment only'),
              _buildTableDataCell('Negative\n(not highly relevant and\nyou are not contesting\nthe relevance)'),
              _buildTableDataCell('Negative due to any reason\n(except qualification not at\nthe required level)**'),
              _buildTableDataCell('Employment'),
              _buildTableDataCell('AUD \$654.50', TextAlign.center),
              _buildTableDataCell('AUD \$595.00', TextAlign.center),
            ],
          ),
          
          // Group B, C, D and F - Second Employment only row
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Employment only'),
              _buildTableDataCell('Positive'),
              _buildTableDataCell('Negative due to any reason\n(except qualification)'),
              _buildTableDataCell('Employment'),
              _buildTableDataCell('AUD \$654.50', TextAlign.center),
              _buildTableDataCell('AUD \$595.00', TextAlign.center),
            ],
          ),
          
          // Group B, C, D and F - Both
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Both\nQualification and Employment'),
              _buildTableDataCell('Negative\n(not highly relevant or\nnot at the required level)'),
              _buildTableDataCell('Negative due to any reason\n(including qualification)'),
              _buildTableDataCell('Qualification and Employment'),
              _buildTableDataCell('AUD \$981.20', TextAlign.center),
              _buildTableDataCell('AUD \$892.00', TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }

  // Mobile version of the review table with better formatting for small screens
  Widget _buildMobileReviewTable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group A and E
        _buildMobileGroupHeader(context, 'Group A and E'),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Qualification only',
          qualOutcome: 'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to qualification',
          evidence: 'Qualification',
          feeIncl: 'AUD \$365.20',
          feeExcl: 'AUD \$332.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Employment only',
          qualOutcome: 'Positive',
          empOutcome: 'Negative due to any reason (except qualification)',
          evidence: 'Employment',
          feeIncl: 'AUD \$654.50',
          feeExcl: 'AUD \$595.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Both',
          qualOutcome: 'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to any reason (including qualification)',
          evidence: 'Qualification and Employment',
          feeIncl: 'AUD \$981.20',
          feeExcl: 'AUD \$892.00',
          isLastInGroup: true,
        ),
        
        // Group B, C, D and F
        _buildMobileGroupHeader(context, 'Group B, C, D and F'),

        _buildMobileReviewRow(
          context: context,
          reviewType: 'Qualification only',
          qualOutcome: 'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to qualification',
          evidence: 'Qualification',
          feeIncl: 'AUD \$365.20',
          feeExcl: 'AUD \$332.00',
        ),

        _buildMobileReviewRow(
          context: context,
          reviewType: 'Employment only',
          qualOutcome: 'Negative (not highly relevant and you are not contesting the relevance)',
          empOutcome: 'Negative due to any reason (except qualification not at the required level)**',
          evidence: 'Employment',
          feeIncl: 'AUD \$654.50',
          feeExcl: 'AUD \$595.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Employment only',
          qualOutcome: 'Positive',
          empOutcome: 'Negative due to any reason (except qualification)',
          evidence: 'Employment',
          feeIncl: 'AUD \$654.50',
          feeExcl: 'AUD \$595.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Both Qualification and Employment',
          qualOutcome: 'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to any reason (including qualification)',
          evidence: 'Qualification and Employment',
          feeIncl: 'AUD \$981.20',
          feeExcl: 'AUD \$892.00',
          isLastInGroup: true,
        ),
      ],
    );
  }

  Widget _buildMobileGroupHeader(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: const Color(0xFFE6F2F5), // Light teal background
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF005F73),
        ),
      ),
    );
  }

  Widget _buildMobileReviewRow({
    required BuildContext context,
    required String reviewType,
    required String qualOutcome,
    required String empOutcome,
    required String evidence,
    required String feeIncl,
    required String feeExcl,
    bool isLastInGroup = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLastInGroup 
              ? BorderSide.none 
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMobileInfoRow('Review type:', reviewType),
          _buildMobileInfoRow('Qualification outcome:', qualOutcome),
          _buildMobileInfoRow('Employment outcome:', empOutcome),
          _buildMobileInfoRow('Required evidence:', evidence),
          Row(
            children: [
              Expanded(
                child: _buildMobileInfoRow('Incl. GST:', feeIncl),
              ),
              Expanded(
                child: _buildMobileInfoRow('Excl. GST:', feeExcl),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  // Helper method for multi-row cells (rowspan)
  Widget _buildMultiRowCell(String text, int rowSpan, TextAlign align) {
    return Container(
      height: 60.0 * rowSpan, // Approximate height
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: align,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // Helper method for hidden cells (used with rowspan)
  Widget _buildHiddenCell() {
    return const SizedBox.shrink();
  }

  // Helper method for regular table cells
  Widget _buildTableDataCell(String text, [TextAlign align = TextAlign.start]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
        textAlign: align,
      ),
    );
  }


}