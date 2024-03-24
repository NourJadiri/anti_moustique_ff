import '/components/navigation_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'controle_page_widget.dart' show ControlePageWidget;
import 'package:flutter/material.dart';

class ControlePageModel extends FlutterFlowModel<ControlePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for ScrollablePageView widget.
  PageController? scrollablePageViewController;

  int get scrollablePageViewCurrentIndex =>
      scrollablePageViewController != null &&
              scrollablePageViewController!.hasClients &&
              scrollablePageViewController!.page != null
          ? scrollablePageViewController!.page!.round()
          : 0;
  // Model for navigationBar component.
  late NavigationBarModel navigationBarModel1;
  // Model for navigationBar component.
  late NavigationBarModel navigationBarModel2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    navigationBarModel1 = createModel(context, () => NavigationBarModel());
    navigationBarModel2 = createModel(context, () => NavigationBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    navigationBarModel1.dispose();
    navigationBarModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
