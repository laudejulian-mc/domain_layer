import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:hoophub/presentation/membership/providers.dart';
import 'package:hoophub/presentation/membership/ui/login_screen.dart';
import 'package:hoophub/presentation/membership/ui/register_screen.dart';
import 'package:hoophub/presentation/membership/ui/profile_screen.dart';
import 'package:hoophub/presentation/core/dashboard_screen.dart';
import 'package:hoophub/presentation/membership/ui/members_list_screen.dart';
import 'package:hoophub/presentation/membership/ui/member_detail_screen.dart';
import 'package:hoophub/presentation/membership/membership_state.dart';
import 'package:hoophub/domain/entities/user.dart';
import 'package:hoophub/presentation/events/ui/events_list_screen.dart';
import 'package:hoophub/presentation/announcements/ui/announcements_list_screen.dart';
import 'package:hoophub/presentation/announcements/ui/announcement_detail_screen.dart';
import 'package:hoophub/presentation/announcements/ui/create_announcement_screen.dart';
import 'package:hoophub/presentation/club_info/ui/club_info_screen.dart';
import 'package:hoophub/presentation/club_info/ui/edit_club_info_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(membershipNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/members',
        name: 'members',
        builder: (context, state) => const MembersListScreen(),
      ),
      GoRoute(
        path: '/member/:id',
        name: 'memberDetail',
        builder: (context, state) {
          final id = state.params['id']!;
          return MemberDetailScreen(memberId: id);
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/events',
        name: 'events',
        builder: (context, state) => const EventsListScreen(),
      ),
      GoRoute(
        path: '/event/:id',
        name: 'eventDetail',
        builder: (context, state) {
          final id = state.params['id']!;
          return EventDetailScreen(eventId: id);
        },
      ),
      GoRoute(
        path: '/event/create',
        name: 'eventCreate',
        builder: (context, state) => const EventFormScreen(),
      ),
      GoRoute(
        path: '/event/edit/:id',
        name: 'eventEdit',
        builder: (context, state) {
          // event id param available; EventFormScreen currently takes an EventEntity optionally
          // we'll return the form and the notifier can load the selected event by id if needed
          return const EventFormScreen();
        },
      ),
      // Root -> dashboard if authenticated, otherwise login
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      // Announcements
      GoRoute(
        path: '/announcements',
        name: 'announcements',
        builder: (context, state) => const AnnouncementsListScreen(),
      ),
      GoRoute(
        path: '/announcement/:id',
        name: 'announcementDetail',
        builder: (context, state) {
          final id = state.params['id']!;
          return AnnouncementDetailScreen(id: id);
        },
      ),
      GoRoute(
        path: '/announcement/create',
        name: 'announcementCreate',
        builder: (context, state) => const CreateAnnouncementScreen(),
      ),
      // Club Info
      GoRoute(
        path: '/club-info',
        name: 'clubInfo',
        builder: (context, state) => const ClubInfoScreen(),
      ),
      GoRoute(
        path: '/club-info/edit',
        name: 'clubInfoEdit',
        builder: (context, state) => const EditClubInfoScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.status == MembershipStatus.authenticated && authState.currentUser != null;
      final loggingIn = state.subloc == '/login' || state.subloc == '/register';

      // If not logged in, send to login for protected routes
      final protectedPaths = ['/dashboard', '/profile', '/members', '/member', '/events', '/event', '/announcements', '/announcement'];

      if (!isLoggedIn) {
        if (loggingIn) return null;
        // allow access to root and register/login only
        return '/login';
      }

      // If logged in and visiting auth pages, go to dashboard
      if (isLoggedIn && loggingIn) return '/dashboard';

      // Organizer-only routes
      final isOrganizerOnly = state.subloc.startsWith('/members') || state.subloc.startsWith('/member') || state.subloc.startsWith('/event/create') || state.subloc.startsWith('/event/edit') || state.subloc.startsWith('/announcement/create');
      final role = authState.currentUser?.role;
      if (isOrganizerOnly && role != UserRole.admin) {
        return '/dashboard';
      }

      return null;
    },
  );
});
