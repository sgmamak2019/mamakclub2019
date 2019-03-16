import '../resources/mainrepository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/commoditiesmodel.dart';

class MainBloc {
  final _repository = MainRepository();
  final _commsFetcher = PublishSubject<List<Commodities>>();
  bool hasLoaded = false;
  List<Commodities> localComms = new List<Commodities>();

  Observable<List<Commodities>> get allComms => _commsFetcher.stream;
   fetchAllCommodities() async {
   
    _repository.fetchComms().then((onValue){
      this.hasLoaded = true;
      localComms.removeRange(0, localComms.length);
      localComms.addAll(onValue);
      _commsFetcher.sink.add(localComms);
    });
   
  }
  updateComms() async {
    _commsFetcher.sink.add(localComms);
  }
 
}

final MainBloc mainBloc = MainBloc();
