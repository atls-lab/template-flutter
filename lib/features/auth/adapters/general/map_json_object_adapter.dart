import 'package:built_value/json_object.dart';
import 'package:hive/hive.dart';

class MapJsonObjectAdapter extends TypeAdapter<MapJsonObject> {
  @override
  MapJsonObject read(BinaryReader reader) {
    return MapJsonObject(reader.read());
  }

  @override
  final typeId = 14;

  @override
  void write(BinaryWriter writer, MapJsonObject obj) {
    writer
      ..write(obj.value)
      ..write(obj.asList)
      ..write(obj.asMap);
  }
}
