import 'package:shared_preferences/shared_preferences.dart';

import 'data_repository.dart';

class StandardDataRepository implements DataRepository {
  @override
  Future<List<String?>?> retrieveData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final allKeys = sharedPreferences.getKeys();
    final List<String?> allData = [];

    for (final key in allKeys) {
      allData.add(sharedPreferences.getString(key));
    }

    return allData.isNotEmpty ? allData : null;
  }

  @override
  Future<List<String>?> retrieveKeys() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final keysList = sharedPreferences.getKeys().toList();
    return keysList.isNotEmpty ? keysList : null;
  }

  @override
  Future<void> save(String key, String data) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, data);
    await sharedPreferences.reload();
  }

  @override
  Future<void> erase(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> eraseAll() async {
    final shared = await SharedPreferences.getInstance();
    await shared.clear();
  }
}
