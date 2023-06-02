import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:therickandmorty/core/usecases/usecase.dart';
import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';
import '../repositories/person_repository.dart';

// get data and send to presentation
class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}