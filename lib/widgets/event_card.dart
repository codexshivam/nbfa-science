import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/school_data.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final AcademicEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppTheme.primaryNavy.withValues(alpha: 0.06),
        border: Border.all(color: AppTheme.primaryNavy.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.month,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.accentCrimson,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            event.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(event.details, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
