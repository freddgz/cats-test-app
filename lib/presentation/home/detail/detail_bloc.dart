import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/domain/response/breed_response.dart';
import 'package:animals_app/domain/response/image_response.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class DetailBloc extends ChangeNotifier {
  final ApiRepositoryInterface apiRepository;
  final BreedResponse item;

  DetailBloc({required this.apiRepository, required this.item});
  List<ImageResponse>? imagenes ;
  int currentIndex = 0;
  final CarouselSliderController controllerSlider = CarouselSliderController();
  void init() {
    loadImages();
  }

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void loadImages() async {
    imagenes = await apiRepository.getImages(item.id);
    notifyListeners();
  }
}
