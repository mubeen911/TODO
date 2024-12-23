import 'package:bloc/bloc.dart';
import 'package:todo/bloc/todo_events.dart';
import 'package:todo/bloc/todo_state.dart';

class TodoBloc  extends Bloc<TodoEvents, TodoState> {
  TodoBloc():super(Loading()) {
    
    throw UnimplementedError();
  }

}

