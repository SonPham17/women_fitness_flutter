// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iap_fitness.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IAPFitnessAdapter extends TypeAdapter<IAPFitness> {
  @override
  final int typeId = 3;

  @override
  IAPFitness read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IAPFitness(
      idIAP: fields[0] as String,
      isBuy: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IAPFitness obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.idIAP)
      ..writeByte(1)
      ..write(obj.isBuy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IAPFitnessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
