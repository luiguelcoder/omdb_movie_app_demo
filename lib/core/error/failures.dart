import 'package:equatable/equatable.dart';

/// Abstract class representing a failure.
/// All specific failure types should extend this class.
abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Represents a server-related failure, such as a 500 response.
class ServerFailure extends Failure {}
