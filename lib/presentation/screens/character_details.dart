import 'package:actorsapp/data/models/charactersModel.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class CharactersDetails extends StatelessWidget {
  const CharactersDetails({super.key, required this.charactersModel});
  final CharactersModel charactersModel;

  Widget buildSliverAppBar(){
    return SliverAppBar(
       expandedHeight:600 ,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.gray,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("${charactersModel.name}",
          maxLines: 1,
          style: const TextStyle(color: Colors.orange,fontSize: 14,fontWeight: FontWeight.bold),
        ),
        background: Hero(
          tag: charactersModel.id!,
          child: Image.network(charactersModel.image!,fit: BoxFit.cover,),
        ),
      ),
    );
  }

  Widget characterInfo(String title ,String value ){
   return RichText(
     maxLines: 1,
       overflow: TextOverflow.ellipsis,
       text: TextSpan(
           children: [
         TextSpan(
           text: title,
           style: const TextStyle(color: MyColors.white,fontWeight: FontWeight.bold,fontSize: 18),
         ),
             TextSpan(
               text: value,
               style: const TextStyle(color: MyColors.white,fontSize: 16),
             ),
       ],
       ),
   );
  }

  Widget buildDivider(double endIndent){
   return Divider(
     color: MyColors.yellow,
     height: 30,
     endIndent:endIndent ,
     thickness: 2,
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.gray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    characterInfo("location : " ,charactersModel.location!.name!),
                    buildDivider(300),

                    charactersModel.gender=="unknown"?Container():
                    characterInfo("gender : " ,charactersModel.gender!),
                    charactersModel.gender=="unknown"?Container():
                    buildDivider(310),

                    characterInfo("species : " ,charactersModel.species!),
                    buildDivider(305),

                    charactersModel.status=="unknown"?Container():
                    characterInfo("status : " ,charactersModel.status!),
                    charactersModel.status=="unknown"?Container():
                    buildDivider(320),

                    charactersModel.origin!.name=="unknown"? Container():
                    characterInfo("origin : " ,charactersModel.origin!.name!),
                    charactersModel.origin!.name=="unknown"? Container():
                    buildDivider(320),

                    charactersModel.type!.isEmpty? Container():
                    characterInfo("type : " ,charactersModel.type!),
                    charactersModel.type!.isEmpty? Container():
                    buildDivider(332),
                  ],
                ),
              ),
              const SizedBox(height: 600,),
            ]
          ),
          ),
        ],
      ),
    );
  }
}
