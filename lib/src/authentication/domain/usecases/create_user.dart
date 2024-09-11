import 'package:tdd_tutorial/core/usecase/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(CreateUserParams params) async => _repository.createUser(
    createdAt: params.createAt,
    name: params.name,
    avatar: params.avatar,
  );
}

class CreateUserParams {
  const CreateUserParams({
    required this.createAt,
    required this.name,
    required this.avatar
  });

  const CreateUserParams.empty()
      : this(
          createAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.name'
      );

  final String createAt;
  final String name;
  final String avatar;
}