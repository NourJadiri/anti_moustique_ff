import 'package:anti_moustique/backend/schema/structs/index.dart';
import 'package:anti_moustique/custom_code/actions/bluetooth_actions.dart';
import 'package:anti_moustique/custom_code/actions/device_utilities.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'add_device_page_model.dart';
export 'add_device_page_model.dart';

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

    // Check if the device list contains a device with the same manufacture ID
    if (FFAppState().deviceList.any((device) => device.manufactureID == qrData['manufactureID'])) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cet appareil a déjà été ajouté'),
        ),
      );
      return;
    }

    // Check if the QR code data is empty
    if (qrData.isEmpty && context.mounted) {
      buildQRReadingError(context);
      return;
    }

    // Show a loading dialog while processing the QR code
    if(context.mounted) {
      showProcessingQrDialog(context);
    }

    try {
      if (context.mounted) {
        // Get the device from the QR code data
        AntimoustiqueStruct newAntiMoustique = await getDeviceFromQR(context, qrData);
        await refreshDeviceInformation(newAntiMoustique);    

        setState(() {
          _model.antimoustique = newAntiMoustique;
          _deviceScanned = (newAntiMoustique != AntimoustiqueStruct());
        });
      }
    } catch (e) {
      // Handle errors
      print("Error: $e");
    } finally {
      // Close the loading dialog
      if(context.mounted){
        Navigator.of(context).pop();
      }
    }
  }

  Future<dynamic> showProcessingQrDialog(BuildContext context) {
    return showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Please wait...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Processing QR code...",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    },
  );
  }

  void buildQRReadingError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erreur lors de la lecture du QR code'),
      ),
    );
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
                const Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                  child: AjouterAppareilTopBar(),
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
                      color: _deviceScanned
                          ? FlutterFlowTheme.of(context).success
                          : FlutterFlowTheme.of(context).primary,
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
                    child: ConfirmDeviceScanButton(model: _model),
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

class AjouterAppareilTopBar extends StatelessWidget {
  const AjouterAppareilTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class ConfirmDeviceScanButton extends StatefulWidget {
  const ConfirmDeviceScanButton({
    super.key,
    required AddDevicePageModel model,
  }) : _model = model;

  final AddDevicePageModel _model;

  @override
  State<ConfirmDeviceScanButton> createState() => _ConfirmDeviceScanButtonState();
}

class _ConfirmDeviceScanButtonState extends State<ConfirmDeviceScanButton> {
  Future<void> _onPressed(BuildContext context) async {
    // if the device list contains a device with the same manufacture ID, return

    if (widget._model.antimoustique != null) {
      if (widget._model.textController!.text.isNotEmpty) {
        widget._model.antimoustique!.name = widget._model.textController!.text;

        await BluetoothActions.connectToDevice(widget._model.antimoustique!);
        await BluetoothActions.discoverServices(widget._model.antimoustique!);
        await refreshDeviceInformation(widget._model.antimoustique!);
        }

        FFAppState().update(
          () {
            FFAppState().addToDeviceList(widget._model.antimoustique!);
          },
        );
      
        Navigator.pop(context);

      }
  }

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = widget._model.antimoustique != null;
    return FFButtonWidget(
      onPressed: isButtonEnabled ? () => _onPressed(context) : null,
      text: 'Ajouter',
      options: FFButtonOptions(
        width: 270.0,
        height: 63.0,
        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
        color: isButtonEnabled ? FlutterFlowTheme.of(context).success : const Color.fromARGB(255, 214, 214, 214),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
        elevation: 0.0,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(25.0),
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
