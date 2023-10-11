import 'package:actorsapp/data/models/charactersModel.dart';
import 'package:actorsapp/data/webservices/characters_servies.dart';

class CharacterRepository {
  final CharactersWebService charactersWebService;

  CharacterRepository(this.charactersWebService);

   getAllCharacters() async {
    List characters = await charactersWebService.getAllCharacters();
    List<CharactersModel>? data=[];
    data.addAll(characters.map((character) => CharactersModel.fromJson(character)));
    return data;
  }
}
