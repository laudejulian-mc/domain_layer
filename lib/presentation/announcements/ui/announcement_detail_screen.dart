import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../announcement_state.dart';
import '../../../domain/entities/announcement_entity.dart';

class AnnouncementDetailScreen extends ConsumerWidget {
  final String id;
  const AnnouncementDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(announcementsNotifierProvider.notifier);
    final state = ref.watch(announcementsNotifierProvider);

    // ensure detail loaded
    WidgetsBinding.instance.addPostFrameCallback((_) => notifier.loadAnnouncements());

    Announcement? ann;
    try {
      ann = state.announcements.firstWhere((a) => a.id == id);
    } catch (_) {
      ann = state.selected ?? (state.announcements.isNotEmpty ? state.announcements.first : null);
    }

    if (ann == null) {
      return Scaffold(appBar: AppBar(title: const Text('Announcement')), body: const Center(child: Text('Not found')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Announcement')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ann.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(ann.message, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text('Posted: ${ann.createdAt.toLocal()}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await notifier.sendNotification(ann!);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification sent (placeholder)')));
              },
              child: const Text('Send Notification'),
            )
          ],
        ),
      ),
    );
  }
}
