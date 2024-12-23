// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelClassAdapter extends TypeAdapter<ModelClass> {
  @override
  final int typeId = 0;

  @override
  ModelClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelClass(
      title: fields[0] as String,
      subTitle: fields[1] as String,
      val: fields[2]as bool
    );
  }

  @override
  void write(BinaryWriter writer, ModelClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.val);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
