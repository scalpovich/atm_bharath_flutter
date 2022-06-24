import 'package:atm_flutter_app/helper/database_operations.dart';
import 'package:atm_flutter_app/retrofit/api_service.dart';
import 'package:get/get.dart';

abstract class MainController extends GetxController {
  ApiService get apiClient => Get.find<ApiService>();
  DatabaseOperations get dbAccess => Get.find<DatabaseOperations>();
}
