import 'package:actorsapp/constants/colors.dart';
import 'package:actorsapp/data/models/charactersModel.dart';
import 'package:flutter/material.dart';
import '../screens/character_details.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.charactersModel});
  final CharactersModel charactersModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=> Navigator.of(context).push(
            MaterialPageRoute(
            builder: (context)=>CharactersDetails(charactersModel: charactersModel) )),
        child: GridTile(
          footer: Hero(
            tag: charactersModel.id!,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                "${charactersModel.name}",
                style: const TextStyle(
                    height: 1.3,
                    fontSize: 11,
                    color: MyColors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.gray,
            child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: charactersModel.image!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
