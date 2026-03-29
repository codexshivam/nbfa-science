import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/school_data.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({super.key, required this.document});

  final DocumentItem document;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        border: Border.all(color: AppTheme.primaryNavy.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(document.iconData, color: AppTheme.accentCrimson, size: 30),
          const SizedBox(height: 10),
          Text(
            document.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Row(
            children: [
              Text(document.size, style: Theme.of(context).textTheme.bodySmall),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Downloading ${document.title}...')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Download'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
