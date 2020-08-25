// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_week.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallengeWeekAdapter extends TypeAdapter<ChallengeWeek> {
  @override
  final int typeId = 0;

  @override
  ChallengeWeek read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChallengeWeek(
      idSection: fields[0] as int,
      title: fields[1] as String,
      index: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChallengeWeek obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.idSection)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeWeekAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
