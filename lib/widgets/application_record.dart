import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

// For web downloads - add this import
import 'dart:html' as html; 

class ApplicationRecordPdfGenerator {
  static const String jsonData = '''
{
    "users": [
        {
            "userId": 1,
            "givenNames": "agent",
            "surname": "designers",
            "dateOfBirth": "01/01/1990",
            "businessName": null,
            "registrationStatus": null,
            "registrationNumber": null,
            "email": "agentdesigners@gmail.com",
            "password": "\$2b\$10\$36bQnw0ao/AXKYFggMd.c.p2xveDjaLFVSSms0cWAs2QnfQcl54Mi",
            "role": "applicant",
            "isAgreedToReceiveNews": true,
            "PersonalDetails": [
                {
                    "personalDetailsId": 1,
                    "userId": 1,
                    "status": "Submitted",
                    "preferredTitle": "Mr",
                    "surname": "paul",
                    "givenNames": "John",
                    "gender": "Male",
                    "previousSurname": "Doe",
                    "previousGivenNames": "Johnny",
                    "dateOfBirth": "1990-01-01",
                    "countryOfBirth": "Australia",
                    "countryOfCurrentResidency": "Australia",
                    "citizenshipCountry": "Australia",
                    "currentPassportNumber": "X1234567",
                    "datePassportIssued": "2015-06-01",
                    "otherCitizenshipCountry": "New Zealand",
                    "otherPassportNumber": "NZ9876543",
                    "otherDatePassportIssued": "2016-07-15",
                    "emailAddress": "johnsmith@example.com",
                    "daytimeTelephoneNumber": "0123456789",
                    "faxNumber": "021234567",
                    "mobileNumber": "0412345678",
                    "postalStreetAddress": "123 Street",
                    "postalStreetAddressLine2": "Apt 4B",
                    "postalStreetAddressLine3": "Tower 2",
                    "postalStreetAddressLine4": "Campus District",
                    "postalSuburbCity": "Sydney",
                    "postalState": "NSW",
                    "postalPostCode": "2000",
                    "postalCountry": "Australia",
                    "homeStreetAddress": "123 Street",
                    "homeStreetAddressLine2": "Apt 4B",
                    "homeStreetAddressLine3": "Tower 2",
                    "homeStreetAddressLine4": "Campus District",
                    "homeSuburbCity": "Sydney",
                    "homeState": "NSW",
                    "homePostCode": "2000",
                    "homeCountry": "Australia",
                    "isAgentAuthorized": true,
                    "agentSurname": "Brown",
                    "agentGivenNames": "Emily",
                    "agentCompanyName": "Visa Experts",
                    "agentMaraNumber": "MARA12345",
                    "agentEmailAddress": "emily.brown@visaexperts.com",
                    "agentDaytimeTelephoneNumber": "023456789",
                    "agentFaxNumber": "034567890",
                    "agentMobileNumber": "0411000222",
                    "agentStreetAddress": "456 Agency Blvd",
                    "agentStreetAddressLine2": "Floor 3",
                    "agentStreetAddressLine3": "Unit 5",
                    "agentStreetAddressLine4": "North Building",
                    "agentSuburbCity": "Melbourne",
                    "agentState": "VIC",
                    "agentPostCode": "3000",
                    "agentCountry": "Australia",
                    "createdAt": "2025-06-12T06:29:05.000Z",
                    "updatedAt": "2025-06-15T19:31:25.000Z"
                }
            ],
            "EducationQualifications": [
                {
                    "educationId": 1,
                    "userId": 1,
                    "studentRegistrationNumber": "SRN001",
                    "qualificationName": "Bachelor of Engineering",
                    "majorField": "Mechanical Engineering",
                    "awardingBodyName": "University of Sydney",
                    "awardingBodyCountry": "Australia",
                    "campusAttended": "Main Campus",
                    "institutionName": "University of Sydney",
                    "streetAddress1": "123 Campus Rd",
                    "streetAddress2": "Engineering Block",
                    "suburbCity": "Sydney",
                    "state": "NSW",
                    "postCode": "2000",
                    "institutionCountry": "Australia",
                    "normalEntryRequirement": "High School",
                    "entryBasis": "Merit",
                    "courseLengthYearsOrSemesters": "4",
                    "semesterLengthWeeksOrMonths": "20",
                    "courseStartDate": "2016-01-01",
                    "courseEndDate": "2020-12-31",
                    "qualificationAwardedDate": "2021-01-10",
                    "studyMode": "Full-time",
                    "hoursPerWeek": 40,
                    "internshipWeeks": 12,
                    "thesisWeeks": 8,
                    "majorProjectWeeks": 10,
                    "activityDetails": "Final year capstone project and industry internship."
                }
            ],
            "Educations": [
                {
                    "educationId": 1,
                    "userId": 1,
                    "level": 1,
                    "dateStarted": "2005-01-01",
                    "dateFinished": "2010-12-31",
                    "numberOfYears": 6,
                    "country": "Australia",
                    "yearCompleted": "2010",
                    "certificateDetails": "High School Certificate"
                },
                {
                    "educationId": 2,
                    "userId": 1,
                    "level": 2,
                    "dateStarted": "2011-01-01",
                    "dateFinished": "2015-12-31",
                    "numberOfYears": 5,
                    "country": "Australia",
                    "yearCompleted": "2015",
                    "certificateDetails": "Secondary Education Certificate"
                }
            ],
            "Employments": [
                {
                    "id": 1,
                    "userId": 1,
                    "businessName": "Tech Solutions",
                    "alternateBusinsessname": "TS Pty Ltd",
                    "streetaddress": "456 Tech Rd",
                    "suburbCity": "Melbourne",
                    "state": "VIC",
                    "PostCode": "3000",
                    "Country": "Australia",
                    "Nameofemployer": "Jane Doe",
                    "datytimePHno": 987654321,
                    "faxnumber": 12345678,
                    "mobileNo": 498765432,
                    "emailaddress": "jane.doe@techsolutions.com.au",
                    "webaddress": "https://techsolutions.com.au",
                    "positionJobTitle": "DevOps Engineer",
                    "dateofemploymentstarted": "2021-01-01",
                    "isapplicantemployed": false,
                    "dateofemploymentended": "2023-12-31T00:00:00.000Z",
                    "totallengthofUnpaidLeave": 5,
                    "normalrequiredWorkinghours": 38,
                    "task1": "Set up CI/CD pipelines",
                    "task2": "Manage infrastructure",
                    "task3": "Monitor services",
                    "task4": "Automate deployments",
                    "task5": "Support development teams",
                    "createdAt": "2025-06-15T16:13:36.000Z",
                    "updatedAt": "2025-06-15T19:31:25.000Z"
                }
            ],
            "uploadedDocuments": [
                {
                    "id": 1,
                    "docCategoryid": 1,
                    "docTypeid": 2,
                    "userId": 1,
                    "description": "My updated resume",
                    "uploadfile": "resume_june2025_updated.pdf",
                    "category": {
                        "id": 1,
                        "documentCategory": "Identification",
                        "createdAt": "2025-06-12T07:03:52.000Z",
                        "updatedAt": "2025-06-12T07:03:52.000Z"
                    },
                    "type": {
                        "id": 2,
                        "name": "Resume",
                        "docCategory_id": 1
                    }
                }
            ],
            "user_Visas": [
                {
                    "id": 9,
                    "visa_id": 1,
                    "user_id": 1,
                    "createdAt": "2025-06-15T19:31:25.000Z",
                    "updatedAt": "2025-06-15T19:31:25.000Z",
                    "Visa": {
                        "id": 1,
                        "visaName": "POST VOCATIONAL EDUCATION WORK BISA (subclass 485)",
                        "category": "Qualifications Only",
                        "assessmentType": 1,
                        "createdAt": "2025-06-12T06:56:58.000Z",
                        "updatedAt": "2025-06-12T06:56:58.000Z"
                    }
                }
            ],
            "UserOccupations": [
                {
                    "id": 9,
                    "occupation_id": 2,
                    "user_id": 1,
                    "createdAt": "2025-06-15T19:31:25.000Z",
                    "updatedAt": "2025-06-15T19:31:25.000Z",
                    "Occupation": {
                        "id": 2,
                        "occupationName": "Biochemist",
                        "anzscoCode": "234513",
                        "assessmentType": null,
                        "SkillsRequirement": "Degree in biochemistry or molecular biology and experience with laboratory research.",
                        "createdBy": 2,
                        "createdAt": "2025-06-12T06:34:25.000Z",
                        "updatedAt": "2025-06-12T06:34:25.000Z"
                    }
                }
            ],
            "Licences": [
                {
                    "id": 1,
                    "userId": 1,
                    "categoryId": 1,
                    "countryId": 1,
                    "nameofIssuingBody": "Department of Transport",
                    "typeOfLicence": "Driver's Licence",
                    "registrationNumber": "DL123456789",
                    "dateOfExpiry": "2027-01-01T00:00:00.000Z",
                    "currentStatus": "Active",
                    "currentStatusDetail": "Valid until renewal in 2027",
                    "createdAt": "2025-06-15T16:13:36.000Z",
                    "updatedAt": "2025-06-15T19:31:25.000Z",
                    "Category": {
                        "id": 1,
                        "Category": "Membership of Professional Body",
                        "createdAt": "2025-06-12T07:09:09.000Z",
                        "updatedAt": "2025-06-12T07:09:09.000Z"
                    },
                    "Country": {
                        "id": 1,
                        "country": "Australia",
                        "createdAt": "2025-06-12T07:11:52.000Z",
                        "updatedAt": "2025-06-12T07:11:52.000Z"
                    }
                }
            ],
            "priorityProcess": [
                {
                    "id": 1,
                    "userId": 1,
                    "standardApplication": "Standard Application",
                    "priorityProcessing": "Express",
                    "otherDescription": "Needed for urgent job application",
                    "createdAt": "2025-06-12T08:22:36.000Z",
                    "updatedAt": "2025-06-15T19:31:25.000Z",
                    "PriorityOption": null
                }
            ]
        }
    ]
}
  ''';

