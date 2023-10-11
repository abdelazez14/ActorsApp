import 'package:actorsapp/business_logic/characters_cubit.dart';
import 'package:actorsapp/constants/colors.dart';
import 'package:actorsapp/presentation/widgets/characters_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../data/models/charactersModel.dart';


class Characters_Screens extends StatefulWidget {
  const Characters_Screens({super.key});

  @override
  State<Characters_Screens> createState() => _Characters_ScreensState();
}

class _Characters_ScreensState extends State<Characters_Screens> {


  late List<CharactersModel> allCharacters;
  late List<CharactersModel> searchForCharacters;
  bool isSearching =false;
  final searchText=TextEditingController();

  Widget buildSearchField(){
    return TextField(
      controller: searchText,
      cursorColor: MyColors.gray,
      decoration: const InputDecoration(
        hintText: "Find a character....",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.gray,fontSize: 18,),
      ),
      style: const TextStyle(color: MyColors.gray,fontSize: 18,),
      onChanged: (searchedCharacter){
        addSearchedForItemsToSearchedList(searchedCharacter);
      } ,
    );
  }

 void addSearchedForItemsToSearchedList(String searchedCharacter){
    searchForCharacters= allCharacters.where((character) => character.name!.toLowerCase().startsWith(searchedCharacter)).toList();
    setState(() {

    });
  }

  List<Widget> buildAppBarActions(){
    if(isSearching){
      return [
        IconButton(onPressed: (){
          clearSearch();
          Navigator.pop(context);
        }, icon: const Icon(Icons.clear,color: MyColors.gray,)),
      ];
    }else{
      return [
        IconButton(onPressed: startSearch,
            icon: Icon(Icons.search,color: MyColors.gray)),
      ];
    }
  }

  void startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching(){
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch(){
    setState(() {
      searchText.clear();
    });
  }


  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters()!;
    //كدا انا بخلي ال ui يقول لل cubit اديني الداتا بتاعتك
  }

  Widget buildBlocWidgets() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidgets();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.gray,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchText.text.isEmpty? allCharacters.length: searchForCharacters.length,
      itemBuilder: (ctx, index) {
        return  CharacterItem(charactersModel:
       searchText.text.isEmpty? allCharacters[index]:searchForCharacters[index],);
      },
    );
  }

  Widget buildAppBarTitle(){
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.gray),
    );
  }

  Widget buildNoInternetWidgets(){
    return  Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/noInternet.png"),
            const SizedBox(height: 20,),
            const Text(
              "Can\'t connect ... check your internet connection",
              style: TextStyle(fontSize: 16,color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.yellow,
        leading: isSearching? BackButton(color: MyColors.gray,):Container(),

        title: isSearching ? buildSearchField():buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidgets();
        }else{
          return buildNoInternetWidgets();
        }
      },
      child: const Center(
          child: CircularProgressIndicator(),
      ),
      ),
    );
  }
}
