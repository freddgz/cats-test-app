import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/domain/response/breed_response.dart';
import 'package:flutter/material.dart';

enum StateScreen { initial, empty, loading }

class HomeBloc extends ChangeNotifier {
  final ApiRepositoryInterface apiRepository;
  HomeBloc({required this.apiRepository});
  List<BreedResponse> list = [];
  TextEditingController textController = TextEditingController();
  StateScreen mState = StateScreen.initial;
  void init() {
    getBreeds();
  }

  void getBreeds() async {
    mState = StateScreen.loading;
    notifyListeners();
    list = await apiRepository.getBreeds();
    if (list.isEmpty) {
      mState = StateScreen.empty;
    } else {
      mState = StateScreen.initial;
    }
    notifyListeners();
  }

  void clear() {
    list.clear();
    textController.clear();
    notifyListeners();
    getBreeds();
  }

  void buscar(String breed) async {
    if (breed.isEmpty) {
      getBreeds();
      return;
    }
    print("buscar $breed");
    list.clear();
    mState = StateScreen.loading;
    notifyListeners();
    final item = await apiRepository.getBreed(breed);
    if (item != null) {
      mState = StateScreen.initial;
      list.add(item);
    } else {
      mState = StateScreen.empty;
    }
    notifyListeners();
  }
}
