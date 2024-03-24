import '/backend/schema/structs/index.dart';
import '/components/navigation_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'device_page_widget.dart' show DevicePageWidget;
import 'package:flutter/material.dart';

class DevicePageModel extends FlutterFlowModel<DevicePageWidget> {
  ///  Local state fields for this page.

  List<AntimoustiqueStruct> deviceList = [];
  void addToDeviceList(AntimoustiqueStruct item) => deviceList.add(item);
  void removeFromDeviceList(AntimoustiqueStruct item) =>
      deviceList.remove(item);
  void removeAtIndexFromDeviceList(int index) => deviceList.removeAt(index);
  void insertAtIndexInDeviceList(int index, AntimoustiqueStruct item) =>
      deviceList.insert(index, item);
  void updateDeviceListAtIndex(
          int index, Function(AntimoustiqueStruct) updateFn) =>
      deviceList[index] = updateFn(deviceList[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for navigationBar component.
  late NavigationBarModel navigationBarModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    navigationBarModel = createModel(context, () => NavigationBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navigationBarModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
