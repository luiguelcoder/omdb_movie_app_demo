import 'package:equatable/equatable.dart';

/// Entity representing a SignInParams.
/// This is the core representation of a SignInParams used in the SingIn process.
class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
