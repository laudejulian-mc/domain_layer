import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

class MemberDetailScreen extends ConsumerWidget {
  final String memberId;
  const MemberDetailScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Placeholder data for now
    return Scaffold(
      appBar: AppBar(title: Text('Member $memberId')),
      bottomNavigationBar: const BottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Member details for $memberId'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Update status not implemented')));
              },
              child: const Text('Update Status'),
            )
          ],
        ),
      ),
    );
  }
}
