import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/screens/admin_screens/download_admin_doc.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

class SubmittedAppl extends ConsumerStatefulWidget {
  const SubmittedAppl({super.key});

  @override
  ConsumerState<SubmittedAppl> createState() => _SubmittedApplState();
}

class _SubmittedApplState extends ConsumerState<SubmittedAppl> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(getAllformsProviders.notifier).fetchallCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginId = ref.watch(loginProvider).response?.userId;
    final forms = ref.watch(getAllformsProviders);
    final users = forms.users;

    if (users == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = users.where((item) => item.userId == loginId).toList();
    final isMobile = MediaQuery.of(context).size.width < 700;

    return LoginPageLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Submitted Applications',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 20),

            if (filteredData.isEmpty)
              const Center(
                child: Text(
                  'No applications found.',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
            else
              isMobile
                  ? Column(
                      children: filteredData.map((user) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow("Application No.", user.userId.toString()),
                                _buildInfoRow("Name", user.givenNames ?? ''),
                                _buildInfoRow("DOB", user.dateOfBirth ?? ''),
                                _buildInfoRow("Email", user.email ?? ''),
                                _buildInfoRow("Mobile", user.employments?.isNotEmpty == true
                                    ? user.employments!.first.mobileNo.toString()
                                    : ''),
                                _buildInfoRow("Occupation", user.userOccupations?.isNotEmpty == true
                                    ? user.userOccupations!.first.occupation?.occupationName ?? ''
                                    : ''),
                                _buildInfoRow("Status", user.applicationStatus ?? ''),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () async {
                                      await PdfDownloadadminService.downloadadminCertificate(
                                        context,
                                        ref,
                                        user.userId,
                                      );
                                    },
                                    child: const Text("Click Here", style: TextStyle(color: Colors.orange)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : DataTable(
                      columnSpacing: 80,
                      dataRowHeight: 60,
                      headingRowColor: MaterialStateProperty.all(Color(0xFF006257)),
                      columns: const [
                        DataColumn(label: Text('App No.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('DOB', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('Occupation', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                        DataColumn(label: Text('Download', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                      ],
                      rows: filteredData.map((user) {
                        return DataRow(
                          cells: [
                            DataCell(Text(user.userId.toString())),
                            DataCell(Text(user.givenNames ?? '')),
                            DataCell(Text(user.dateOfBirth ?? '')),
                            DataCell(Text(user.email ?? '', overflow: TextOverflow.ellipsis)),
                            DataCell(Text(user.employments?.isNotEmpty == true
                                ? user.employments!.first.mobileNo.toString()
                                : '')),
                            DataCell(Text(user.userOccupations?.isNotEmpty == true
                                ? user.userOccupations!.first.occupation?.occupationName ?? ''
                                : '')),
                            DataCell(Text(user.applicationStatus ?? '')),
                            DataCell(
                              TextButton(
                                onPressed: () async {
                                  await PdfDownloadadminService.downloadadminCertificate(
                                    context,
                                    ref,
                                    user.userId,
                                  );
                                },
                                child: const Text('Click Here', style: TextStyle(color: Colors.orange)),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
