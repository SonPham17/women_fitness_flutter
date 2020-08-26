// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionHistoryAdapter extends TypeAdapter<SectionHistory> {
  @override
  final int typeId = 1;

  @override
  SectionHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionHistory(
      totalTime: fields[0] as int,
      sectionId: fields[1] as int,
      calories: fields[2] as double,
      day: fields[3] as String,
      timeFinish: fields[4] as String,
      thumb: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SectionHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.totalTime)
      ..writeByte(1)
      ..write(obj.sectionId)
      ..writeByte(2)
      ..write(obj.calories)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.timeFinish)
      ..writeByte(5)
      ..write(obj.thumb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
