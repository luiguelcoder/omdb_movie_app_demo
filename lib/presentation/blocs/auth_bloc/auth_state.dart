part of 'auth_bloc.dart';

/// Base class for all states in the AuthBloc.
/// Extends `Equatable` to allow for efficient state comparison and re-rendering
/// only when the state changes.
abstract class AuthState extends Equatable {
  /// Override the `props` property to specify which fields are considered
  /// for equality comparison. By default, it returns an empty list.
  @override
  List<Object?> get props => [];
}

/// Initial state of the AuthBloc.
/// Represents the state when no action has been taken yet.
class AuthInitial extends AuthState {}

/// State emitted when a loading process is underway.
/// For example, when user authentication is in progress.
class AuthLoading extends AuthState {}

/// State emitted when a user is successfully signed in.
/// Holds a `user` field that contains the authenticated `User` entity.
class AuthSucess extends AuthState {
  // User entity representing the authenticated user.
  final User user;

  /// Constructor to initialize the state with a user
  AuthSucess(this.user);

  /// Override the `props` property to include the `user` field,
  /// ensuring equality is based on the content of the user.
  @override
  List<Object?> get props => [user];
}

/// State emitted when an error occurs during any authentication process.
/// Holds a `message` field that contains the error description.
class AuthError extends AuthState {
  // Error message describing the issue encountered.
  final String message;

  /// Constructor to initialize the state with an error message.
  AuthError(this.message);

  /// Override the `props` property to include the `message` field,
  /// ensuring equality is based on the content of the message.
  @override
  List<Object?> get props => [message];
}
