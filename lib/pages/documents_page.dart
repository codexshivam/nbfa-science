import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/school_data.dart';
import '../providers/school_data_provider.dart';
import '../widgets/document_card.dart';
import '../widgets/section_header.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SchoolDataProvider>().data;
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filtered = data.documents.where((document) {
      final value = '${document.title} ${document.type}'.toLowerCase();
      return value.contains(_query.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Document Repository',
            subtitle: 'Search and download academic files instantly.',
          ).animate().fadeIn().slideY(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search documents',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1100
                  ? 3
                  : constraints.maxWidth > 700
                  ? 2
                  : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  final DocumentItem document = filtered[index];
                  return DocumentCard(document: document)
                      .animate(delay: Duration(milliseconds: 120 + index * 70))
                      .fadeIn()
                      .slideY(begin: 0.08, end: 0);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
