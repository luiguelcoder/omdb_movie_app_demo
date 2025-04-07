import 'package:equatable/equatable.dart';

/// Entity representing a user.
/// This is the core representation of a user used throughout the app.
class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}
