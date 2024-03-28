import '/flutter_flow/flutter_flow_util.dart';
import 'add_device_page_widget.dart' show AddDevicePageWidget;
import 'package:flutter/material.dart';

class AddDevicePageModel extends FlutterFlowModel<AddDevicePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  var deviceInfo = '';
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  get appState => null;

  get antimoustique => null;

  set antimoustique(antimoustique) {}

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
