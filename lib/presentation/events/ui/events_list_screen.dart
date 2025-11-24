import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hoophub/presentation/core/bottom_navigation.dart';

import '../event_state.dart';
import '../event_notifier.dart';
import '../providers.dart';
import '../../../features/events/domain/entities/event.dart';

class EventsListScreen extends ConsumerStatefulWidget {
  const EventsListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends ConsumerState<EventsListScreen> {
  @override
  void initState() {
    super.initState();
    // load events on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventNotifierProvider.notifier).loadEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      bottomNavigationBar: const BottomNavigation(),
      body: RefreshIndicator(
        onRefresh: () async => ref.read(eventNotifierProvider.notifier).loadEvents(),
        child: Builder(builder: (context) {
          if (state.status == EventStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == EventStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'Error loading events'));
          }

          final events = state.events;
          if (events.isEmpty) {
            return const Center(child: Text('No events')); 
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: events.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final e = events[index];
              return Card(
                child: ListTile(
                  title: Text(e.title),
                  subtitle: Text('${e.start.toLocal()} • ${e.venue}'),
                  trailing: e.isPublished ? const Icon(Icons.public) : const Icon(Icons.lock_outline),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: e.id)));
                  },
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EventFormScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Forward declarations to avoid import cycles
class EventDetailScreen extends ConsumerStatefulWidget {
  final String eventId;
  const EventDetailScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(eventNotifierProvider.notifier).loadEventById(widget.eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventNotifierProvider);
    final event = state.selectedEvent;

    return Scaffold(
      appBar: AppBar(title: const Text('Event Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: event == null
            ? const Center(child: Text('Event not found'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(event.description ?? '', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  Text('When: ${event.start.toLocal()}'),
                  if (event.end != null) Text('Ends: ${event.end!.toLocal()}'),
                  const SizedBox(height: 8),
                  Text('Venue: ${event.venue}'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // RSVP as 'yes' for demo; in real app choose status
                          ref.read(eventNotifierProvider.notifier).rsvp(event.id, 'currentUserId', RSVPStatus.yes);
                        },
                        child: const Text('RSVP Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(eventNotifierProvider.notifier).markAttendanceAction(event.id, 'currentUserId', true);
                        },
                        child: const Text('Mark Present'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => EventFormScreen(event: event)));
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

class EventFormScreen extends ConsumerStatefulWidget {
  final EventEntity? event;
  const EventFormScreen({Key? key, this.event}) : super(key: key);

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(eventNotifierProvider.notifier);
    final isEditing = widget.event != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Event' : 'Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderTextField(name: 'title', decoration: const InputDecoration(labelText: 'Title'), initialValue: widget.event?.title ?? '', validator: FormBuilderValidators.required()),
                const SizedBox(height: 12),
                FormBuilderTextField(name: 'description', decoration: const InputDecoration(labelText: 'Description'), initialValue: widget.event?.description ?? ''),
                const SizedBox(height: 12),
                FormBuilderDropdown<EventType>(
                  name: 'type',
                  decoration: const InputDecoration(labelText: 'Type'),
                  initialValue: widget.event?.type ?? EventType.practice,
                  items: EventType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.toString().split('.').last))).toList(),
                ),
                const SizedBox(height: 12),
                FormBuilderDateTimePicker(name: 'start', decoration: const InputDecoration(labelText: 'Start'), initialValue: widget.event?.start ?? DateTime.now()),
                const SizedBox(height: 12),
                FormBuilderDateTimePicker(name: 'end', decoration: const InputDecoration(labelText: 'End'), initialValue: widget.event?.end),
                const SizedBox(height: 12),
                FormBuilderTextField(name: 'venue', decoration: const InputDecoration(labelText: 'Venue'), initialValue: widget.event?.venue ?? ''),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final v = _formKey.currentState!.value;
                      final newEvent = EventEntity(
                        id: widget.event?.id ?? UniqueKey().toString(),
                        title: v['title'] as String,
                        description: v['description'] as String?,
                        type: v['type'] as EventType,
                        start: v['start'] as DateTime,
                        end: v['end'] as DateTime?,
                        venue: v['venue'] as String? ?? '',
                        organizerId: 'currentUserId',
                      );

                      if (isEditing) {
                        notifier.update(newEvent);
                      } else {
                        notifier.create(newEvent);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEditing ? 'Save' : 'Create'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
