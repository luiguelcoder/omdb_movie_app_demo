part of 'auth_bloc.dart';

/// Base class for all events in the AuthBloc.
/// Extends the `Equatable` package for easy comparison of event instances.
/// This allows the Bloc to differentiate between events based on their properties.
abstract class AuthEvent extends Equatable {
  /// Override the `props` property to define which fields are considered
  /// for event comparison. By default, it returns an empty list.
  @override
  List<Object?> get props => [];
}

/// Event triggered when the user initiates a sign-in process.
/// This event contains the email and password provided by the user.
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  /// Constructor to initialize the `SignInEvent` with the user's email and password.
  SignInEvent(this.email, this.password);

  /// Override the `props` property to include the `email` and `password` fields.
  /// This ensures that events with the same query are considered equal.
  @override
  List<Object?> get props => [email, password];
}

/// Event triggered when the user initiates a sign out process.
class SignOutEvent extends AuthEvent {
  /// Constructor to initialize the `SignOutEvent`.
  SignOutEvent();
}

/// Event triggered when the app starts to check if the user is authenticated.
class IsAuthenticatedEvent extends AuthEvent {
  /// Constructor to initialize the `IsAuthenticatedEvent`.
  IsAuthenticatedEvent();
}
