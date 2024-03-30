import 'package:anti_moustique/custom_code/actions/bluetooth_actions.dart';
import 'package:anti_moustique/custom_code/actions/device_utilities.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../backend/schema/structs/antimoustique_struct.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'add_device_page_model.dart';
export 'add_device_page_model.dart';
// ignore: unused_import
import '../app_state.dart';

class AddDevicePageWidget extends StatefulWidget {
  const AddDevicePageWidget({super.key});

  @override
  State<AddDevicePageWidget> createState() => _AddDevicePageWidgetState();
}

class _AddDevicePageWidgetState extends State<AddDevicePageWidget> {
  late AddDevicePageModel _model;

  bool _deviceScanned = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddDevicePageModel());

    _model.textController ??= TextEditingController(text: 'Borne');
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _scanQR(BuildContext context) async {
    var qrData = await scanQR(context);

    if (qrData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la lecture du QR code'),
        ),
      );
      return;
    }

    await BluetoothActions.scanForDevice(
        manufactureID: qrData['manufactureID']);

    if (FlutterBluePlus.lastScanResults.isEmpty) {
      print('No devices found');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Aucun appareil trouvé, assurez-vous que l\'appareil est activé et qu\'il est à proximité'),
        ),
      );
      return;
    }

    BluetoothDevice device = FlutterBluePlus.lastScanResults
        .firstWhere(
          (scanResult) =>
              scanResult.device.advName.toString() == qrData['manufactureID'],
        )
        .device;

    // TODO : Lire les caractéristiques de la device pour avoir le niveau de CO2 et d'attractif et l'état (ON/OFF)
    AntimoustiqueStruct newAntiMoustique = AntimoustiqueStruct(
      manufactureID: qrData['manufactureID'],
      remoteID: device.remoteId.toString(),
      vendor: qrData['vendor'],
      device: device,
      isOn: true,
    );

    setState(() {
      _model.deviceManufactureID = newAntiMoustique.manufactureID;
      _model.antimoustique = newAntiMoustique;
      _deviceScanned = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 3.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Stack(
                            children: [
                              const Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: ReturnButton(),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Ajouter un appareil',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Text(
                    'QR-CODE',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).displaySmall.override(
                          fontFamily: 'Inter',
                          fontSize: 32.0,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    width: 368.0,
                    height: 198.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Icon(
                      Icons.qr_code_2_outlined,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 200.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: MediaQuery.sizeOf(context).height * 0.04,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: buildScanQRButton(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                  child: Container(
                    width: 270.0,
                    height: 63.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: DeviceNameTextFormField(model: _model),
                  ),
                ),
                Container(
                  width: 270.0,
                  height: 63.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        _model.deviceManufactureID,
                        'ID Borne',
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Container(
                    width: 270.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: FFButtonWidget(
                      onPressed: _model.antimoustique != null ? () async {
                        
                        if(_model.textController!.text.isNotEmpty){
                          _model.antimoustique!.name = _model.textController!.text;
                          FFAppState().update(() {
                            FFAppState().addToDeviceList(_model.antimoustique!);
                          },);
                          Navigator.pop(context);
                        }
                        // _model.appState!.addAntiMoustique(_model.antimoustique!);
                        // Navigator.pop(context);
                      } :() {},
                      text: 'Ajouter',
                      options: FFButtonOptions(
                        width: 270.0,
                        height: 63.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        color: FlutterFlowTheme.of(context).success,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                        elevation: 0.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FFButtonWidget buildScanQRButton(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        // Scanner QR code
        _scanQR(context);
      },
      text: 'Scanner',
      options: FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: 0.0,
        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
        elevation: 0.0,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(18.0),
      ),
    );
  }
}

class ConfirmAddDeviceButton extends StatelessWidget {
  const ConfirmAddDeviceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        // Ajouter l'appareil
        // _model.appState!.addAntiMoustique(_model.antimoustique!);
        // Navigator.pop(context);
      },
      text: 'Ajouter',
      options: FFButtonOptions(
        width: 270.0,
        height: 63.0,
        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        color: FlutterFlowTheme.of(context).success,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
        elevation: 0.0,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderColor: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: 12.0,
      borderWidth: 0.0,
      buttonSize: 44.0,
      icon: Icon(
        Icons.keyboard_return_sharp,
        color: FlutterFlowTheme.of(context).primaryText,
        size: 20.0,
      ),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }
}

class DeviceNameTextFormField extends StatelessWidget {
  const DeviceNameTextFormField({
    super.key,
    required AddDevicePageModel model,
  }) : _model = model;

  final AddDevicePageModel _model;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _model.textController,
      focusNode: _model.textFieldFocusNode,
      autofocus: true,
      obscureText: false,
      decoration: InputDecoration(
        labelText: 'Nom Borne',
        labelStyle: FlutterFlowTheme.of(context).labelMedium,
        hintStyle: FlutterFlowTheme.of(context).labelMedium,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).alternate,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium,
      maxLength: 15,
      validator: _model.textControllerValidator.asValidator(context),
    );
  }
}
