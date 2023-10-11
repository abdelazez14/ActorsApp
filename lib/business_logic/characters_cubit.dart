import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../data/models/charactersModel.dart';
import '../data/repoistory/characters_repoistory.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository charactersRepository;
  List<CharactersModel> characters=[];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharactersModel>? getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      this.characters=characters;
      emit(CharactersLoaded(this.characters));
    });
    return characters;
  }
}



