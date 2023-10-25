import 'package:hive/hive.dart';
import 'package:ory_kratos_client/ory_kratos_client.dart';

class UIContainerAdapter extends TypeAdapter<UiContainer> {
  @override
  UiContainer read(BinaryReader reader) {
    return UiContainer(reader.read());
  }

  @override
  final typeId = 5;

  @override
  void write(BinaryWriter writer, UiContainer obj) {
    writer
      ..writeString(obj.method)
      ..writeString(obj.action)
      ..write(obj.messages)
      ..write(obj.nodes);
  }
}
