import 'package:equatable/equatable.dart';
import 'schedule.dart';

class Event extends Equatable {
	final String id;
	final String title;
	final String? description;
	final DateTime startAt;
	final DateTime? endAt;
	final List<Schedule>? schedule;

	const Event({
		required this.id,
		required this.title,
		this.description,
		required this.startAt,
		this.endAt,
		this.schedule,
	});

	@override
	List<Object?> get props => [id, title, description, startAt, endAt, schedule];
}
