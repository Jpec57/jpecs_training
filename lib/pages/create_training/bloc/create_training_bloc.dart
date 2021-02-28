import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_training_event.dart';
part 'create_training_state.dart';

class CreateTrainingBloc extends Bloc<CreateTrainingEvent, CreateTrainingState> {
  CreateTrainingBloc() : super(CreateTrainingInitial());

  @override
  Stream<CreateTrainingState> mapEventToState(
    CreateTrainingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
