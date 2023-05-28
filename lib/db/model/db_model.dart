import 'package:hive_flutter/hive_flutter.dart';

part 'db_model.g.dart';

@HiveType(typeId: 1)
class StudentDetiles {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final String name;

  @HiveField(3)
  final String place;

  @HiveField(4)
  final String age;
  @HiveField(5)
  final String number;

  StudentDetiles(
      {required this.name,
      required this.place,
      required this.age,
      required this.number,
      required this.image,
      this.id});
}
