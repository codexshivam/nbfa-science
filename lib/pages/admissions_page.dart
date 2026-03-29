import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class AdmissionsPage extends StatefulWidget {
  const AdmissionsPage({super.key});

  @override
  State<AdmissionsPage> createState() => _AdmissionsPageState();
}

class _AdmissionsPageState extends State<AdmissionsPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _schoolController = TextEditingController();
  final _gpaController = TextEditingController();

  int _step = 0;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _schoolController.dispose();
    _gpaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Admissions Form',
            subtitle: 'Complete your NBFA admission in three simple steps.',
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Form(
              key: _formKey,
              child: Stepper(
                currentStep: _step,
                onStepContinue: _continue,
                onStepCancel: _cancel,
                controlsBuilder: (context, details) {
                  final last = _step == 2;
                  return Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Row(
                      children: [
                        FilledButton(
                          onPressed: details.onStepContinue,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.primaryNavy,
                          ),
                          child: Text(last ? 'Submit' : 'Next'),
                        ),
                        const SizedBox(width: 10),
                        if (_step > 0)
                          OutlinedButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Back'),
                          ),
                      ],
                    ),
                  );
                },
                steps: [
                  Step(
                    title: const Text('Personal Info'),
                    isActive: _step >= 0,
                    content: Column(
                      children: [
                        CustomTextField(
                          label: 'Full Name',
                          controller: _fullNameController,
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
                          label: 'Phone',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: _required,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Academic History'),
                    isActive: _step >= 1,
                    content: Column(
                      children: [
                        CustomTextField(
                          label: 'Previous School',
                          controller: _schoolController,
                          validator: _required,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          label: 'SEE GPA',
                          controller: _gpaController,
                          keyboardType: TextInputType.number,
                          validator: _required,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Document Upload'),
                    isActive: _step >= 2,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload your SEE Marksheet, Character Certificate, and Photograph.',
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Document picker simulated for web demo.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Upload Documents'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _continue() {
    if (_step < 2) {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() => _step += 1);
      }
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Application Submitted',
        desc:
            'Thank you ${_fullNameController.text}. Your admission form has been received successfully.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  void _cancel() {
    if (_step > 0) {
      setState(() => _step -= 1);
    }
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
