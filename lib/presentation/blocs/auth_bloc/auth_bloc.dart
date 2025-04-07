import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omdb_movie_app/domain/entities/sign_in_params.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';
import 'package:omdb_movie_app/domain/usecases/sign_in_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Use case for signing in a user
  final SignInUser signInUser;

  /// Constructor for initializing the `AuthBloc` with required dependencies.
  /// The `super` call sets the initial state to `AuthInitial`.
  AuthBloc({required this.signInUser}) : super(AuthInitial()) {
    // Event handler for `SignInEvent`.
    // Triggered when the user initiates a sign-in process.
    on<SignInEvent>((event, emit) async {
      // Emit the `AuthLoading` state to indicate loading in progress.
      emit(AuthLoading());

      final signInParams = SignInParams(
        email: event.email,
        password: event.password,
      );

      // Execute the `signInUser` use case with the signIn parameters.
      final result = await signInUser(signInParams);

      // Handle the result using the `fold` method:
      // - On failure, emit a `AuthError` state with an error message.
      // - On success, emit a `AuthSuccess` state with the user data.
      result.fold(
        (failure) => emit(AuthError('Sign In Failed')),
        (user) => emit(AuthSucess(user)),
      );
    });
  }
}
