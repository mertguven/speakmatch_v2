import 'package:flutter_easyloading/flutter_easyloading.dart';

void loadingDialogInstance() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..maskType = EasyLoadingMaskType.black;
}
