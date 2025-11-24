import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoophub/presentation/membership/providers.dart';
import 'package:hoophub/presentation/membership/membership_state.dart';
import 'package:hoophub/domain/entities/user.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(membershipNotifierProvider);
    final user = state.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${user?.name ?? 'Guest'}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('My Profile'),
            ),
            const SizedBox(height: 8),
            if (user?.role == UserRole.admin)
              ElevatedButton(
                onPressed: () => context.go('/members'),
                child: const Text('Members'),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
