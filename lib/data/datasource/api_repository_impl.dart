import 'package:animals_app/domain/exception/request_exception.dart';
import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/domain/response/breed_response.dart';
import 'package:animals_app/domain/response/image_response.dart';
import 'package:animals_app/domain/util/consts.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImp extends ApiRepositoryInterface {
  @override
  Future<List<BreedResponse>> getBreeds() async {
    final response = await http.get(Uri.parse('${Consts.url}breeds'));
    if (response.statusCode == 200) {
      return breedResponsesFromJson(response.body);
    } else {
      throw RequestException();
    }
  }

  @override
  Future<ImageResponse?> getImage(String idImage) async {
    final response = await http.get(Uri.parse('${Consts.url}images/$idImage'));
    if (response.statusCode == 200) {
      return imageResponseFromJson(response.body);
    } else {
      throw RequestException();
    }
  }

  @override
  Future<List<ImageResponse>> getImages(String idBreed) async {
    final response = await http.get(Uri.parse(
        '${Consts.url}images/search?limit=5&breed_ids=$idBreed&api_key=${Consts.apiCatKey}'));
    if (response.statusCode == 200) {
      return imageResponseListFromJson(response.body);
    } else {
      throw RequestException();
    }
  }

  @override
  Future<BreedResponse?> getBreed(String breed) async {
    final response = await http.get(Uri.parse('${Consts.url}breeds/$breed'));
    if (response.statusCode == 200) {
      if (response.body == 'INVALID_DATA') return null;
      return breedResponseFromJson(response.body);
    }if (response.statusCode == 400) {
      return null;
    } else  {
      throw RequestException();
    }
  }
}
