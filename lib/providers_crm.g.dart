// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers_crm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 0;

  @override
  Client read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Client(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String?,
      company: fields[5] as String?,
      position: fields[6] as String?,
      status: fields[7] as ClientStatus,
      source: fields[8] as ClientSource,
      createdAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.company)
      ..writeByte(6)
      ..write(obj.position)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.source)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClientStatusAdapter extends TypeAdapter<ClientStatus> {
  @override
  final int typeId = 1;

  @override
  ClientStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClientStatus.lead;
      case 1:
        return ClientStatus.prospect;
      case 2:
        return ClientStatus.active;
      case 3:
        return ClientStatus.inactive;
      default:
        return ClientStatus.lead;
    }
  }

  @override
  void write(BinaryWriter writer, ClientStatus obj) {
    switch (obj) {
      case ClientStatus.lead:
        writer.writeByte(0);
        break;
      case ClientStatus.prospect:
        writer.writeByte(1);
        break;
      case ClientStatus.active:
        writer.writeByte(2);
        break;
      case ClientStatus.inactive:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClientSourceAdapter extends TypeAdapter<ClientSource> {
  @override
  final int typeId = 2;

  @override
  ClientSource read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClientSource.website;
      case 1:
        return ClientSource.referral;
      case 2:
        return ClientSource.coldCall;
      case 3:
        return ClientSource.email;
      case 4:
        return ClientSource.socialMedia;
      case 5:
        return ClientSource.event;
      case 6:
        return ClientSource.advertisement;
      case 7:
        return ClientSource.partner;
      case 8:
        return ClientSource.other;
      default:
        return ClientSource.website;
    }
  }

  @override
  void write(BinaryWriter writer, ClientSource obj) {
    switch (obj) {
      case ClientSource.website:
        writer.writeByte(0);
        break;
      case ClientSource.referral:
        writer.writeByte(1);
        break;
      case ClientSource.coldCall:
        writer.writeByte(2);
        break;
      case ClientSource.email:
        writer.writeByte(3);
        break;
      case ClientSource.socialMedia:
        writer.writeByte(4);
        break;
      case ClientSource.event:
        writer.writeByte(5);
        break;
      case ClientSource.advertisement:
        writer.writeByte(6);
        break;
      case ClientSource.partner:
        writer.writeByte(7);
        break;
      case ClientSource.other:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
