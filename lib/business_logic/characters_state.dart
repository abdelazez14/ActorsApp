part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {} // بيحدد حاله الداتا بتاعتي

class CharactersLoaded extends CharactersState {
  final List<CharactersModel>characters;
  CharactersLoaded(this.characters);

}
