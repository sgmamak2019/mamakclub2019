import '../resources/fxrepository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/fxmodel.dart';

class FXBloc {
  //1. IN my bloc, i want a live instance of the repository
  final _repository = FXRepository();
  //2. I need an observable, where my UI can watch
  final _fxSGFetcher = PublishSubject<FXRecord>();
  final _fxMYFetcher = PublishSubject<FXRecord>();
  List<FX> fxSGLocal;
  List<FX> fxMYLocal;

  Observable<FXRecord> get allSGFx => _fxSGFetcher.stream;
  Observable<FXRecord> get allMYFx => _fxMYFetcher.stream;
  // "=>" means left side will do what right side does.
  //3. Expose a public method that will use repository to get dataq
  fetchAllSGFX() async {
    FXRecord returnee = new FXRecord();
    List<FX> tpost = await _repository.fetchFX('fx');
    returnee.items = tpost;
    fxSGLocal = tpost;
    _fxSGFetcher.sink.add(returnee);
  }

  fetchAllSGFXFilter(String currency) {
    
    FXRecord returnee = new FXRecord();
    returnee.items = narrowDown(fxSGLocal, currency);
    //for some reason the iterators ForEach, .where((x)=> doesn't allow me to put conditions inside/)
    _fxSGFetcher.sink.add(returnee);
  }

  fetchAllMYFX() async {
    FXRecord returnee = new FXRecord();
    List<FX> tpost = await _repository.fetchFX('fx_my');
    returnee.items = tpost;
    fxMYLocal = tpost;
    _fxMYFetcher.sink.add(returnee);
  }

  fetchAllMYFXFilter(String currency) {
    FXRecord returnee = new FXRecord();
    returnee.items = narrowDown(fxMYLocal, currency);
    _fxSGFetcher.sink.add(returnee);
  }
  List<FX> narrowDown(List<FX> local, String curr) {
    List<FX> fxList = new List<FX>();
    //had to resort to this because iterators and foreach wnt allow me to put conditions
    //whereiterable.toList() also doesn't work.
    for (var x = 0; x < local.length; x++) {
      if (local.elementAt(x).documentId.contains(curr)) {
        fxList.add(local.elementAt(x));
      }
    }
    return fxList;
  }
 dispose() {
    //4. Dispose
    _fxSGFetcher.close();
  }
}

//5. Expose the instance of BLOC to UI
final fxBloc = FXBloc();
