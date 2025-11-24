import 'seed_users.dart' as users;
import 'seed_club_info.dart' as club;
import 'seed_events.dart' as events;

Future<void> main() async {
  print('Starting full seeding process...');
  await users.main();
  await club.main();
  await events.main();
  print('Full seeding complete.');
}
