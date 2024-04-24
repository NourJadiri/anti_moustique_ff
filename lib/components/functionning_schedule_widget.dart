import 'package:anti_moustique/custom_code/actions/device_utilities.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'functionning_schedule_model.dart';
export 'functionning_schedule_model.dart';

class FunctionningScheduleWidget extends StatefulWidget {
  const FunctionningScheduleWidget({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.index,
    required this.isPeriodic,
  });

  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final DateTime? date;
  final int? index;
  final bool? isPeriodic;

  @override
  State<FunctionningScheduleWidget> createState() => _FunctionningScheduleWidgetState();
}

class _FunctionningScheduleWidgetState extends State<FunctionningScheduleWidget> {
  late FunctionningScheduleModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FunctionningScheduleModel(FFAppState())); // Passer FFAppState ici
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
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
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3416202A),
            offset: Offset(0.0, 2.0),
          )
        ],
        borderRadius: BorderRadius.circular(0.0),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.startTime!.format(context),
                          '15:00',
                        ),
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      Text(
                        'à ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                      ),
                      Text(
                        valueOrDefault<String>(
                          widget.endTime!.format(context),
                          '21:00',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          valueOrDefault<String>(widget.isPeriodic! ? 'Periodic' : DateFormat('dd/MM/yyyy').format(widget.date!), 'undefined'),
                          style: FlutterFlowTheme.of(context).labelSmall.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.w200,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                try {
                  FFAppState().update(() {
                    setState(() {
                      // Attempt to delete the schedule
                      deleteFunctioningSchedule(FFAppState().currentDevice!, widget.index!);
                      // If successful, remove it from the list
                      FFAppState().currentDevice!.removeAtIndexFromFunctioningScheduleList(widget.index!);
                    });
                  });
                } catch (e) {
                  // Catch any errors thrown by deleteFunctioningSchedule or other operations
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: $e'), // Display the error message
                    duration: const Duration(seconds: 2),
                  ));
                }
              },
              child: Icon(
                Icons.delete_outlined,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
