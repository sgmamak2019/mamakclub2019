import '../resources/petrolrepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mamakclub_beta/src/models/petrolmodel.dart';

class PetrolBloc{
  //1. make an instance of repository
  final _repository = PetrolRepository();
  //2. creeate an observable/Subject
  final _petrolFetcher = PublishSubject<PetrolRecord>();
  //3. create a local copy of the petrolList
  List<Petrol> localPetrol;
  //4. instantiate observable petrol record;
  Observable<PetrolRecord> get allPetrol => _petrolFetcher.stream;
  //5.Fetch all
  fetchAllPetrol() async {
    PetrolRecord returnee = new PetrolRecord();
    List<Petrol> petrolItems = await _repository.fetchAllPetrol();
    returnee.items = petrolItems;
    localPetrol = petrolItems;
    _petrolFetcher.sink.add(returnee);


  }
}
final petrolBloc = PetrolBloc();