  static Future<void> generateApplicationRecordPdf(BuildContext context, int userId) async {
    try {
      // Parse JSON data
      final Map<String, dynamic> data = json.decode(jsonData);
      final List<dynamic> users = data['users'];

      // Find user by ID
      final userMap = users.firstWhere(
        (user) => user['userId'] == userId,
        orElse: () => null,
      );

      if (userMap == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User with ID $userId not found")),
        );
        return;
      }

      // Create PDF
      final pdf = pw.Document();

      // Add pages
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              // Header
              _buildHeader(),
              pw.SizedBox(height: 20),

              // Personal Information
              _buildPersonalDetails(userMap),
              pw.SizedBox(height: 20),

              // Educational Qualifications
              if (userMap['EducationQualifications'] != null && 
                  (userMap['EducationQualifications'] as List).isNotEmpty)
                _buildEducationQualifications(userMap['EducationQualifications']),
              pw.SizedBox(height: 20),

              // Basic Education
              if (userMap['Educations'] != null && 
                  (userMap['Educations'] as List).isNotEmpty)
                _buildEducations(userMap['Educations']),
              pw.SizedBox(height: 20),

              // Employment History
              if (userMap['Employments'] != null && 
                  (userMap['Employments'] as List).isNotEmpty)
                _buildEmployments(userMap['Employments']),
              pw.SizedBox(height: 20),

              // Visa Information
              if (userMap['user_Visas'] != null && 
                  (userMap['user_Visas'] as List).isNotEmpty)
                _buildVisaInformation(userMap['user_Visas']),
              pw.SizedBox(height: 20),

              // Occupation Details
              if (userMap['UserOccupations'] != null && 
                  (userMap['UserOccupations'] as List).isNotEmpty)
                _buildOccupationDetails(userMap['UserOccupations']),
              pw.SizedBox(height: 20),

              // Licences
              if (userMap['Licences'] != null && 
                  (userMap['Licences'] as List).isNotEmpty)
                _buildLicences(userMap['Licences']),
              pw.SizedBox(height: 20),

              // Uploaded Documents
              if (userMap['uploadedDocuments'] != null && 
                  (userMap['uploadedDocuments'] as List).isNotEmpty)
                _buildUploadedDocuments(userMap['uploadedDocuments']),
              pw.SizedBox(height: 20),

              // Priority Processing
              if (userMap['priorityProcess'] != null && 
                  (userMap['priorityProcess'] as List).isNotEmpty)
                _buildPriorityProcessing(userMap['priorityProcess']),
            ];
          },
        ),
      );

      // Save PDF based on platform
      if (kIsWeb) {
        await _savePdfWeb(context, pdf, userId);
      } else {
        await _savePdfMobile(context, pdf, userId);
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating PDF: $e")),
      );
    }
  }

    // Web-specific PDF download
  static Future<void> _savePdfWeb(BuildContext context, pw.Document pdf, int userId) async {
    try {
      final bytes = await pdf.save();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'vetassess_application_record_user_${userId}_$timestamp.pdf';

      // Create blob and download for web
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = fileName;
      html.document.body?.children.add(anchor);

      // Trigger download
      anchor.click();

      // Clean up
      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF downloaded successfully: $fileName"),
          backgroundColor: Colors.green,
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading PDF: $e")),
      );
    }
  }

  // Mobile-specific PDF save
  static Future<void> _savePdfMobile(BuildContext context, pw.Document pdf, int userId) async {
    try {
      // Request storage permission for mobile only
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Storage permission is required to save PDF")),
          );
          return;
        }
      }

      // Get directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        if (directory != null) {
          // Create a more accessible path
          String newPath = "";
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Download";
          directory = Directory(newPath);
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory != null) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // Generate filename with timestamp
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'vetassess_application_record_user_${userId}_$timestamp.pdf';
        final file = File('${directory.path}/$fileName');

        // Save PDF
        await file.writeAsBytes(await pdf.save());

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("PDF saved successfully: $fileName"),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                await OpenFile.open(file.path);
              },
            ),
          ),
        );
      } else {
        throw Exception("Could not access storage directory");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving PDF: $e")),
      );
    }
  }

  static pw.Widget _buildHeader() {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue50,
        border: pw.Border.all(color: PdfColors.blue200),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            'VETASSESS Application Record',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue800,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Generated on: ${DateTime.now().toString().split(' ')[0]}',
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.grey600,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildPersonalDetails(Map<String, dynamic> user) {
    final personalDetails = user['PersonalDetails'] != null && 
                           (user['PersonalDetails'] as List).isNotEmpty
        ? user['PersonalDetails'][0]
        : {};

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Personal Details'),
        pw.SizedBox(height: 10),
        _buildInfoGrid([
          ['Full Name', '${personalDetails['givenNames'] ?? user['givenNames'] ?? ''} ${personalDetails['surname'] ?? user['surname'] ?? ''}'],
          ['Email', personalDetails['emailAddress'] ?? user['email'] ?? ''],
          ['Date of Birth', personalDetails['dateOfBirth'] ?? user['dateOfBirth'] ?? ''],
          ['Gender', personalDetails['gender'] ?? ''],
          ['Country of Birth', personalDetails['countryOfBirth'] ?? ''],
          ['Citizenship', personalDetails['citizenshipCountry'] ?? ''],
          ['Passport Number', personalDetails['currentPassportNumber'] ?? ''],
          ['Mobile Number', personalDetails['mobileNumber'] ?? ''],
          ['Postal Address', _buildAddress(personalDetails, 'postal')],
          ['Home Address', _buildAddress(personalDetails, 'home')],
        ]),
        if (personalDetails['isAgentAuthorized'] == true) ...[
          pw.SizedBox(height: 15),
          _buildSubSectionTitle('Agent Information'),
          pw.SizedBox(height: 10),
          _buildInfoGrid([
            ['Agent Name', '${personalDetails['agentGivenNames'] ?? ''} ${personalDetails['agentSurname'] ?? ''}'],
            ['Company', personalDetails['agentCompanyName'] ?? ''],
            ['MARA Number', personalDetails['agentMaraNumber'] ?? ''],
            ['Email', personalDetails['agentEmailAddress'] ?? ''],
            ['Phone', personalDetails['agentDaytimeTelephoneNumber'] ?? ''],
            ['Address', _buildAddress(personalDetails, 'agent')],
          ]),
        ],
      ],
    );
  }

  static pw.Widget _buildEducationQualifications(List<dynamic> qualifications) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Education Qualifications'),
        pw.SizedBox(height: 10),
        ...qualifications.map((qualification) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 15),
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          ),
          child: _buildInfoGrid([
            ['Qualification Name', qualification['qualificationName'] ?? ''],
            ['Major Field', qualification['majorField'] ?? ''],
            ['Institution', qualification['institutionName'] ?? ''],
            ['Awarding Body', qualification['awardingBodyName'] ?? ''],
            ['Country', qualification['awardingBodyCountry'] ?? ''],
            ['Course Duration', qualification['courseLengthYearsOrSemesters'] ?? ''],
            ['Study Mode', qualification['studyMode'] ?? ''],
            ['Start Date', qualification['courseStartDate'] ?? ''],
            ['End Date', qualification['courseEndDate'] ?? ''],
            ['Qualification Awarded', qualification['qualificationAwardedDate'] ?? ''],
          ]),
        )).toList(),
      ],
    );
  }

  static pw.Widget _buildEducations(List<dynamic> educations) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Basic Education'),
        pw.SizedBox(height: 10),
        ...educations.map((education) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          ),
          child: _buildInfoGrid([
            ['Level', 'Level ${education['level']}'],
            ['Country', education['country'] ?? ''],
            ['Duration', '${education['numberOfYears']} years'],
            ['Start Date', education['dateStarted'] ?? ''],
            ['End Date', education['dateFinished'] ?? ''],
            ['Year Completed', education['yearCompleted'] ?? ''],
            ['Certificate Details', education['certificateDetails'] ?? ''],
          ]),
        )).toList(),
      ],
    );
  }

  static pw.Widget _buildEmployments(List<dynamic> employments) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Employment History'),
        pw.SizedBox(height: 10),
        ...employments.map((employment) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 15),
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _buildInfoGrid([
                ['Business Name', employment['businessName'] ?? ''],
                ['Position', employment['positionJobTitle'] ?? ''],
                ['Employer', employment['Nameofemployer'] ?? ''],
                ['Start Date', employment['dateofemploymentstarted'] ?? ''],
                ['End Date', employment['dateofemploymentended'] ?? ''],
                ['Working Hours', '${employment['normalrequiredWorkinghours'] ?? ''} hours/week'],
                ['Address', '${employment['streetaddress'] ?? ''}, ${employment['suburbCity'] ?? ''}, ${employment['state'] ?? ''} ${employment['PostCode'] ?? ''}'],
                ['Contact', employment['emailaddress'] ?? ''],
              ]),
              if (employment['task1'] != null) ...[
                pw.SizedBox(height: 10),
                pw.Text('Key Responsibilities:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                ...['task1', 'task2', 'task3', 'task4', 'task5']
                    .where((task) => employment[task] != null)
                    .map((task) => pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10, bottom: 2),
                      child: pw.Text('• ${employment[task]}'),
                    )),
              ],
            ],
          ),
        )).toList(),
      ],
    );
  }

  static pw.Widget _buildVisaInformation(List<dynamic> visas) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Visa Information'),
        pw.SizedBox(height: 10),
        ...visas.map((visaInfo) {
          final visa = visaInfo['Visa'];
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 10),
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
            ),
            child: _buildInfoGrid([
              ['Visa Name', visa['visaName'] ?? ''],
              ['Category', visa['category'] ?? ''],
              ['Assessment Type', visa['assessmentType']?.toString() ?? ''],
            ]),
          );
        }).toList(),
      ],
    );
  }

  static pw.Widget _buildOccupationDetails(List<dynamic> occupations) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Occupation Details'),
        pw.SizedBox(height: 10),
        ...occupations.map((occupationInfo) {
          final occupation = occupationInfo['Occupation'];
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 10),
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildInfoGrid([
                  ['Occupation Name', occupation['occupationName'] ?? ''],
                  ['ANZSCO Code', occupation['anzscoCode'] ?? ''],
                ]),
                if (occupation['SkillsRequirement'] != null) ...[
                  pw.SizedBox(height: 8),
                  pw.Text('Skills Requirement:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 4),
                  pw.Text(occupation['SkillsRequirement']),
                ],
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  static pw.Widget _buildLicences(List<dynamic> licences) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Licences & Professional Memberships'),
        pw.SizedBox(height: 10),
        ...licences.map((licence) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          ),
          child: _buildInfoGrid([
            ['Type', licence['typeOfLicence'] ?? ''],
            ['Registration Number', licence['registrationNumber'] ?? ''],
            ['Issuing Body', licence['nameofIssuingBody'] ?? ''],
            ['Country', licence['Country']?['country'] ?? ''],
            ['Expiry Date', licence['dateOfExpiry'] ?? ''],
            ['Status', licence['currentStatus'] ?? ''],
            ['Category', licence['Category']?['Category'] ?? ''],
          ]),
        )).toList(),
      ],
    );
  }

  static pw.Widget _buildUploadedDocuments(List<dynamic> documents) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Uploaded Documents'),
        pw.SizedBox(height: 10),
        ...documents.map((doc) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          ),
          child: _buildInfoGrid([
            ['Category', doc['category']?['documentCategory'] ?? ''],
            ['Type', doc['type']?['name'] ?? ''],
            ['File Name', doc['uploadfile'] ?? ''],
            ['Description', doc['description'] ?? ''],
          ]),
        )).toList(),
      ],
    );
  }

  static pw.Widget _buildPriorityProcessing(List<dynamic> priorityProcesses) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Priority Processing'),
        pw.SizedBox(height: 10),
        ...priorityProcesses.map((process) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          ),
          child: _buildInfoGrid([
            ['Application Type', process['standardApplication'] ?? ''],
            ['Priority Processing', process['priorityProcessing'] ?? ''],
            ['Description', process['otherDescription'] ?? ''],
          ]),
        )).toList(),
      ],
    );
  }

  static pw.Widget _buildSectionTitle(String title) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: pw.BoxDecoration(
        color: PdfColors.blue100,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue800,
        ),
      ),
    );
  }

  static pw.Widget _buildSubSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.blue700,
      ),
    );
  }

  static pw.Widget _buildInfoGrid(List<List<String>> items) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: const {
        0: pw.FlexColumnWidth(1),
        1: pw.FlexColumnWidth(2),
      },
      children: items
          .where((item) => item.length >= 2 && item[1].isNotEmpty)
          .map((item) => pw.TableRow(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    color: PdfColors.grey50,
                    child: pw.Text(
                      item[0],
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      item[1],
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }

  static String _buildAddress(Map<String, dynamic> details, String type) {
    List<String> addressParts = [];

    switch (type) {
      case 'postal':
        if (details['postalStreetAddress'] != null) addressParts.add(details['postalStreetAddress']);
        if (details['postalStreetAddressLine2'] != null) addressParts.add(details['postalStreetAddressLine2']);
        if (details['postalStreetAddressLine3'] != null) addressParts.add(details['postalStreetAddressLine3']);
        if (details['postalStreetAddressLine4'] != null) addressParts.add(details['postalStreetAddressLine4']);
        if (details['postalSuburbCity'] != null) addressParts.add(details['postalSuburbCity']);
        if (details['postalState'] != null) addressParts.add(details['postalState']);
        if (details['postalPostCode'] != null) addressParts.add(details['postalPostCode']);
        if (details['postalCountry'] != null) addressParts.add(details['postalCountry']);
        break;
      case 'home':
        if (details['homeStreetAddress'] != null) addressParts.add(details['homeStreetAddress']);
        if (details['homeStreetAddressLine2'] != null) addressParts.add(details['homeStreetAddressLine2']);
        if (details['homeStreetAddressLine3'] != null) addressParts.add(details['homeStreetAddressLine3']);
        if (details['homeStreetAddressLine4'] != null) addressParts.add(details['homeStreetAddressLine4']);
        if (details['homeSuburbCity'] != null) addressParts.add(details['homeSuburbCity']);
        if (details['homeState'] != null) addressParts.add(details['homeState']);
        if (details['homePostCode'] != null) addressParts.add(details['homePostCode']);
        if (details['homeCountry'] != null) addressParts.add(details['homeCountry']);
        break;
      case 'agent':
        if (details['agentStreetAddress'] != null) addressParts.add(details['agentStreetAddress']);
        if (details['agentStreetAddressLine2'] != null) addressParts.add(details['agentStreetAddressLine2']);
        if (details['agentStreetAddressLine3'] != null) addressParts.add(details['agentStreetAddressLine3']);
        if (details['agentStreetAddressLine4'] != null) addressParts.add(details['agentStreetAddressLine4']);
        if (details['agentSuburbCity'] != null) addressParts.add(details['agentSuburbCity']);
        if (details['agentState'] != null) addressParts.add(details['agentState']);
        if (details['agentPostCode'] != null) addressParts.add(details['agentPostCode']);
        if (details['agentCountry'] != null) addressParts.add(details['agentCountry']);
        break;
    }

    return addressParts.where((part) => part.toString().trim().isNotEmpty).join(', ');
  }

  static Future<void> _savePdf(BuildContext context, pw.Document pdf, int userId) async {
    try {
      // Request storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Storage permission is required to save PDF")),
          );
          return;
        }
      }

      // Get directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        if (directory != null) {
          // Create a more accessible path
          String newPath = "";
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Download";
          directory = Directory(newPath);
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory != null) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // Generate filename with timestamp
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'vetassess_application_record_user_${userId}_$timestamp.pdf';
        final file = File('${directory.path}/$fileName');

        // Save PDF
        await file.writeAsBytes(await pdf.save());

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("PDF saved successfully: $fileName"),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                await OpenFile.open(file.path);
              },
            ),
          ),
        );
      } else {
        throw Exception("Could not access storage directory");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving PDF: $e")),
      );
    }
  }

  // Static method to be called from other parts of the app
  static Future<void> generatePdfForUser(BuildContext context, int userId) async {
    await generateApplicationRecordPdf(context, userId);
  }
}