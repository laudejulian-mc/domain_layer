import 'package:equatable/equatable.dart';
import '../../features/events/domain/entities/event.dart';

enum EventStatus { initial, loading, loaded, error }

class EventState extends Equatable {
  final EventStatus status;
  final List<EventEntity> events;
  final EventEntity? selectedEvent;
  final String? errorMessage;

  const EventState({
    this.status = EventStatus.initial,
    this.events = const [],
    this.selectedEvent,
    this.errorMessage,
  });

  EventState copyWith({
    EventStatus? status,
    List<EventEntity>? events,
    EventEntity? selectedEvent,
    String? errorMessage,
  }) {
    return EventState(
      status: status ?? this.status,
      events: events ?? this.events,
      selectedEvent: selectedEvent ?? this.selectedEvent,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, events, selectedEvent, errorMessage];
}
