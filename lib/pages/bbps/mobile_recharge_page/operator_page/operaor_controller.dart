import 'package:atm_flutter_app/resources/app_strings.dart';
import 'package:atm_flutter_app/utils/main_controller.dart';
import 'package:get/get.dart';

import '../../../../constants/database_constants.dart';
import '../../../../model/bbps/biller.dart';
import '../../../../model/bbps/circle.dart';

class OperatorController extends MainController {
  RxList<String> operatorList = <String>[].obs;
  RxList<Biller> billerList = <Biller>[].obs;
  RxBool isVisible = true.obs;
  RxList<String> circleList = <String>[].obs;
  RxString selectedId = ''.obs;
  RxString selectedOperator = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getOperatorsFromDB();
    getCircleFromDB();
  }

  ///getting operators from database
  void getOperatorsFromDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    billerList.value =
        box.get(DatabaseConstants.dbOperator).toList().cast<Biller>();
    for (var element in billerList) {
      operatorList.add(element.billerName.toString());
    }
  }

  ///operator selected function
  void onOperatorTap(String name, String id) {
    isVisible.value = false;
    selectedId.value = id;
    selectedOperator.value = name;
  }

  ///getting circle from database
  void getCircleFromDB() async {
    final box = await dbAccess.openDatabase(DatabaseConstants.dbName);
    List<Circle> listCircle =
        box.get(DatabaseConstants.dbCircle).toList().cast<Circle>();
    for (var element in listCircle) {
      circleList.add(element.circleName.toString());
    }
  }

  ///circle select function
  void onCircleTap(String circle) {
    Get.back(result: {
      AppStrings.txtOperatorId: selectedId.value,
      AppStrings.txtOperator: selectedOperator.value,
      AppStrings.txtCircle: circle,
    });
  }
}
