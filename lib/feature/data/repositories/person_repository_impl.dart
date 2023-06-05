import 'package:dartz/dartz.dart';
import 'package:therickandmorty/core/error/exception.dart';
import 'package:therickandmorty/core/error/failure.dart';
import 'package:therickandmorty/core/platform/network_info.dart';
import 'package:therickandmorty/feature/data/datasources/person_local_data_source.dart';
import 'package:therickandmorty/feature/data/datasources/person_remote_data_source.dart';
import 'package:therickandmorty/feature/domain/entities/person_entity.dart';
import 'package:therickandmorty/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await remoteDataSource.getAllPersons(page);
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await remoteDataSource.searchPerson(query);
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
