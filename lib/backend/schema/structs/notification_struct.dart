import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

enum NotificationType { co2Low, attractifLow }

class NotificationStruct extends BaseStruct {
  NotificationStruct({
    AntimoustiqueStruct? antimoustique,
    String? title,
    String? body,
    required this.type, // Directement initialisé ici
  })  : _antimoustique = antimoustique,
        _title = title,
        _body = body;

  // "antimoustique" field.
  AntimoustiqueStruct? _antimoustique;
  AntimoustiqueStruct get antimoustique =>
      _antimoustique ?? AntimoustiqueStruct();

  String? get message => null;
  set antimoustique(AntimoustiqueStruct? val) => _antimoustique = val;
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

  // "type" field.
  final NotificationType type; // Ajouté comme attribut final

  static NotificationStruct fromMap(Map<String, dynamic> data) =>
      NotificationStruct(
        antimoustique: AntimoustiqueStruct.maybeFromMap(data['antimoustique']),
        title: data['title'] as String?,
        body: data['body'] as String?,
        type: NotificationType.values[data['type']], // Conversion de l'index en type
      );

  Map<String, dynamic> toMap() => {
    'antimoustique': _antimoustique?.toMap(),
    'title': _title,
    'body': _body,
    'type': type.index, // Stockage de l'index du type pour la sérialisation
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
    'type': type.index, // Sérialisation du type
  }.withoutNulls;

// Méthode fromSerializableMap intégrée avec la gestion du type
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
        type: NotificationType.values[data['type']], // Conversion de l'index en NotificationType
      );

  @override
  String toString() => 'NotificationStruct(${toMap()})';

  @override
  bool operator ==(Object other) =>
      other is NotificationStruct &&
          antimoustique == other.antimoustique &&
          title == other.title &&
          body == other.body &&
          type == other.type;

  @override
  int get hashCode => const ListEquality().hash([antimoustique, title, body, type]);
}
