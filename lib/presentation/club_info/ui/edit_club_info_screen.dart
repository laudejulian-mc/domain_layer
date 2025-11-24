import 'package:flutter/foundation.dart' as FormBuilderValidators show required;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../providers.dart';
import '../../../domain/entities/club_info.dart';

class EditClubInfoScreen extends ConsumerStatefulWidget {
  final ClubInfo? clubInfo;
  const EditClubInfoScreen({Key? key, this.clubInfo}) : super(key: key);

  @override
  ConsumerState<EditClubInfoScreen> createState() => _EditClubInfoScreenState();
}

class _EditClubInfoScreenState extends ConsumerState<EditClubInfoScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(clubInfoNotifierProvider.notifier);
    final state = ref.watch(clubInfoNotifierProvider);
    final clubInfo = widget.clubInfo ?? state.clubInfo;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Club Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderTextField(
                  name: 'name',
                  initialValue: clubInfo?.name ?? '',
                  decoration: const InputDecoration(labelText: 'Club Name'),
                  validator: FormBuilderValidators.required,
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'mission',
                  initialValue: clubInfo?.mission ?? '',
                  decoration: const InputDecoration(labelText: 'Mission'),
                  maxLines: 3,
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'history',
                  initialValue: clubInfo?.history ?? '',
                  decoration: const InputDecoration(labelText: 'History'),
                  maxLines: 4, validator: null,
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'contact',
                  initialValue: clubInfo?.contactInfo ?? '',
                  decoration: const InputDecoration(labelText: 'Contact Info'),
                  validator: FormBuilderValidators.required, maxLines: null,
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'rules',
                  initialValue: (clubInfo?.rules ?? []).join('\n'),
                  decoration: const InputDecoration(labelText: 'Rules (one per line)'),
                  maxLines: 6, validator: null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final v = _formKey.currentState!.value;
                      final updated = ClubInfo(
                        id: clubInfo?.id ?? 'main',
                        name: v['name'] as String,
                        mission: v['mission'] as String,
                        history: v['history'] as String? ?? '',
                        contactInfo: v['contact'] as String,
                        rules: (v['rules'] as String).split('\n').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
                      );

                      notifier.updateClubInfo(updated);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

FormBuilderTextField({required String name, required String initialValue, required InputDecoration decoration, required validator, required int maxLines}) {
}
