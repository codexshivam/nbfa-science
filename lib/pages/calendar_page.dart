import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/school_data.dart';
import '../providers/school_data_provider.dart';
import '../widgets/event_card.dart';
import '../widgets/section_header.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SchoolDataProvider>().data;
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final eventsByDate = _mapEvents(data.calendar.events);
    final selectedEvents =
        eventsByDate[_dateOnly(_selectedDay ?? _focusedDay)] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Academic Calendar (${data.calendar.session})',
            subtitle: 'Exams, fairs, and holidays at your fingertips.',
          ).animate().fadeIn().slideY(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          TableCalendar<AcademicEvent>(
            firstDay: DateTime(DateTime.now().year, 1, 1),
            lastDay: DateTime(DateTime.now().year, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) => eventsByDate[_dateOnly(day)] ?? [],
            calendarStyle: const CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
            ),
          ).animate().fadeIn(delay: 120.ms).slideY(begin: 0.08, end: 0),
          const SizedBox(height: 20),
          Text(
            'Upcoming Events',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...selectedEvents.map(
            (event) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: EventCard(
                event: event,
              ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.08, end: 0),
            ),
          ),
          if (selectedEvents.isEmpty)
            const Text('No event for this day. Select another date.'),
        ],
      ),
    );
  }

  Map<DateTime, List<AcademicEvent>> _mapEvents(List<AcademicEvent> events) {
    final now = DateTime.now();
    final mapped = <DateTime, List<AcademicEvent>>{};

    for (var index = 0; index < events.length; index++) {
      final day = DateTime(now.year, (index % 12) + 1, 10);
      mapped.putIfAbsent(_dateOnly(day), () => []).add(events[index]);
    }

    return mapped;
  }

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
