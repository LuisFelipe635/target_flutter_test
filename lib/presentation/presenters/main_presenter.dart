import 'package:flutter/widgets.dart' hide Action;
import 'package:mobx/mobx.dart';

import '../../store/data_repository.dart';

class MainPresenter with Store {
  MainPresenter(this._repository) {
    _saveAction = Action(_save);
    _deleteDataAtIndexAction = Action(_deleteDataAtIndex);
    _retrieveStoredDataAction = Action(_retrieveStoredData);
  }

  static const _dataKeyPrefix = 'dataNo';

  final DataRepository _repository;

  late final Action _saveAction;
  late final Action _deleteDataAtIndexAction;
  late final Action _retrieveStoredDataAction;
  final ObservableList<String?> _storedData = ObservableList();
  final List<String> _storageKeys = [];

  List<String?> get data => List.unmodifiable(_storedData);

  int get _lastUsedIndex => int.tryParse(_storageKeys.last.characters.last) ?? 0;

  Action get save => _saveAction;

  Action get deleteDataAtIndex => _deleteDataAtIndexAction;

  Action get retrieveStoredData => _retrieveStoredDataAction;

  Future<void> _save(final String data, {final bool isEdit = false, final int? index}) async {
    if (isEdit && index != null) {
      _storedData[index] = data;
      final key = _storageKeys[index];

      await _repository.save(key, data);
    } else {
      _storedData.add(data);

      await _repository.save('$_dataKeyPrefix${_lastUsedIndex + 1}', data);
    }
  }

  Future<void> _deleteDataAtIndex(final int index) async {
    _storedData.removeAt(index);

    final key = _storageKeys[index];
    await _repository.erase(key);
  }

  Future<void> _retrieveStoredData() async {
    final data = await _repository.retrieveData();
    final keys = await _repository.retrieveKeys();

    if (data != null) {
      _storedData.addAll(data);
    }

    if (keys != null) {
      _storageKeys.addAll(keys);
    }
  }
}
