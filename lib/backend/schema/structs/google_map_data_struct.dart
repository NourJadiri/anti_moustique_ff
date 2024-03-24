// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GoogleMapDataStruct extends BaseStruct {
  GoogleMapDataStruct({
    LatLng? latLng,
    String? iconPath,
    String? title,
    String? description,
  })  : _latLng = latLng,
        _iconPath = iconPath,
        _title = title,
        _description = description;

  // "lat_lng" field.
  LatLng? _latLng;
  LatLng? get latLng => _latLng;
  set latLng(LatLng? val) => _latLng = val;
  bool hasLatLng() => _latLng != null;

  // "iconPath" field.
  String? _iconPath;
  String get iconPath => _iconPath ?? '';
  set iconPath(String? val) => _iconPath = val;
  bool hasIconPath() => _iconPath != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  static GoogleMapDataStruct fromMap(Map<String, dynamic> data) =>
      GoogleMapDataStruct(
        latLng: data['lat_lng'] as LatLng?,
        iconPath: data['iconPath'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
      );

  static GoogleMapDataStruct? maybeFromMap(dynamic data) => data is Map
      ? GoogleMapDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'lat_lng': _latLng,
        'iconPath': _iconPath,
        'title': _title,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'lat_lng': serializeParam(
          _latLng,
          ParamType.LatLng,
        ),
        'iconPath': serializeParam(
          _iconPath,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static GoogleMapDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      GoogleMapDataStruct(
        latLng: deserializeParam(
          data['lat_lng'],
          ParamType.LatLng,
          false,
        ),
        iconPath: deserializeParam(
          data['iconPath'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GoogleMapDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GoogleMapDataStruct &&
        latLng == other.latLng &&
        iconPath == other.iconPath &&
        title == other.title &&
        description == other.description;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([latLng, iconPath, title, description]);
}

GoogleMapDataStruct createGoogleMapDataStruct({
  LatLng? latLng,
  String? iconPath,
  String? title,
  String? description,
}) =>
    GoogleMapDataStruct(
      latLng: latLng,
      iconPath: iconPath,
      title: title,
      description: description,
    );
