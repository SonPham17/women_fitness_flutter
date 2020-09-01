// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admob_fitness.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdmobFitnessAdapter extends TypeAdapter<AdmobFitness> {
  @override
  final int typeId = 2;

  @override
  AdmobFitness read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdmobFitness(
      title: fields[0] as String,
      isLoaded: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AdmobFitness obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isLoaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdmobFitnessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
