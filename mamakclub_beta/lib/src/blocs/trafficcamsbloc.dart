import '../resources/trafficrepository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/govpost.dart';

class TrafficCamsBloc {
  final _repository = Repository();
  final _trafficCamsFetcher = PublishSubject<TrafficPost>();

  Observable<TrafficPost> get allCams => _trafficCamsFetcher.stream;
  fetchAllCams() async {
    TrafficPost tpost = await _repository.fetchCams();
    _trafficCamsFetcher.sink.add(tpost);
  }

  dispose() {
    _trafficCamsFetcher.close();
  }
}

final trafficCamBloc = TrafficCamsBloc();
