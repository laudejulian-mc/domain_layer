import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

class MembersListScreen extends ConsumerWidget {
  const MembersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Placeholder list - in real implementation this would come from a repository
    final members = [
      {'id': '1', 'name': 'Alice', 'status': 'active', 'dues': 'paid'},
      {'id': '2', 'name': 'Bob', 'status': 'inactive', 'dues': 'unpaid'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Members')),
      bottomNavigationBar: const BottomNavigation(),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final m = members[index];
          return ListTile(
            title: Text(m['name']!),
            subtitle: Text('Status: ${m['status']} — Dues: ${m['dues']}'),
            onTap: () => context.go('/member/${m['id']}'),
          );
        },
      ),
    );
  }
}
