// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationStruct extends BaseStruct {
  NotificationStruct({
    AntimoustiqueStruct? antimoustique,
    String? title,
    String? body,
  })  : _antimoustique = antimoustique,
        _title = title,
        _body = body;

  // "antimoustique" field.
  AntimoustiqueStruct? _antimoustique;
  AntimoustiqueStruct get antimoustique =>
      _antimoustique ?? AntimoustiqueStruct();
  set antimoustique(AntimoustiqueStruct? val) => _antimoustique = val;
  void updateAntimoustique(Function(AntimoustiqueStruct) updateFn) =>
      updateFn(_antimoustique ??= AntimoustiqueStruct());
  bool hasAntimoustique() => _antimoustique != null;

  // "title" field.
  String? _title;
  String get title => _title ?? 'NomAppareil';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "body" field.
  String? _body;
  String get body => _body ?? '';
  set body(String? val) => _body = val;
  bool hasBody() => _body != null;

  static NotificationStruct fromMap(Map<String, dynamic> data) =>
      NotificationStruct(
        antimoustique: AntimoustiqueStruct.maybeFromMap(data['antimoustique']),
        title: data['title'] as String?,
        body: data['body'] as String?,
      );

  static NotificationStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'antimoustique': _antimoustique?.toMap(),
        'title': _title,
        'body': _body,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'antimoustique': serializeParam(
          _antimoustique,
          ParamType.DataStruct,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'body': serializeParam(
          _body,
          ParamType.String,
        ),
      }.withoutNulls;

  static NotificationStruct fromSerializableMap(Map<String, dynamic> data) =>
      NotificationStruct(
        antimoustique: deserializeStructParam(
          data['antimoustique'],
          ParamType.DataStruct,
          false,
          structBuilder: AntimoustiqueStruct.fromSerializableMap,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        body: deserializeParam(
          data['body'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NotificationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NotificationStruct &&
        antimoustique == other.antimoustique &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode => const ListEquality().hash([antimoustique, title, body]);
}

NotificationStruct createNotificationStruct({
  AntimoustiqueStruct? antimoustique,
  String? title,
  String? body,
}) =>
    NotificationStruct(
      antimoustique: antimoustique ?? AntimoustiqueStruct(),
      title: title,
      body: body,
    );
