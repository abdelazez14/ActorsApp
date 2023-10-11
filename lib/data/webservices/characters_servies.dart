import 'package:dio/dio.dart';

class CharactersWebService {
  late Dio dio;

  CharactersWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://rickandmortyapi.com/api/",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
  }

  getAllCharacters() async {
    try {
      Response response = await dio.get("character");
      if (response.statusCode == 200) {
       // print(response);
        return response.data["results"];
      } else {
        print("Error: ---------------------------------");
        return null;
      }
    }  catch (e) {
      // Handle other unexpected errors
      print("Unexpected Error: =========================================$e");

    }
  }
}
