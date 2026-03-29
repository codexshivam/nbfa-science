import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../models/school_data.dart';
import '../providers/school_data_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SchoolDataProvider>().data;
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: data.academicGroups.length,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AcademicsHero(
              data: data,
            ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.08, end: 0),
            const SizedBox(height: 20),
            const SectionHeader(
              title: 'Academic Groups',
              subtitle:
                  'Explore detailed syllabus modules for Physical and Biological streams.',
            ).animate().fadeIn().slideY(begin: 0.08, end: 0),
            const SizedBox(height: 16),
            TabBar(
              isScrollable: true,
              tabs: data.academicGroups
                  .map((group) => Tab(text: group.group))
                  .toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 430,
              child: TabBarView(
                children: data.academicGroups
                    .map((group) => _GroupDetailsCard(group: group))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Faculty & Departments',
              subtitle:
                  'Experienced mentors and well-equipped labs powering every batch.',
            ).animate().fadeIn(delay: 170.ms).slideY(begin: 0.08, end: 0),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 980 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.facultyDepartments.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: columns == 1 ? 1.6 : 1.75,
                  ),
                  itemBuilder: (context, index) {
                    final department = data.facultyDepartments[index];
                    return _DepartmentCard(department: department)
                        .animate(
                          delay: Duration(milliseconds: 220 + index * 110),
                        )
                        .fadeIn()
                        .slideY(begin: 0.09, end: 0);
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            SectionHeader(
              title: data.scholarshipScheme.title,
              subtitle:
                  'Merit and equity pathways designed to make quality education accessible.',
            ).animate().fadeIn(delay: 260.ms).slideY(begin: 0.08, end: 0),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 1100
                    ? 4
                    : constraints.maxWidth > 760
                    ? 2
                    : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.scholarshipScheme.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: columns == 1 ? 2.3 : 1.35,
                  ),
                  itemBuilder: (context, index) {
                    final category = data.scholarshipScheme.categories[index];
                    return GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.type,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 8),
                              Text('Criteria: ${category.criteria}'),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.primaryNavy.withValues(
                                    alpha: 0.08,
                                  ),
                                ),
                                child: Text(
                                  category.benefit,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppTheme.primaryNavy,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate(
                          delay: Duration(milliseconds: 320 + index * 90),
                        )
                        .fadeIn()
                        .slideY(begin: 0.08, end: 0);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AcademicsHero extends StatelessWidget {
  const _AcademicsHero({required this.data});

  final SchoolData data;

  @override
  Widget build(BuildContext context) {
    final cards = [
      ('Programs', data.academicGroups.length.toString(), Icons.menu_book),
      (
        'Faculty Members',
        data.facultyDepartments
            .fold<int>(0, (sum, dept) => sum + dept.totalStaff)
            .toString(),
        Icons.groups,
      ),
      (
        'Scholarships',
        data.scholarshipScheme.categories.length.toString(),
        Icons.workspace_premium,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Academic Excellence',
          subtitle:
              'NEB-aligned pathways, practical science, and strong university preparation.',
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth > 900 ? 3 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: columns == 1 ? 3.1 : 2.1,
              ),
              itemBuilder: (context, index) {
                final item = cards[index];
                return GlassCard(
                  child: Row(
                    children: [
                      Icon(item.$3, color: AppTheme.primaryNavy, size: 30),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.$2,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(item.$1),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _GroupDetailsCard extends StatelessWidget {
  const _GroupDetailsCard({required this.group});

  final AcademicGroup group;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.group,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(group.overview),
          const SizedBox(height: 16),
          ...group.modules.map(
            (module) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(module)),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.12, end: 0);
  }
}

class _DepartmentCard extends StatelessWidget {
  const _DepartmentCard({required this.department});

  final FacultyDepartment department;

  @override
  Widget build(BuildContext context) {
    final highlights = department.featuredLecturers.isNotEmpty
        ? department.featuredLecturers
        : department.labs;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            department.department,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            'Head: ${department.head}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.accentCrimson,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text('Faculty Strength: ${department.totalStaff}'),
          const SizedBox(height: 10),
          Text(
            department.featuredLecturers.isNotEmpty
                ? 'Featured Lecturers'
                : 'Lab Facilities',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ...highlights.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    department.featuredLecturers.isNotEmpty
                        ? Icons.person
                        : Icons.science,
                    size: 16,
                    color: AppTheme.primaryNavy,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
