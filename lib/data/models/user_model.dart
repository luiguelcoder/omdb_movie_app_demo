import '../../domain/entities/user.dart';

/// Model representing a movie fetched from the OMDb API.
/// Extends the core Movie entity and includes JSON parsing methods.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });
}
