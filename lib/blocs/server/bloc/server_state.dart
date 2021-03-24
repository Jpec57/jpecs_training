import 'package:equatable/equatable.dart';

class ServerState extends Equatable {
  final int? code;
  final String? message;

  const ServerState({this.code, this.message});

  @override
  List<Object?> get props => [code, message];

  bool get hasError => code != null && code! >= 400;
}
