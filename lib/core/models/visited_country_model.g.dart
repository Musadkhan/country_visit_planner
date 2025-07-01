// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visited_country_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitedCountryModelAdapter extends TypeAdapter<VisitedCountryModel> {
  @override
  final int typeId = 1;

  @override
  VisitedCountryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisitedCountryModel(
      name: fields[0] as String,
      flagUrl: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      visitedPlaces: fields[4] as String,
      cost: fields[5] as double,
      currency: fields[6] as String,
      satisfactionScore: fields[7] as int,
      region: fields[8] as String,
      population: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VisitedCountryModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.flagUrl)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.visitedPlaces)
      ..writeByte(5)
      ..write(obj.cost)
      ..writeByte(6)
      ..write(obj.currency)
      ..writeByte(7)
      ..write(obj.satisfactionScore)
      ..writeByte(8)
      ..write(obj.region)
      ..writeByte(9)
      ..write(obj.population);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitedCountryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
