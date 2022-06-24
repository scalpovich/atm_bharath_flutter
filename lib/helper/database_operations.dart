import 'package:atm_flutter_app/constants/database_constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseOperations {
  Future<Box> openDatabase(String boxName) async {
    Box box;
    try {
      box = Hive.box(boxName);
    } catch (error) {
      box = await Hive.openBox(boxName);
    }
    return box;
  }

  Future<bool> isTableEmpty(String tableName) async {
    //open database
    Box box = await openDatabase(DatabaseConstants.dbName);
    // read table values
    var tableData = box.get(tableName);
    bool table = false;
    if (tableData != null) {
      table = true;
    }
    return table;
  }
}
