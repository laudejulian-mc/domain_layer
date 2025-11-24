import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

import '../../membership/providers.dart';
import '../../membership/membership_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(membershipNotifierProvider) as MembershipState;

    final user = state.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? const Center(child: Text('No user signed in'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('Role: ${user.role.toString().split('.').last}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit profile not implemented yet')));
                    },
                    child: const Text('Edit Profile'),
                  )
                ],
              ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
