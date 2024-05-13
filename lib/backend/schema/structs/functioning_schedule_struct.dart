// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:anti_moustique/custom_code/actions/utils.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

enum DayOfWeek { lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche }

class FunctioningScheduleStruct extends BaseStruct {
  FunctioningScheduleStruct({
    DateTime? startDay,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? isReccurent,
    List<DayOfWeek>? days,
  })  : _startDay = startDay,
        _startTime = startTime,
        _endTime = endTime,
        _isReccurent = isReccurent,
        _days = days;

  // "startDay" field.
  DateTime? _startDay;
  DateTime? get startDay => _startDay;

  get isPeriodic => null;
  set startDay(DateTime? val) => _startDay = val;
  bool hasStartDay() => _startDay != null;

  // "startTime" field.
  TimeOfDay? _startTime;
  TimeOfDay? get startTime => _startTime;
  set startTime(TimeOfDay? val) => _startTime = val;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  TimeOfDay? _endTime;
  TimeOfDay? get endTime => _endTime;
  set endTime(TimeOfDay? val) => _endTime = val;
  bool hasEndTime() => _endTime != null;

  // "isReccurent" field.
  bool? _isReccurent;
  bool get isReccurent => _isReccurent ?? false;
  set isReccurent(bool? val) => _isReccurent = val;
  bool hasIsReccurent() => _isReccurent != null;

  List<DayOfWeek>? _days;
  List<DayOfWeek> get days => _days ?? [];
  set days(List<DayOfWeek>? val) => _days = val;
  bool hasDays() => _days != null;

  static FunctioningScheduleStruct fromMap(Map<String, dynamic> data) => FunctioningScheduleStruct(
        startDay: data['startDay'] as DateTime?,
        startTime: data['startTime'] as TimeOfDay?,
        endTime: data['endTime'] as TimeOfDay?,
        isReccurent: data['isReccurent'] as bool?,
      );

  static FunctioningScheduleStruct? maybeFromMap(dynamic data) =>
      data is Map ? FunctioningScheduleStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'startDay': _startDay,
        'startTime': _startTime,
        'endTime': _endTime,
        'isReccurent': _isReccurent,
        'days': _days,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() {
    // Utility function to format DateTime objects safely.
    String? formatDate(DateTime? date, String pattern) {
      if (date == null) return null;
      return DateFormat(pattern).format(date);
    }

    // Utility function to convert list of DayOfWeek to serializable format.
    List<String>? serializeDays(List<DayOfWeek>? days) {
      return days?.map((day) => day.toString().split('.').last).toList();
    }

    // Constructing the map with appropriate formatting and handling null values.
    return {
      'startDay': _startDay != null ? formatDate(_startDay, 'yyyy-MM-dd') : null,
      'startTime': formatTimeOfDay(_startTime!) ,
      'endTime': formatTimeOfDay(_endTime!),
      'isReccurent': serializeParam(_isReccurent, ParamType.bool),
      'days': serializeDays(_days),
    };
  }

  static FunctioningScheduleStruct fromSerializableMap(Map<String, dynamic> data) {

    List<DayOfWeek>? days = [];

    for(String day in data['days'] as List<String>) {
      days.add(DayOfWeek.values.byName(day));
    }
    TimeOfDay? parseTimeOfDay(String? time) {
      if (time == null) return null;
      List<String> parts = time.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    return FunctioningScheduleStruct(
      startDay: data['startDay'] != null ? DateTime.parse(data['startDay'] as String) : null,
      startTime: parseTimeOfDay(data['startTime'] as String?),
      endTime: parseTimeOfDay(data['endTime'] as String?),
      isReccurent: deserializeParam(
        data['isReccurent'],
        ParamType.bool,
        false,
      ),
      days: days,
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
  int get hashCode => const ListEquality().hash([startDay, startTime, endTime, isReccurent]);
}

FunctioningScheduleStruct createFunctioningScheduleStruct({
  DateTime? startDay,
  TimeOfDay? startTime,
  TimeOfDay? endTime,
  bool? isReccurent,
  List<DayOfWeek>? days,
}) =>
    FunctioningScheduleStruct(
      startDay: startDay,
      startTime: startTime,
      endTime: endTime,
      isReccurent: isReccurent,
      days: days,
    );
