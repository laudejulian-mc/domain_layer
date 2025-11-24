import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../providers.dart';
import '../../../domain/entities/announcement_entity.dart';

class CreateAnnouncementScreen extends ConsumerStatefulWidget {
  const CreateAnnouncementScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAnnouncementScreen> createState() => _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends ConsumerState<CreateAnnouncementScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(announcementsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('New Announcement')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'message',
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 5,
                validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final v = _formKey.currentState!.value;
                    final now = DateTime.now();
                    final announcement = Announcement(id: UniqueKey().toString(), title: v['title'] as String, message: v['message'] as String, createdAt: now);
                    notifier.create(announcement);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Publish'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
