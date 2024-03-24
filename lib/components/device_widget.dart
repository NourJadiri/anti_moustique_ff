import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'device_model.dart';
export 'device_model.dart';

class DeviceWidget extends StatefulWidget {
  const DeviceWidget({
    super.key,
    String? deviceName,
    String? deviceID,
    double? deviceCO2Level,
    double? deviceAttractifLevel,
    required this.index,
  })  : deviceName = deviceName ?? 'Name',
        deviceID = deviceID ?? 'id',
        deviceCO2Level = deviceCO2Level ?? 0.5,
        deviceAttractifLevel = deviceAttractifLevel ?? 0.7;

  final String deviceName;
  final String deviceID;
  final double deviceCO2Level;
  final double deviceAttractifLevel;
  final int? index;

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  late DeviceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeviceModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 107.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.asset(
                  'assets/images/boitier.png',
                  width: 90.0,
                  height: 90.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.deviceName.maybeHandleOverflow(
                      maxChars: 20,
                      replacement: '…',
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Inter',
                          color: const Color(0xFF2A2D50),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, .0, 0.0, 0.0),
                    child: Text(
                      widget.deviceID,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: const Color(0xFF555BA4),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'CO2',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                  ),
                            ),
                          ],
                        ),
                        LinearPercentIndicator(
                          percent: widget.deviceCO2Level,
                          width: 120.0,
                          lineHeight: 8.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor:
                              (widget.deviceCO2Level >= .20 ? true : false)
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).error,
                          backgroundColor: const Color(0xFFDBDEFF),
                          barRadius: const Radius.circular(7.0),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Attractif',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                  ),
                            ),
                          ],
                        ),
                        LinearPercentIndicator(
                          percent: widget.deviceAttractifLevel,
                          width: 120.0,
                          lineHeight: 8.0,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: widget.deviceAttractifLevel >= 0.20
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).error,
                          backgroundColor: const Color(0xFFDBDEFF),
                          barRadius: const Radius.circular(7.0),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent, 
                onTap: () async {
                  FFAppState().update(() {
                    FFAppState().removeAtIndexFromDeviceList(widget.index!);
                  });
                },
                child: Icon(
                  Icons.delete_outlined,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
              ),
            ),
          ].divide(const SizedBox(width: 20.0)).addToStart(const SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}
