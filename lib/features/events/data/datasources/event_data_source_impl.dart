import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_data_source.dart';
import '../../models/event_model.dart';

class EventDataSourceImpl implements EventDataSource {
  final FirebaseFirestore firestore;

  EventDataSourceImpl({required this.firestore});

  @override
  Future<List<EventModel>> getEvents() async {
    final snapshot = await firestore.collection('events').get();
    return snapshot.docs
        .map((doc) => EventModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EventModel> getEventById(String id) async {
    final doc = await firestore.collection('events').doc(id).get();
    return EventModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Future<void> createEvent(EventModel event) async {
    await firestore.collection('events').add(event.toJson());
  }

  @override
  Future<void> updateEvent(String id, EventModel event) async {
    await firestore.collection('events').doc(id).update(event.toJson());
  }

  @override
  Future<void> deleteEvent(String id) async {
    await firestore.collection('events').doc(id).delete();
  }
}