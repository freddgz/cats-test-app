import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/domain/response/breed_response.dart';
import 'package:animals_app/presentation/home/detail/carousel_indicators.dart';
import 'package:animals_app/presentation/home/detail/carousel_item.dart';
import 'package:animals_app/presentation/home/detail/detail_bloc.dart';
import 'package:animals_app/presentation/home/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen._(this.item);
  final BreedResponse item;

  static Widget init(BuildContext context, BreedResponse item) {
    return ChangeNotifierProvider(
      create: (_) => DetailBloc(
        apiRepository: context.read<ApiRepositoryInterface>(),
        item: item,
      )..init(),
      builder: (_, __) => DetailScreen._(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DetailBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          CachedNetworkImage(imageUrl: item.urlImage!),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.altNames?.isNotEmpty ?? false)
                      Text(
                        item.altNames!,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    if (item.altNames?.isNotEmpty ?? false)
                      const SizedBox(height: 10),
                    Text(
                      item.description,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.origin,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: [
                        ...item.temperament.split(",").map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, bottom: 5),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    e,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                    if (bloc.imagenes != null)
                      CarouselSlider(
                        carouselController: bloc.controllerSlider,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              bloc.updateIndex(index);
                            }),
                        items: bloc.imagenes!
                            .map((item) => CarouselItem(item))
                            .toList(),
                      ),
                    bloc.imagenes == null
                        ? const Center(child: CircularProgressIndicator())
                        : bloc.imagenes!.isNotEmpty
                            ? CarouselIndicators(
                                imagenes: bloc.imagenes!,
                                index: bloc.currentIndex,
                                controller: bloc.controllerSlider,
                              )
                            : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
