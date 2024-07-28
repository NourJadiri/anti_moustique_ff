/*
Cette classe définit l'interface utilisateur pour la page de gestion des appareils, permettant à l'utilisateur d'afficher une liste de ses appareils connectés,
 d'en ajouter de nouveaux, et de naviguer vers d'autres pages pour des actions spécifiques.
 Elle utilise le modèle de données DevicePageModel pour gérer son état et interagit avec l'état global de l'application via FFAppState.
 */
import 'package:anti_moustique/backend/schema/structs/index.dart';
import 'package:anti_moustique/custom_code/actions/notification_utilities.dart';
import '/components/device_widget.dart';
import '/components/navigation_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'device_page_model.dart';
export 'device_page_model.dart';

// Widget de page principale pour la gestion des appareils.
class DevicePageWidget extends StatefulWidget {
  const DevicePageWidget({super.key});

  @override
  State<DevicePageWidget> createState() => _DevicePageWidgetState();
}

class _DevicePageWidgetState extends State<DevicePageWidget> {
  late DevicePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevicePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    // Structure de base de la page.
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          actions: const [],
          flexibleSpace: FlexibleSpaceBar(
            title: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mes Appareils',
                      style: FlutterFlowTheme.of(context).headlineLarge.override(
                            fontFamily: 'Inter',
                            fontSize: 20.0,
                          ),
                    ),
                    const NotificationIconButton(), // Bouton pour les notifications.
                  ],
                ),
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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: 478.0,
                      height: 608.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width * 1.0,
                                    height: 38.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                    ),
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: const Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: AddDeviceButton(), // Bouton pour ajouter un appareil.
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                final listeAppareils = FFAppState().deviceList.toList();
                                return buildDeviceListView(listeAppareils); // Construction de la liste des appareils.
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.navigationBarModel,
                  updateCallback: () => setState(() {}),
                  child: const NavigationBarWidget(), // Barre de navigation en bas de la page.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construit et retourne une liste des appareils.
  ListView buildDeviceListView(List<AntimoustiqueStruct> listeAppareils) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: listeAppareils.length,
      separatorBuilder: (_, __) => const SizedBox(height: 1.0),
      itemBuilder: (context, listeAppareilsIndex) {
        final listeAppareilsItem = listeAppareils[listeAppareilsIndex];
        return InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            setState(() {
              FFAppState().currentDevice = listeAppareilsItem;
            });

            //await refreshDeviceInformation(FFAppState().currentDevice);
            await generateNotification();
            // Ouverture de la page de controle correspondante
            context.pushNamed('ControlePage');
          },
          child: DeviceWidget(
            // Widget personnalisé pour afficher chaque appareil.
            key: Key('Key1f8_${listeAppareilsIndex}_of_${listeAppareils.length}'),
            deviceName: listeAppareilsItem.name,
            deviceID: listeAppareilsItem.manufactureID,
            deviceCO2Level: listeAppareilsItem.co2,
            deviceAttractifLevel: listeAppareilsItem.attractif,
            index: listeAppareilsIndex,
          ),
        );
      },
    );
  }
}

// Bouton pour ajouter un nouvel appareil.
class AddDeviceButton extends StatelessWidget {
  const AddDeviceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Utilise FlutterFlowIconButton pour un style cohérent.
    return FlutterFlowIconButton(
      borderColor: const Color(0xFF2A2D50),
      borderRadius: 20.0,
      borderWidth: 1.0,
      buttonSize: MediaQuery.sizeOf(context).width * 0.6,
      fillColor: const Color(0xFF2A2D50),
      icon: Icon(
        Icons.add,
        color: FlutterFlowTheme.of(context).secondaryBackground,
        size: 24.0,
      ),
      onPressed: () async {
        // Ajout d'appareils factices pour la démonstration.
        context.pushNamed('AddDevicePage');
      },
    );
  }
}

// Bouton pour accéder aux notifications.
class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderColor: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: 20.0,
      borderWidth: 1.0,
      buttonSize: 40.0,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
      icon: Icon(
        Icons.notifications_none,
        color: FlutterFlowTheme.of(context).primaryText,
        size: 24.0,
      ),
      onPressed: () async {
        context.pushNamed('NotificationPage'); // Navigation vers la page des notifications.
      },
    );
  }
}
