import '/flutter_flow/flutter_flow_util.dart';
import 'add_device_page_widget.dart' show AddDevicePageWidget;
import 'package:flutter/material.dart';
import '../backend/schema/structs/antimoustique_struct.dart';


class AddDevicePageModel extends FlutterFlowModel<AddDevicePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  var deviceManufactureID = '';
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  AntimoustiqueStruct? _antimoustique; // Déclaration de la propriété antimoustique
  FFAppState? _appState; // Déclaration de la propriété appState

  // Getter pour antimoustique
  AntimoustiqueStruct? get antimoustique => _antimoustique;

  // Setter pour antimoustique
  set antimoustique(AntimoustiqueStruct? value) {
    _antimoustique = value;
  }

  // Getter pour appState
  FFAppState? get appState => _appState;

  // Setter pour appState
  set appState(FFAppState? value) {
    _appState = value;
  }

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
