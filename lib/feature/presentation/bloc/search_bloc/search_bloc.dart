import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therickandmorty/core/error/failure.dart';
import 'package:therickandmorty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:therickandmorty/feature/presentation/bloc/search_bloc/search_state.dart';
import '../../../domain/usecases/search_person.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPerson) {
      yield* _mapFetchPersonsToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson = await searchPerson(
      SearchPersonParams(query: personQuery),
    );

    yield failureOrPerson.fold(
      (failure) => PersonSearchError(
        message: _mapFailureToMessage(failure),
      ),
      (person) => PersonSearchLoaded(persons: person),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected error';
    }
  }
}
