import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../providers/school_data_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SchoolDataProvider>().data;
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final mobile = MediaQuery.sizeOf(context).width < 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Contact NBFA Science College',
            subtitle:
                'Reach admissions, faculty, and administration teams instantly.',
          ).animate().fadeIn().slideY(begin: 0.08, end: 0),
          const SizedBox(height: 16),
          Flex(
            direction: mobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: GlassCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: 'Name',
                          controller: _nameController,
                          validator: _required,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          label: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: _required,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          label: 'Message',
                          controller: _messageController,
                          maxLines: 5,
                          validator: _required,
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.primaryNavy,
                          ),
                          icon: const Icon(Icons.send),
                          label: const Text('Send Message'),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.08, end: 0),
              ),
              SizedBox(width: mobile ? 0 : 12, height: mobile ? 12 : 0),
              Expanded(
                flex: 2,
                child: GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Campus Location',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Address: ${data.contactInfo.address}'),
                      Text('Phone: ${data.contactInfo.phone}'),
                      Text('Email: ${data.contactInfo.email}'),
                      const SizedBox(height: 12),
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryNavy.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppTheme.primaryNavy.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            data.contactInfo.mapsPlaceholder,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 180.ms).slideY(begin: 0.08, end: 0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Message submitted successfully. We will contact you soon.',
          ),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
