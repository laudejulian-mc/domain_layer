import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  int _indexFromLocation(String loc) {
    if (loc.startsWith('/events')) return 1;
    if (loc.startsWith('/announcements')) return 2;
    if (loc.startsWith('/club-info')) return 3;
    if (loc.startsWith('/profile')) return 4;
    return 0; // dashboard
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    final currentIndex = _indexFromLocation(location);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
        BottomNavigationBarItem(icon: Icon(Icons.announcement), label: 'Announcements'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Club Info'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (i) {
        switch (i) {
          case 0:
            context.go('/dashboard');
            break;
          case 1:
            context.go('/events');
            break;
          case 2:
            context.go('/announcements');
            break;
          case 3:
            context.go('/club-info');
            break;
          case 4:
            context.go('/profile');
            break;
        }
      },
    );
  }
}
