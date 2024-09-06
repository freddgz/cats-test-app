import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/domain/response/breed_response.dart';
import 'package:animals_app/presentation/home/widgets/cat_bloc.dart';
import 'package:animals_app/presentation/home/widgets/label_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatCard extends StatelessWidget {
  // const CatCard(this.item, {super.key});
  final BreedResponse item;
  final Function() onTap;
  const CatCard._(this.item, this.onTap);
  static Widget init(
      BuildContext context, BreedResponse item, Function() onTap) {
    return ChangeNotifierProvider(
      create: (_) => CatBloc(
        item: item,
        apiRepository: context.read<ApiRepositoryInterface>(),
      )..init(),
      builder: (_, __) => CatCard._(item, onTap),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CatBloc>(context);
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: (bloc.item.urlImage != null)
          ? InkWell(
              onTap: () => onTap(),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: bloc.item.urlImage!,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelCard(
                          item.origin,
                          icon: Icons.location_on_outlined,
                        ),
                        LabelCard(item.firstTemperament),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: LabelCard(
                      item.name,
                      icon: Icons.badge_outlined,
                    ),
                  ),
                ],
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      //  Image.network(
      //   'https://placeimg.com/640/480/any',
      //   fit: BoxFit.fill,
      // ),

      // Column(
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(item.name),
      //         Text("More..."),
      //       ],
      //     ),
      //     if (bloc.imageCat != null)
      //       CachedNetworkImage(imageUrl: bloc.imageCat!.url),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(item.origin),
      //         Text(item.firstTemperament),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
