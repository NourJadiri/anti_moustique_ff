import 'package:flutter/material.dart';
import 'package:anti_moustique/flutter_flow/flutter_flow_theme.dart';
import 'package:anti_moustique/flutter_flow/flutter_flow_util.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimeChanged,
  });

  final DateTime selectedTime;
  final ValueChanged<DateTime> onTimeChanged;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final timePicker = await showTimePicker(
          context: context,
          initialEntryMode: TimePickerEntryMode.inputOnly,
          initialTime: TimeOfDay.fromDateTime(selectedDateTime),
          builder: (context, child) {
            return wrapInMaterialTimePickerTheme(
              context,
              child!,
              headerBackgroundColor: FlutterFlowTheme.of(context).primary,
              headerForegroundColor: FlutterFlowTheme.of(context).info,
              headerTextStyle:
                  FlutterFlowTheme.of(context).headlineLarge.override(
                        fontFamily: 'Inter',
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600,
                      ),
              pickerBackgroundColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
              selectedDateTimeBackgroundColor:
                  FlutterFlowTheme.of(context).primary,
              selectedDateTimeForegroundColor:
                  FlutterFlowTheme.of(context).info,
              actionButtonForegroundColor:
                  FlutterFlowTheme.of(context).primaryText,
              iconSize: 24.0,
            );
          },
        );
        if (timePicker != null) {
          setState(() {
            selectedDateTime = DateTime(
              selectedDateTime.year,
              selectedDateTime.month,
              selectedDateTime.day,
              timePicker.hour,
              timePicker.minute,
            );
          });
          widget.onTimeChanged(
              selectedDateTime); // Call the callback function with the new time
        }
      },
      child: Container(
        width: 90.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              dateTimeFormat('Hm', selectedDateTime),
              '09:41',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 20.0,
                ),
          ),
        ),
      ),
    );
  }
}
