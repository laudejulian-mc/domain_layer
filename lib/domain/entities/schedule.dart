import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
	final String id;
	final DateTime startAt;
	final DateTime endAt;
	final String location;

	const Schedule({
		required this.id,
		required this.startAt,
		required this.endAt,
		required this.location,
	});

	@override
	List<Object?> get props => [id, startAt, endAt, location];
}
