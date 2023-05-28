// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentDetilesAdapter extends TypeAdapter<StudentDetiles> {
  @override
  final int typeId = 1;

  @override
  StudentDetiles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentDetiles(
      name: fields[2] as String,
      place: fields[3] as String,
      age: fields[4] as String,
      number: fields[5] as String,
      image: fields[1] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentDetiles obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.place)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentDetilesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
