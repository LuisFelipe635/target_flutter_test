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
  final ObservableMap<String, String?> _storedData = ObservableMap();

  Map<String, String?> get allData => Map.unmodifiable(_storedData);

  List<String?> get allTexts => List.unmodifiable(_storedData.values);

  int get _lastStoredIndex => (_storedData.keys.isNotEmpty) ? int.parse(_storedData.keys.last.characters.last) : 0;

  Action get save => _saveAction;

  Action get deleteDataAtIndex => _deleteDataAtIndexAction;

  Action get retrieveStoredData => _retrieveStoredDataAction;

  Future<void> _save(final String newData, {final bool isEdit = false, final int? index}) async {
    if (isEdit && index != null) {
      final dataUnderEdition = _storedData.entries.elementAt(index);
      _storedData[dataUnderEdition.key] = newData;

      await _repository.save(dataUnderEdition.key, newData);
    } else {
      final key = '$_dataKeyPrefix${_lastStoredIndex + 1}';

      _storedData.addAll({key: newData});

      await _repository.save(key, newData);
    }
  }

  Future<void> _deleteDataAtIndex(final int index) async {
    final key = _storedData.entries.elementAt(index).key;

    _storedData.remove(key);
    await _repository.erase(key);
  }

  Future<void> _retrieveStoredData() async {
    final data = await _repository.retrieveData();

    if (data != null) {
      _storedData.addAll(data);
    }
  }
}
