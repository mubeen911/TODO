class Model {
  String todoId;
  String description;
  String todo;
  bool isCompleted;
  String createdAt;
  String updatedAt;

  Model(
      {required this.description,
      required this.todoId,
      required this.todo,
      required this.isCompleted,
      required this.createdAt,
      required this.updatedAt});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      todoId: json['_id'],
      todo: json['todo'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
