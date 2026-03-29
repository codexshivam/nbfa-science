import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../models/school_data.dart';
import '../providers/school_data_provider.dart';
import '../widgets/section_header.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SchoolDataProvider>().data;
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Gallery',
            subtitle:
                'Explore life at NBFA through our science-centered campus moments.',
          ).animate().fadeIn().slideY(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.sizeOf(context).width > 900 ? 3 : 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: data.galleryImages.length,
            itemBuilder: (context, index) {
              final GalleryImage image = data.galleryImages[index];
              return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _openLightbox(context, image),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        children: [
                          Image.network(
                            image.url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return _GalleryImagePlaceholder(
                                label: image.title,
                                compact: true,
                              );
                            },
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.black.withValues(alpha: 0.45),
                              child: Text(
                                image.title,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .animate(delay: Duration(milliseconds: 80 + index * 70))
                  .fadeIn()
                  .slideY(begin: 0.08, end: 0);
            },
          ),
        ],
      ),
    );
  }

  void _openLightbox(BuildContext context, GalleryImage image) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950, maxHeight: 720),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    image.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _GalleryImagePlaceholder(
                        label: image.title,
                        compact: false,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton.filled(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GalleryImagePlaceholder extends StatelessWidget {
  const _GalleryImagePlaceholder({required this.label, required this.compact});

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: compact ? 170 : 320),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryNavy.withValues(alpha: 0.9),
            AppTheme.primaryNavy.withValues(alpha: 0.7),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white.withValues(alpha: 0.95),
                size: compact ? 28 : 40,
              ),
              const SizedBox(height: 10),
              Text(
                compact ? 'Image unavailable' : 'Preview unavailable',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
