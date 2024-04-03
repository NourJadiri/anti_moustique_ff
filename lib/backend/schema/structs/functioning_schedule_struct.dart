// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FunctioningScheduleStruct extends BaseStruct {
  FunctioningScheduleStruct({
    DateTime? startDay,
    DateTime? startTime,
    DateTime? endTime,
    bool? isReccurent,
  })  : _startDay = startDay,
        _startTime = startTime,
        _endTime = endTime,
        _isReccurent = isReccurent;

  // "startDay" field.
  DateTime? _startDay;
  DateTime? get startDay => _startDay;

  get isPeriodic => null;
  set startDay(DateTime? val) => _startDay = val;
  bool hasStartDay() => _startDay != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  set startTime(DateTime? val) => _startTime = val;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  set endTime(DateTime? val) => _endTime = val;
  bool hasEndTime() => _endTime != null;

  // "isReccurent" field.
  bool? _isReccurent;
  bool get isReccurent => _isReccurent ?? false;
  set isReccurent(bool? val) => _isReccurent = val;
  bool hasIsReccurent() => _isReccurent != null;

  static FunctioningScheduleStruct fromMap(Map<String, dynamic> data) =>
      FunctioningScheduleStruct(
        startDay: data['startDay'] as DateTime?,
        startTime: data['startTime'] as DateTime?,
        endTime: data['endTime'] as DateTime?,
        isReccurent: data['isReccurent'] as bool?,
      );

  static FunctioningScheduleStruct? maybeFromMap(dynamic data) => data is Map
      ? FunctioningScheduleStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
    'startDay': _startDay,
    'startTime': _startTime,
    'endTime': _endTime,
    'isReccurent': _isReccurent,
  }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
    'startDay': DateFormat('yyyy-MM-dd').format(_startDay!),
    'startTime': DateFormat('HH:mm').format(_startTime!),
    'endTime': DateFormat('HH:mm').format(_endTime!),
    'isReccurent': serializeParam(
      _isReccurent,
      ParamType.bool,
    ),
  }.withoutNulls;

  static FunctioningScheduleStruct fromSerializableMap(
      Map<String, dynamic> data) {
    return FunctioningScheduleStruct(
      startDay: data['startDay'] != null
          ? DateTime.parse(data['startDay'] as String)
          : null,
      startTime: data['startTime'] != null
          ? DateTime.parse(data['startTime'] as String)
          : null,
      endTime: data['endTime'] != null
          ? DateTime.parse(data['endTime'] as String)
          : null,
      isReccurent: deserializeParam(
        data['isReccurent'],
        ParamType.bool,
        false,
      ),
    );
  }

  @override
  String toString() => 'FunctioningScheduleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FunctioningScheduleStruct &&
        startDay == other.startDay &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        isReccurent == other.isReccurent;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([startDay, startTime, endTime, isReccurent]);
}

FunctioningScheduleStruct createFunctioningScheduleStruct({
  DateTime? startDay,
  DateTime? startTime,
  DateTime? endTime,
  bool? isReccurent,
}) =>
    FunctioningScheduleStruct(
      startDay: startDay,
      startTime: startTime,
      endTime: endTime,
      isReccurent: isReccurent,
    );