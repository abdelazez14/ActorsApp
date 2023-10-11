import 'package:actorsapp/business_logic/characters_cubit.dart';
import 'package:actorsapp/data/models/charactersModel.dart';
import 'package:actorsapp/data/repoistory/characters_repoistory.dart';
import 'package:actorsapp/data/webservices/characters_servies.dart';
import 'package:actorsapp/presentation/screens/character_details.dart';
import 'package:actorsapp/presentation/screens/characters_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharactersWebService());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreens:
        return MaterialPageRoute(
          builder: (_) => BlocProvider( //كدا انا خليت البلوك بروفيدر علي الصفحة كلها بتاعهCharacters_Screens
            create: (BuildContext context) => charactersCubit,
            child: const Characters_Screens(),
          ),
        );
      case charactersDetailsScreens:
        final character=settings.arguments as CharactersModel;
        return MaterialPageRoute(builder: (_) =>  CharactersDetails(charactersModel: character,));
    }
  }
}
