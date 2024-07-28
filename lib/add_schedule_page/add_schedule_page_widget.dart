import 'package:anti_moustique/add_schedule_page/components/date_picker.dart';
import 'package:anti_moustique/add_schedule_page/components/time_picker.dart';
import 'package:anti_moustique/custom_code/actions/func_schedule_services.dart';
import 'package:anti_moustique/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'add_schedule_page_model.dart';
export 'add_schedule_page_model.dart';

class AddSchedulePageWidget extends StatefulWidget {
  const AddSchedulePageWidget({
    super.key,
    this.index,
    this.startTime,
    this.endTime,
    this.date,
    this.isPeriodic,
  });

  final int? index;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final DateTime? date;
  final bool? isPeriodic;

  @override
  State<AddSchedulePageWidget> createState() => _AddSchedulePageWidgetState();
}

class _AddSchedulePageWidgetState extends State<AddSchedulePageWidget> {
  late AddSchedulePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddSchedulePageModel());

    _model.selectedDate = widget.date;
    _model.startTime = DateTime(
      widget.date?.year ?? DateTime.now().year,
      widget.date?.month ?? DateTime.now().month,
      widget.date?.day ?? DateTime.now().day,
      widget.startTime?.hour ?? TimeOfDay.now().hour,
      widget.startTime?.minute ?? TimeOfDay.now().minute,
    );
    _model.endTime = DateTime(
      widget.date?.year ?? DateTime.now().year,
      widget.date?.month ?? DateTime.now().month,
      widget.date?.day ?? DateTime.now().day,
      widget.endTime?.hour ?? TimeOfDay.now().hour,
      widget.endTime?.minute ?? TimeOfDay.now().minute,
    );
    _model.switchValue = widget.isPeriodic ?? false;
    _model.checkboxGroupValues = _model.switchValue == true
        ? DayOfWeek.values
            .where((day) => FFAppState()
                .currentDevice!
                .functioningScheduleList[widget.index!]
                .days
                .contains(day))
            .map((day) => day.name)
            .toList()
        : null;
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 5.0),
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
                                            .primary,
                                        size: 20.0,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      widget.index != null
                                          ? 'Editer la plage horaire'
                                          : 'Nouvelle plage horaire',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(1.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: 12.0,
                                      borderWidth: 0.0,
                                      buttonSize: 44.0,
                                      icon: Icon(
                                        Icons.notifications_none,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20.0,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Date',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 20.0,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.68, 0.0),
                          child: DatePicker(model: _model),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Début',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 20.0,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.5, 0.0),
                          child: TimePicker(
                              selectedTime: _model.startTime!,
                              onTimeChanged: (time) => setState(() {
                                    _model.startTime = time;
                                  })),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Fin',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 20.0,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.5, 0.0),
                          child: TimePicker(
                            selectedTime: _model.endTime!,
                            onTimeChanged: (time) => setState(() {
                              _model.endTime = time;
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.09,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Récurrence',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 20.0,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.5, 0.0),
                          child: Switch.adaptive(
                            value: _model.switchValue ??= false,
                            onChanged: (newValue) async {
                              setState(() => _model.switchValue = newValue);
                            },
                            activeColor: FlutterFlowTheme.of(context).primary,
                            activeTrackColor: const Color(0xFF05D03E),
                            inactiveTrackColor:
                                FlutterFlowTheme.of(context).alternate,
                            inactiveThumbColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Visibility(
                    visible: _model.switchValue ?? true,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          40.0, 0.0, 0.0, 0.0),
                      child: FlutterFlowCheckboxGroup(
                        options: const [
                          'Chaque lundi',
                          'Chaque mardi',
                          'Chaque mercredi',
                          'Chaque jeudi',
                          'Chaque vendredi',
                          'Chaque samedi',
                          'Chaque dimanche'
                        ],
                        onChanged: (val) {
                          print(val);
                          setState(() => _model.checkboxGroupValues =
                              val.map((e) => e.split(' ').last).toList());
                        },
                        controller: _model.checkboxGroupValueController ??=
                            FormFieldController<List<String>>(
                          [],
                        ),
                        activeColor: FlutterFlowTheme.of(context).primary,
                        checkColor: FlutterFlowTheme.of(context).info,
                        checkboxBorderColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        textStyle: FlutterFlowTheme.of(context).bodyMedium,
                        unselectedTextStyle:
                            FlutterFlowTheme.of(context).bodyMedium,
                        checkboxBorderRadius: BorderRadius.circular(4.0),
                        initialized: _model.checkboxGroupValues != null,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: MediaQuery.sizeOf(context).height * 0.04,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final DateTime? startDay =
                                _model.switchValue ?? false
                                    ? null
                                    : _model.selectedDate;
                            final TimeOfDay? startTime =
                                _model.startTime != null
                                    ? TimeOfDay(
                                        hour: _model.startTime!.hour,
                                        minute: _model.startTime!.minute)
                                    : null;

                            final TimeOfDay? endTime = _model.endTime != null
                                ? TimeOfDay(
                                    hour: _model.endTime!.hour,
                                    minute: _model.endTime!.minute)
                                : null;

                            if ((!_model.switchValue! && startDay == null) ||
                                startTime == null ||
                                endTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Veuillez remplir tous les champs."),
                                ),
                              );
                              return;
                            }

                            final startDateTime = TimeOfDay(
                              hour: startTime.hour,
                              minute: startTime.minute,
                            );

                            final endDateTime = TimeOfDay(
                              hour: endTime.hour,
                              minute: endTime.minute,
                            );

                            if ((startDateTime.hour * 60 +
                                    startDateTime.minute) >=
                                (endDateTime.hour * 60 + endDateTime.minute)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "L'heure de fin doit être après l'heure de début."),
                                ),
                              );
                              return;
                            }

                            var functioningSchedule = FunctioningScheduleStruct(
                                startDay: startDay,
                                startTime: startDateTime,
                                endTime: endDateTime,
                                isReccurent: _model.switchValue ?? false,
                                days: _model.checkboxGroupValues
                                    ?.map((e) => DayOfWeek.values.byName(e))
                                    .toList());

                            if (widget.index != null) {
                              // Supprimer l'ancienne plage de fonctionnement
                              FFAppState()
                                  .currentDevice!
                                  .functioningScheduleList
                                  .removeAt(widget.index!);
                            }

                            // Ajouter la nouvelle plage de fonctionnement
                            if (!await addFunctionSchedule(
                                context,
                                FFAppState().currentDevice!,
                                functioningSchedule)) return;

                            FFAppState().updateCurrentDeviceStruct((device) {
                              device.functioningScheduleList
                                  .add(functioningSchedule);
                            });

                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          text: widget.index != null
                              ? 'Mettre à jour'
                              : 'Confirmer',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
