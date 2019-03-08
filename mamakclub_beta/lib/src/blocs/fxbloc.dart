import '../resources/fxrepository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/fxmodel.dart';

class FXBloc {
  //1. IN my bloc, i want a live instance of the repository
  final _repository =  FXRepository();
  //2. I need an observable, where my UI can watch
  final _fxSGFetcher = PublishSubject<FXRecord>();
  final _fxMYFetcher = PublishSubject<FXRecord>();

  Observable<FXRecord> get allSGFx => _fxSGFetcher.stream;
  Observable<FXRecord> get allMYFx => _fxMYFetcher.stream;
  // "=>" means left side will do what right side does.
  //3. Expose a public method that will use repository to get dataq
  fetchAllSGFX() async{
    FXRecord returnee = new FXRecord();

    List<FX> tpost = await _repository.fetchFX('fx');
    returnee.items =tpost;
    _fxSGFetcher.sink.add(returnee);
  }
  fetchAllMYFX() async{
       FXRecord returnee = new FXRecord();

    List<FX> tpost = await _repository.fetchFX('fx_my');
    returnee.items =tpost;
    _fxMYFetcher.sink.add(returnee);
  }

  dispose() {
  //4. Dispose
    _fxSGFetcher.close();
  }
  
}
//5. Expose the instance of BLOC to UI
final fxBloc = FXBloc();

