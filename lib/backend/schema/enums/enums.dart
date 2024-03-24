import 'package:collection/collection.dart';

enum DeviceState {
  DEVICE_ON,
  DEVICE_BOOST,
  DEVICE_OFF,
  DEVICE_UNDEFINED,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (DeviceState):
      return DeviceState.values.deserialize(value) as T?;
    default:
      return null;
  }
}
