import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/domain/response/breed_response.dart';
import 'package:flutter/material.dart';

class CatBloc extends ChangeNotifier {
  final ApiRepositoryInterface apiRepository;
  final BreedResponse item;
  CatBloc({
    required this.item,
    required this.apiRepository,
  });
  bool isDisposed = false;
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  void init() async {
    if (isDisposed) return;
    if (item.urlImage != null) return;
    if (item.referenceImageId != null) {
      // print('get=> apiRepository.getImage');
      final imageCat = await apiRepository.getImage(item.referenceImageId!);
      if (imageCat != null) {
        item.urlImage = imageCat.url;
      }
      if (!isDisposed) {
        notifyListeners();
      }
    }
  }
}
