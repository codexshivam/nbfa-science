import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../models/school_data.dart';
import '../providers/school_data_provider.dart';
import '../widgets/event_card.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/stat_counter_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolDataProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(child: Text(provider.error!));
        }

        final data = provider.data;
        if (data == null) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroSection(
                metadata: data.metadata,
              ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 26),
              SectionHeader(
                title: 'Mission & Vision',
                subtitle: data.about.philosophy,
              ).animate().fadeIn(delay: 130.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 860 ? 3 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.about.coreValues.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 2.6 : 1.6,
                    ),
                    itemBuilder: (context, index) {
                      final value = data.about.coreValues[index];
                      return GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.title,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  value.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          )
                          .animate(
                            delay: Duration(milliseconds: 180 + index * 120),
                          )
                          .fadeIn()
                          .slideY(begin: 0.12, end: 0);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Live College Stats',
                subtitle: 'Real-time snapshot of our learning ecosystem.',
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 920 ? 3 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.liveStats.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 3.2 : 1.8,
                    ),
                    itemBuilder: (context, index) {
                      final stat = data.liveStats[index];
                      return StatCounterCard(
                            label: stat.label,
                            value: stat.value,
                            icon: stat.iconData,
                          )
                          .animate(
                            delay: Duration(milliseconds: 350 + index * 130),
                          )
                          .fadeIn()
                          .slideY(begin: 0.1, end: 0);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Explore NBFA Science',
                subtitle:
                    'Jump directly to key student resources and opportunities.',
              ).animate().fadeIn(delay: 390.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 920 ? 4 : 2;
                  final actions = [
                    ('Admissions', Icons.how_to_reg, '/admissions'),
                    ('Academics', Icons.menu_book, '/academics'),
                    ('Calendar', Icons.calendar_month, '/calendar'),
                    ('Documents', Icons.folder_copy, '/documents'),
                  ];

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: actions.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 2 ? 2.2 : 1.8,
                    ),
                    itemBuilder: (context, index) {
                      final item = actions[index];
                      return _QuickAccessCard(
                            label: item.$1,
                            icon: item.$2,
                            route: item.$3,
                          )
                          .animate(
                            delay: Duration(milliseconds: 430 + index * 80),
                          )
                          .fadeIn()
                          .slideY(begin: 0.08, end: 0);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Upcoming Academic Events',
                subtitle:
                    'Stay updated on admissions, terminals, fairs, and holidays.',
              ).animate().fadeIn(delay: 430.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 12),
              ...data.calendar.events.take(3).toList().asMap().entries.map((
                entry,
              ) {
                final index = entry.key;
                final event = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: EventCard(event: event)
                      .animate(delay: Duration(milliseconds: 480 + index * 90))
                      .fadeIn()
                      .slideY(begin: 0.08, end: 0),
                );
              }),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Campus Highlights',
                subtitle:
                    'Industry-aligned facilities for modern scientific education.',
              ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: data.facilityHighlights
                    .map(
                      (highlight) =>
                          SizedBox(
                                width: MediaQuery.sizeOf(context).width > 860
                                    ? 380
                                    : double.infinity,
                                child: GlassCard(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        highlight.iconData,
                                        color: AppTheme.primaryNavy,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              highlight.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(highlight.description),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 500.ms)
                              .slideY(begin: 0.1, end: 0),
                    )
                    .toList(),
              ),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Leadership Team',
                subtitle: 'Meet the academic leaders shaping the NBFA vision.',
              ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 900 ? 2 : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.about.leadership.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 2.2 : 2.6,
                    ),
                    itemBuilder: (context, index) {
                      final leader = data.about.leadership[index];
                      return GlassCard(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 34,
                                  backgroundColor: AppTheme.primaryNavy
                                      .withValues(alpha: 0.12),
                                  child: Text(
                                    _initials(leader.name),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppTheme.primaryNavy,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        leader.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        leader.role,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: AppTheme.accentCrimson,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(leader.bio),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate(
                            delay: Duration(milliseconds: 600 + index * 120),
                          )
                          .fadeIn()
                          .slideY(begin: 0.1, end: 0);
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Student Voices',
                subtitle: 'What our graduates say about their NBFA journey.',
              ).animate().fadeIn(delay: 650.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 12),
              ...data.testimonials.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child:
                      GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '“${item.quote}”',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${item.name} • Batch ${item.batch}',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 2),
                                Text(item.achievement),
                              ],
                            ),
                          )
                          .animate(
                            delay: Duration(milliseconds: 700 + index * 100),
                          )
                          .fadeIn()
                          .slideY(begin: 0.08, end: 0),
                );
              }),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Frequently Asked Questions',
                subtitle: 'Quick answers for students and parents.',
              ).animate().fadeIn(delay: 750.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 12),
              ...data.faq.asMap().entries.map((entry) {
                final index = entry.key;
                final faq = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child:
                      GlassCard(
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              title: Text(
                                faq.question,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(faq.answer),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate(
                            delay: Duration(milliseconds: 800 + index * 90),
                          )
                          .fadeIn()
                          .slideY(begin: 0.08, end: 0),
                );
              }),
              const SizedBox(height: 20),
              _CallToActionBanner(
                metadata: data.metadata,
              ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.08, end: 0),
              const SizedBox(height: 26),
              _HomeFooter(
                data: data,
              ).animate().fadeIn(delay: 980.ms).slideY(begin: 0.08, end: 0),
            ],
          ),
        );
      },
    );
  }
}

