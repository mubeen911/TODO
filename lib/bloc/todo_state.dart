abstract class TodoState {

}
class Loading  extends TodoState{

}
class Loaded extends TodoState{
  final   List<String> tasks;
  Loaded(this.tasks);
}
