import 'package:dartz/dartz.dart';
import '../entities/event.dart';
import '../../core/errors/failure.dart';
import '../repositories/event_repository.dart';

class EventUseCases {
	final EventRepository repository;

	EventUseCases(this.repository);

	Future<Either<Failure, List<Event>>> getAllEvents() async {
		return await repository.getEvents();
	}

	Future<Either<Failure, Event>> getEventById(String id) async {
		return await repository.getEventById(id);
	}
}