class _CallToActionBanner extends StatelessWidget {
  const _CallToActionBanner({required this.metadata});

  final SchoolMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 760;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryNavy,
            AppTheme.primaryNavy.withValues(alpha: 0.82),
          ],
        ),
      ),
      child: Flex(
        direction: mobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: mobile
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to begin your science journey?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  metadata.motto,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          if (!mobile) const SizedBox(width: 12),
          if (mobile) const SizedBox(height: 12),
          FilledButton(
            onPressed: () => context.go('/admissions'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.accentGold,
              foregroundColor: AppTheme.primaryNavy,
            ),
            child: const Text('Apply for Admission'),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => context.go(route),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.primaryNavy),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'Open section',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.accentCrimson,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeFooter extends StatelessWidget {
  const _HomeFooter({required this.data});

  final SchoolData data;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Flex(
        direction: mobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.metadata.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.metadata.motto,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.88),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Established: ${data.metadata.establishedBs}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
                Text(
                  'Affiliation: ${data.metadata.affiliation}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          if (!mobile) const SizedBox(width: 20),
          if (mobile) const SizedBox(height: 14),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Links',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.accentGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                _FooterLink(label: 'Admissions', route: '/admissions'),
                _FooterLink(label: 'Academics', route: '/academics'),
                _FooterLink(label: 'Gallery', route: '/gallery'),
                _FooterLink(label: 'Contact', route: '/contact'),
              ],
            ),
          ),
          if (!mobile) const SizedBox(width: 20),
          if (mobile) const SizedBox(height: 14),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.accentGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.contactInfo.address,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  data.contactInfo.phone,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  data.contactInfo.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(10, 26),
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white,
        ),
      ),
    );
  }
}

String _initials(String name) {
  final tokens = name.trim().split(' ');
  if (tokens.length == 1) {
    return tokens.first.substring(0, 1).toUpperCase();
  }

  return '${tokens.first.substring(0, 1)}${tokens.last.substring(0, 1)}'
      .toUpperCase();
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.metadata});

  final SchoolMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          SizedBox(
            height: mobile ? 460 : 420,
            width: double.infinity,
            child: Image.network(
              metadata.heroImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _ImagePlaceholder(
                  label: 'Hero image unavailable',
                  height: mobile ? 460 : 420,
                );
              },
            ),
          ),
          Container(
            height: mobile ? 460 : 420,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryNavy.withValues(alpha: 0.9),
                  AppTheme.primaryNavy.withValues(alpha: 0.5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(28),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      metadata.heroTitle,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      metadata.heroSubtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                    const SizedBox(height: 22),
                    FilledButton.icon(
                      onPressed: () => context.go('/admissions'),
                      icon: const Icon(Icons.rocket_launch),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.accentGold,
                        foregroundColor: AppTheme.primaryNavy,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      label: const Text('Join the Future of Science'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.label, required this.height});

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryNavy.withValues(alpha: 0.95),
            AppTheme.primaryNavy.withValues(alpha: 0.75),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.broken_image_outlined,
              color: Colors.white,
              size: 34,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
