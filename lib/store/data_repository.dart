abstract interface class DataRepository {
  Future<List<String?>?> retrieveData();

  Future<List<String>?> retrieveKeys();

  Future<void> save(final String key, final String data);

  Future<void> erase(final String key);

  Future<void> eraseAll();
}
