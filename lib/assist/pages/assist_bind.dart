import 'package:abctechapp/assist/controller/assist_controller.dart';
import 'package:get/instance_manager.dart';

class AssistBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssistController>(() => AssistController());
  }
}
