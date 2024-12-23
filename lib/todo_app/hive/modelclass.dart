import 'package:hive/hive.dart';
part 'modelclass.g.dart';

@HiveType(typeId: 0)
class ModelClass extends HiveObject {
  @HiveField(0)
   String title;

  @HiveField(1)
   String subTitle;

  @HiveField(2)
   bool val;

  ModelClass({required this.title, required this.subTitle, required this.val});
}
