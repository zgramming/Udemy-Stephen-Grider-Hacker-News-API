import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';

import '../resources/repository.dart';

class StoriesBloc {
  final _respository = Repository();

  final _topIds = PublishSubject<List<int>>();

  Stream<List<int>> get topIds => _topIds.stream;
  fetchTopIds() async {
    final ids = await _respository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
