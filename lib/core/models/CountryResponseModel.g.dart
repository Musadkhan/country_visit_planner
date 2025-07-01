// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CountryResponseModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryResponseModelAdapter extends TypeAdapter<CountryResponseModel> {
  @override
  final int typeId = 0;

  @override
  CountryResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryResponseModel(
      name: fields[0] as String,
      officialName: fields[1] as String,
      nativeName: fields[2] as String?,
      capital: fields[3] as String,
      region: fields[4] as String,
      flagUrl: fields[5] as String,
      currencyName: fields[6] as String,
      currencySymbol: fields[7] as String,
      phoneCode: fields[8] as String,
      area: fields[9] as double,
      population: fields[10] as int,
      lat: fields[11] as double,
      lng: fields[12] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CountryResponseModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.officialName)
      ..writeByte(2)
      ..write(obj.nativeName)
      ..writeByte(3)
      ..write(obj.capital)
      ..writeByte(4)
      ..write(obj.region)
      ..writeByte(5)
      ..write(obj.flagUrl)
      ..writeByte(6)
      ..write(obj.currencyName)
      ..writeByte(7)
      ..write(obj.currencySymbol)
      ..writeByte(8)
      ..write(obj.phoneCode)
      ..writeByte(9)
      ..write(obj.area)
      ..writeByte(10)
      ..write(obj.population)
      ..writeByte(11)
      ..write(obj.lat)
      ..writeByte(12)
      ..write(obj.lng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
