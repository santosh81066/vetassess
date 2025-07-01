import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'package:vetassess/providers/login_provider.dart';
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

    return LoginPageLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
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
              DataTable(
                columnSpacing: 30,
                dataRowHeight: 70,
                headingRowColor: MaterialStateProperty.all(Color(0xFF006257)),

                columns: const [
                  DataColumn(label: Text('Application No.', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  DataColumn(label: Text('Applicant Name', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  DataColumn(label: Text('DOB', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  DataColumn(label: Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  DataColumn(label: Text('Occupation', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                ],
                rows: filteredData.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(SizedBox(width: 130, child: Text(user.userId.toString()))),
                      DataCell(SizedBox(width: 150, child: Text(user.givenNames ?? ''))),
                      DataCell(SizedBox(width: 120, child: Text(user.dateOfBirth ?? ''))),
                      DataCell(SizedBox(width: 200, child: Text(user.email ?? ''))),
                      DataCell(SizedBox(
                          width: 130,
                          child: Text(user.employments?.isNotEmpty == true
                              ? user.employments!.first.mobileNo.toString()
                              : ''))),
                      DataCell(SizedBox(
                          width: 200,
                          child: Text(user.userOccupations?.isNotEmpty == true
                              ? user.userOccupations!.first.occupation?.occupationName ?? ''
                              : ''))),
                      DataCell(SizedBox(width: 120, child: Text(user.applicationStatus ?? ''))),
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
}
