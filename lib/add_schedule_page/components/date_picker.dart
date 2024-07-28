import 'package:anti_moustique/add_schedule_page/add_schedule_page_model.dart';
import 'package:anti_moustique/flutter_flow/flutter_flow_theme.dart';
import 'package:anti_moustique/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required AddSchedulePageModel model,
  }) : _model = model;

  final AddSchedulePageModel _model;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  void _showDatePicker(BuildContext context) async {
    {
      final datePicked1Date = await showDatePicker(
        context: context,
        initialDate: getCurrentTimestamp,
        initialEntryMode: DatePickerEntryMode.calendar,
        firstDate: getCurrentTimestamp,
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: FlutterFlowTheme.of(context)
                    .primary, // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface:
                    FlutterFlowTheme.of(context).primaryText, // Body text color
              ),
              dialogBackgroundColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              datePickerTheme: DatePickerThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                headerBackgroundColor: FlutterFlowTheme.of(context).primary,
                headerForegroundColor: Colors.white,
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                yearForegroundColor: WidgetStateProperty.all(
                    FlutterFlowTheme.of(context).primaryText),
                rangeSelectionBackgroundColor:
                    FlutterFlowTheme.of(context).primary.withOpacity(0),
              ),
            ),
            child: child!,
          );
        },
      );

      if (datePicked1Date != null) {
        safeSetState(() {
          widget._model.selectedDate = DateTime(
            datePicked1Date.year,
            datePicked1Date.month,
            datePicked1Date.day,
          );
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _showDatePicker(context),
      child: Container(
        width: 204.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).alternate,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              dateTimeFormat('d/M/y', widget._model.selectedDate),
              'Sélectionner une date',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primary,
                ),
          ),
        ),
      ),
    );
  }
}
