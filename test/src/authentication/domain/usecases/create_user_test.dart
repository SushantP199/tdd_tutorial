// On what testing class depends (ans: AuthenticationRepository)
// what is required to create fake dependency (ans: using package mocktail)
// how it is created (ans: extending with mocktail and implementing AuthRepo)

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domain/usecases/create_user.dart';
import 'authentication_repository.mock.dart';


void main() {
  late AuthenticationRepository repository;
  late CreateUser usecase;

  setUp((){
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test(
      'should call the [AuthRepo.createUser]',
      () async {
        // Arrange
        // STUB
        when(()=> repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')
        )).thenAnswer((_) async => const Right(null));

        // Act
        final result = await usecase(params);

        // Assert
        expect(result, equals(const Right<dynamic, void>(null)));

        verify(()=> repository.createUser(
            createdAt: params.createAt,
            name: params.name,
            avatar: params.avatar
        )).called(1);

        verifyNoMoreInteractions(repository);
      }
  );
}