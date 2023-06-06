import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object?> get props => [];

  String get personQuery => personQuery;
}

class SearchPersons extends PersonSearchEvent {
  @override
  final String personQuery;

   const SearchPersons(this.personQuery);
}