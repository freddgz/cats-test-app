import 'package:animals_app/domain/response/breed_response.dart';
import 'package:animals_app/domain/response/image_response.dart';

abstract class ApiRepositoryInterface {
  Future<List<BreedResponse>> getBreeds();
  Future<BreedResponse?> getBreed(String breed);
  Future<ImageResponse?> getImage(String idImage);
  Future<List<ImageResponse>> getImages(String idBreed);
  // Future<LoginResponse> login(LoginRequest login);
  // Future<FileResponse> checkFile(String name);
}
