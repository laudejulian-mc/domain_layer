import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

import '../providers.dart';
import '../club_info_state.dart';
import 'edit_club_info_screen.dart';

class ClubInfoScreen extends ConsumerWidget {
  const ClubInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clubInfoNotifierProvider);
    final notifier = ref.read(clubInfoNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Club Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(builder: (context) {
          if (state.status == ClubInfoStatus.loading) return const Center(child: CircularProgressIndicator());
          if (state.status == ClubInfoStatus.error) return Center(child: Text(state.errorMessage ?? 'Error'));

          final info = state.clubInfo;
          if (info == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => notifier.loadClubInfo(),
                child: const Text('Load Club Info'),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Text('Mission', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(info.mission, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Text('History', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(info.history, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Text('Contact', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(info.contactInfo, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Text('Rules & Guidelines', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                ...info.rules.map((r) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text('• $r', style: Theme.of(context).textTheme.bodyMedium))),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.go('/club-info/edit');
                  },
                  child: const Text('Edit Club Info'),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
