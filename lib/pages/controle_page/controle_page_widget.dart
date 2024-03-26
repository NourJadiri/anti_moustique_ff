import 'package:anti_moustique/backend/schema/structs/antimoustique_struct.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '/components/functionning_schedule_widget.dart';
import '/components/navigation_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:anti_moustique/custom_code/actions/bluetooth_actions.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'controle_page_model.dart';
export 'controle_page_model.dart';

class ControlePageWidget extends StatefulWidget {
  const ControlePageWidget({super.key});

  @override
  State<ControlePageWidget> createState() => _ControlePageWidgetState();
}

class _ControlePageWidgetState extends State<ControlePageWidget> {
  late ControlePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ControlePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Contrôle',
                    style: FlutterFlowTheme.of(context).headlineLarge.override(
                          fontFamily: 'Inter',
                          fontSize: 20.0,
                        ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.notifications_none,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('NotificationPage');
                      },
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: false,
            expandedTitleScale: 1.0,
            titlePadding: const EdgeInsets.all(12.0),
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 872.0,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                  child: buildControlPageView(context),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.navigationBarModel2,
                  updateCallback: () => setState(() {}),
                  child: const NavigationBarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageView buildControlPageView(BuildContext context) {
    return PageView(
      controller: _model.scrollablePageViewController ??=
          PageController(initialPage: 0),
      scrollDirection: Axis.vertical,
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 60.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 511.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: DeviceIdTitleWidget()),
                      ),
                      const DeviceStateCircleWidget(),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: buildActivateButton(context),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 5.0, 0.0, 0.0),
                        child: Container(
                          width: 525.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        borderRadius: 25.0,
                                        borderWidth: 3.0,
                                        buttonSize: 50.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        icon: Icon(
                                          Icons.access_time_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          await _model
                                              .scrollablePageViewController
                                              ?.animateToPage(
                                            2,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                      ),
                                    ),
                                    const ProgrammerButtonContainer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 50.0, 0.0, 0.0),
                          child: Container(
                            width: 500.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Glisser pour plus d\'information',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        fontSize: 12.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 557.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_drop_down,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ],
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
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 4.0, 16.0, 60.0),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 770.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 511.0,
                            height: 106.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: const DeviceIdTitleWidget(),
                          ),
                        ),
                        const Co2LevelContainer(),
                        const AttractifLevelContainer(),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: Container(
                            width: 557.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    'Glisser pour afficher les plages horaires',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          fontSize: 12.0,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 1.0),
                          child: Container(
                            width: 500.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(height: 0.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const FunctionningSchedulePageView(),
      ],
    );
  }

  FFButtonWidget buildActivateButton(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        setState(() {
          _activateDevice(
            context,
            FFAppState().currentDevice,
          );
          FFAppState().updateCurrentDeviceStruct(
            (e) => e..isOn = !e.isOn,
          );
        });
      },
      text: FFAppState().currentDevice.isOn ? 'Désactiver' : 'Activer',
      options: FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: 35.0,
        padding: const EdgeInsetsDirectional.fromSTEB(70.0, 0.0, 70.0, 0.0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: FFAppState().currentDevice.isOn
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).secondaryBackground,
        textStyle: FlutterFlowTheme.of(context).labelSmall.override(
              fontFamily: 'Readex Pro',
              color: FFAppState().currentDevice.isOn
                  ? FlutterFlowTheme.of(context).accent4
                  : FlutterFlowTheme.of(context).primary,
            ),
        elevation: 3.0,
        borderSide: BorderSide(
          color: FFAppState().currentDevice.isOn
              ? const Color(0x00FFFFFF)
              : FlutterFlowTheme.of(context).primary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }

  Future<void> _activateDevice(BuildContext context, AntimoustiqueStruct currentDevice) async {
    try {
      if (!currentDevice.isOn) {
        await BluetoothActions.scanForDevice(name: 'Pipou');
        await BluetoothActions.connectToDevice(currentDevice);

        
      }
    } catch (e) {
      print(e);
    }
  }
}

class DeviceIdTitleWidget extends StatelessWidget {
  const DeviceIdTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, -1.0),
          child: Text(
            FFAppState().currentDevice.name,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primary,
                ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Text(
            FFAppState().currentDevice.manufactureID,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2A2D50),
              fontWeight: FontWeight.w100,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}

class FunctionningSchedulePageView extends StatelessWidget {
  const FunctionningSchedulePageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 38.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed('AddSchedulePage');
                        },
                        text: 'Nouvelle plage horaire',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                          elevation: 0.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const FunctioningScheduleListWidget(),
          ].divide(const SizedBox(height: 2.0)),
        ),
      ),
    );
  }
}

class FunctioningScheduleListWidget extends StatelessWidget {
  const FunctioningScheduleListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final listePlagesHoraires =
            FFAppState().functioningScheduleList.toList();
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: listePlagesHoraires.length,
          itemBuilder: (context, listePlagesHorairesIndex) {
            final listePlagesHorairesItem =
                listePlagesHoraires[listePlagesHorairesIndex];
            return Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 0.1,
              decoration: const BoxDecoration(),
              child: FunctionningScheduleWidget(
                key: Key(
                    'Key4rp_${listePlagesHorairesIndex}_of_${listePlagesHoraires.length}'),
                index: listePlagesHorairesIndex,
                startTime: listePlagesHorairesItem.startTime!,
                endTime: listePlagesHorairesItem.endTime!,
                date: listePlagesHorairesItem.startDay!,
                isPeriodic: listePlagesHorairesItem.isReccurent,
              ),
            );
          },
        );
      },
    );
  }
}

class ProgrammerButtonContainer extends StatelessWidget {
  const ProgrammerButtonContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.9),
      child: Text(
        'Programmer',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 12.0,
            ),
      ),
    );
  }
}

class AttractifLevelContainer extends StatelessWidget {
  const AttractifLevelContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 191.0,
        height: 163.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, -1.0),
              child: CircularPercentIndicator(
                percent: FFAppState().currentDevice.attractif,
                radius: 60.0,
                lineWidth: 12.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  valueOrDefault<String>(
                    formatNumber(
                      FFAppState().currentDevice.attractif,
                      formatType: FormatType.custom,
                      format: '#%',
                      locale: '',
                    ),
                    '1',
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: Text(
                'Attractif',
                style: FlutterFlowTheme.of(context).bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Co2LevelContainer extends StatelessWidget {
  const Co2LevelContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 191.0,
        height: 163.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0.0, -1.0),
              child: CircularPercentIndicator(
                percent: FFAppState().currentDevice.co2,
                radius: 60.0,
                lineWidth: 12.0,
                animation: true,
                animateFromLastPercent: true,
                progressColor: FlutterFlowTheme.of(context).primary,
                backgroundColor: FlutterFlowTheme.of(context).accent4,
                center: Text(
                  valueOrDefault<String>(
                    formatNumber(
                      FFAppState().currentDevice.co2,
                      formatType: FormatType.custom,
                      format: '#%',
                      locale: '',
                    ),
                    '0.1',
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.0),
              child: Text(
                'CO2',
                style: FlutterFlowTheme.of(context).bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceStateCircleWidget extends StatelessWidget {
  const DeviceStateCircleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
      child: Container(
        width: 192.0,
        height: 192.0,
        decoration: BoxDecoration(
          color: FFAppState().currentDevice.isOn
              ? const Color(0xFF05D03E)
              : const Color(0xFFD9E9FE),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: 144.0,
                  height: 144.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/boitier.png',
                width: 300.0,
                height: 200.0,
                fit: BoxFit.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
