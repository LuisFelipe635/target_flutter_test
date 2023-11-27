import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_repository.dart';

class StandardDataRepository implements DataRepository {
  @override
  Future<Map<String, String?>?> retrieveData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final allKeys = sharedPreferences.getKeys().sorted();
    final Map<String, String?> allData = {};

    for (final key in allKeys) {
      allData.addAll({key: sharedPreferences.getString(key)});
    }

    return allData.isNotEmpty ? allData : null;
  }

  @override
  Future<void> save(String key, String data) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, data);
  }

  @override
  Future<void> erase(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }
}
