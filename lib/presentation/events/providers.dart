import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hoophub/data/datasources/event_remote_data_source_impl.dart';
import 'package:hoophub/data/repositories/event_repository_bridge.dart';
import 'package:hoophub/features/events/domain/usecases/event_usecases.dart';
import 'event_notifier.dart';
import 'event_state.dart';

// Firestore provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// Data source provider
final eventRemoteDataSourceProvider = Provider<EventRemoteDataSourceImpl>((ref) {
  return EventRemoteDataSourceImpl(firestore: ref.read(firestoreProvider));
});

// Repository bridge provider
final eventRepositoryProvider = Provider((ref) {
  return EventRepositoryBridge(ref.read(eventRemoteDataSourceProvider));
});

// Usecase providers
final createEventUseCaseProvider = Provider((ref) => CreateEvent(ref.read(eventRepositoryProvider)));
final updateEventUseCaseProvider = Provider((ref) => UpdateEvent(ref.read(eventRepositoryProvider)));
final deleteEventUseCaseProvider = Provider((ref) => DeleteEvent(ref.read(eventRepositoryProvider)));
final getEventsUseCaseProvider = Provider((ref) => GetEvents(ref.read(eventRepositoryProvider)));
final getEventByIdUseCaseProvider = Provider((ref) => GetEventById(ref.read(eventRepositoryProvider)));
final publishEventUseCaseProvider = Provider((ref) => PublishEvent(ref.read(eventRepositoryProvider)));
final rsvpToEventUseCaseProvider = Provider((ref) => RSVPToEvent(ref.read(eventRepositoryProvider)));
final markAttendanceUseCaseProvider = Provider((ref) => MarkAttendance(ref.read(eventRepositoryProvider)));

// EventNotifier provider
final eventNotifierProvider = StateNotifierProvider<EventNotifier, EventState>((ref) {
  return EventNotifier(
    createEvent: ref.read(createEventUseCaseProvider),
    updateEvent: ref.read(updateEventUseCaseProvider),
    deleteEvent: ref.read(deleteEventUseCaseProvider),
    getEvents: ref.read(getEventsUseCaseProvider),
    getEventById: ref.read(getEventByIdUseCaseProvider),
    publishEvent: ref.read(publishEventUseCaseProvider),
    rsvpToEvent: ref.read(rsvpToEventUseCaseProvider),
    markAttendance: ref.read(markAttendanceUseCaseProvider),
  );
});
