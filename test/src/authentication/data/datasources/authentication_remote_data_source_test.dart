import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_tutorial/core/constants.dart';
import 'package:tdd_tutorial/core/errors/exception.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when status code is 200 or 201',
        () async {
      // Arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response('User created successfully', 201),
      );

      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      // Act
      final methodCall = remoteDataSource.createUser;

      // Assert
      expect(
        methodCall(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when status code is not 200 or 201',
        () async {
      // Arrange
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => http.Response('Server error occurred', 400));

      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      // Act
      final methodCall = remoteDataSource.createUser;

      // Assert
      expect(
        () async => methodCall(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
        throwsA(isA<APIException>()),
      );

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];

    test('should return [List<User>] when status code is 200', () async {
      // Arrange
      when(
        () => client.get(
          any(),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode([tUsers.first.toMap()]),
          200,
        ),
      );

      // Act
      final result = await remoteDataSource.getUsers();

      // Assert
      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);

      verifyNoMoreInteractions(client);
    });

    test('should return [APIException] when status code is not 200', () async {
      // Arrange
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode('Server error occurred'), 500),
      );

      // Act
      final methodCall = remoteDataSource.getUsers;

      // Assert
      expect(
        () async => await methodCall(),
        throwsA(isA<APIException>()),
      );

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
