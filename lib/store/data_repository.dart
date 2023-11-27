abstract interface class DataRepository {
  Future<Map<String, String?>?> retrieveData();

  Future<void> save(final String key, final String data);

  Future<void> erase(final String key);
}
