import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import '../../features/events/domain/usecases/event_usecases.dart';
import '../../features/events/domain/entities/event.dart';
import '../../core/errors/failure.dart';
import 'event_state.dart';

class EventNotifier extends StateNotifier<EventState> {
  final CreateEvent createEvent;
  final UpdateEvent updateEvent;
  final DeleteEvent deleteEvent;
  final GetEvents getEvents;
  final GetEventById getEventById;
  final PublishEvent publishEvent;
  final RSVPToEvent rsvpToEvent;
  final MarkAttendance markAttendance;

  EventNotifier({
    required this.createEvent,
    required this.updateEvent,
    required this.deleteEvent,
    required this.getEvents,
    required this.getEventById,
    required this.publishEvent,
    required this.rsvpToEvent,
    required this.markAttendance,
  }) : super(const EventState());

  Future<void> loadEvents() async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, List<EventEntity>> res = await getEvents.call();
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (list) {
      state = state.copyWith(status: EventStatus.loaded, events: list, errorMessage: null);
    });
  }

  Future<void> loadEventById(String id) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, EventEntity> res = await getEventById.call(id);
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (event) {
      state = state.copyWith(status: EventStatus.loaded, selectedEvent: event, errorMessage: null);
    });
  }

  // Other actions are provided but may be unimplemented depending on repository bridge
  Future<void> create(EventEntity event) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, EventEntity> res = await createEvent.call(event);
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (e) async {
      await loadEvents();
    });
  }

  Future<void> update(EventEntity event) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, EventEntity> res = await updateEvent.call(event);
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (e) async {
      await loadEvents();
    });
  }

  Future<void> delete(String eventId) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, void> res = await deleteEvent.call(eventId);
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (r) async {
      await loadEvents();
    });
  }

  Future<void> rsvp(String eventId, String userId, RSVPStatus status) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, EventEntity> res = await rsvpToEvent.call(eventId: eventId, userId: userId, status: status);
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (e) async {
      await loadEventById(eventId);
    });
  }

  Future<void> markAttendanceAction(String eventId, String userId, bool present) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    final Either<Failure, EventEntity> res = await markAttendance.call(eventId: eventId, userId: userId, present: present);
    res.fold((f) {
      state = state.copyWith(status: EventStatus.error, errorMessage: f.message);
    }, (e) async {
      await loadEventById(eventId);
    });
  }
}
