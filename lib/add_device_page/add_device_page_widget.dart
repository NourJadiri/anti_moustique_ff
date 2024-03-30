import '../backend/schema/structs/antimoustique_struct.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'add_device_page_model.dart';
export 'add_device_page_model.dart';
import '../app_state.dart';

class AddDevicePageWidget extends StatefulWidget {
  const AddDevicePageWidget({super.key});

  @override
  State<AddDevicePageWidget> createState() => _AddDevicePageWidgetState();
}

class _AddDevicePageWidgetState extends State<AddDevicePageWidget> {
  late AddDevicePageModel _model;

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
    try {
      String qrResult = await FlutterBarcodeScanner.scanBarcode(
        '#C62828', // scanning line color
        'Cancel', // cancel button text
        true, // whether to show the flash icon
        ScanMode.QR,
      );

      // Decode the scanned JSON data
      Map<String, dynamic> qrData = jsonDecode(qrResult);

      print(qrData);

      // Check if all required fields (manufactureID, remoteID, vendor) are present
      if (qrData.containsKey('manufactureID') &&
          qrData.containsKey('remoteID') &&
          qrData.containsKey('vendor')) {
        // Extract manufactureID, remoteID, and vendor from the decoded JSON
        String manufactureID = qrData['manufactureID'];
        String remoteID = qrData['remoteID'];
        String vendor = qrData['vendor'];

        // Get the name from the input text field
        String name = _model.textController.text;

        setState(() {
          _model.antimoustique = createAntimoustiqueStruct(
            manufactureID: manufactureID,
            vendor: vendor,
            name: name,
            remoteID: remoteID,
          );
          // Vérifier si _model.antimoustique est non null avant de l'utiliser
          if (_model.antimoustique != null) {
            _model.appState?.addToDeviceList(_model.antimoustique!);
          }
        });
      } else {
        // Show error message if any of the required fields are missing
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Invalid QR code. Please make sure it contains manufactureID, remoteID, and vendor.'),
          ),
        );
      }
    } catch (e) {
      print("Error scanning QR code: $e");
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error scanning QR code. Please try again.'),
        ),
      );
    }
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
                              Align(
                                alignment:
                                    const AlignmentDirectional(-1.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: 12.0,
                                  borderWidth: 0.0,
                                  buttonSize: 44.0,
                                  icon: Icon(
                                    Icons.keyboard_return_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
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
                    child: FFButtonWidget(
                      onPressed: () async {
                        // Scanner QR code
                        _scanQR(context);
                      },
                      text: 'Scanner',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        height: 0.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
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
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
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
                    child: TextFormField(
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
                      maxLength: 10,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
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
                        _model.deviceInfo,
                        'ID Borne',
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
