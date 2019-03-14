import '../resources/mainrepository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/commoditiesmodel.dart';

class MainBloc {
  final _repository = MainRepository();
  final _commsFetcher = PublishSubject<CommoditiesRecord>();
  Observable<CommoditiesRecord> get allComms => _commsFetcher.stream;

  fetchAllCommodities() async {
    CommoditiesRecord record = new CommoditiesRecord();
    List<Commodities> comList = await _repository.fetchComms();
    record.items = comList;
    _commsFetcher.sink.add(record);
  }
}

final MainBloc mainBloc = MainBloc();
