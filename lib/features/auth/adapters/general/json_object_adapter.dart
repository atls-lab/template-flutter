import 'package:built_value/json_object.dart';
import 'package:hive/hive.dart';

class JsonObjectAdapter extends TypeAdapter<JsonObject> {
  @override
  JsonObject read(BinaryReader reader) {
    return JsonObject(reader.read());
  }

  @override
  final typeId = 22;

  @override
  void write(BinaryWriter writer, JsonObject obj) {
    writer
      ..write<Object>(obj.value)
      ..write<List<dynamic>>(obj.asList)
      ..write(obj.asString)
      ..write(obj.asMap);
  }
}
