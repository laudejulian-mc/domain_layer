import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../announcement_state.dart';
import '../../../domain/entities/announcement_entity.dart';
import 'create_announcement_screen.dart';
import 'announcement_detail_screen.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

class AnnouncementsListScreen extends ConsumerWidget {
  const AnnouncementsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(announcementsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
      bottomNavigationBar: const BottomNavigation(),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(announcementsNotifierProvider.notifier).loadAnnouncements(),
        child: Builder(builder: (context) {
          if (state.status == AnnouncementStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == AnnouncementStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'Error loading announcements'));
          }

          final list = state.announcements;
          if (list.isEmpty) return const Center(child: Text('No announcements yet'));

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final a = list[i];
              return Card(
                child: ListTile(
                  title: Text(a.title),
                  subtitle: Text(a.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Text('${a.createdAt.toLocal()}'.split(' ').first),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnnouncementDetailScreen(id: a.id))),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateAnnouncementScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
