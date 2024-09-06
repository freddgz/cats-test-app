import 'package:animals_app/domain/repository/api_repository.dart';
import 'package:animals_app/presentation/home/detail/detail_screen.dart';
import 'package:animals_app/presentation/home/home_bloc.dart';
import 'package:animals_app/presentation/home/widgets/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen._();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeBloc(
        apiRepository: context.read<ApiRepositoryInterface>(),
      )..init(),
      builder: (_, __) => const HomeScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = Provider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catbreeds"),
        actions: [
          IconButton(
              onPressed: () => bloc.clear(),
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextField(
              controller: bloc.textController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => bloc.buscar(value),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                hintText: 'Search',
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: bloc.mState == StateScreen.initial
                  ? ListView.builder(
                      itemCount: bloc.list.length,
                      itemBuilder: (_, i) {
                        final item = bloc.list[i];
                        return CatCard.init(context, item, () {
                          Navigator.push(
                            _,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen.init(context, item),
                            ),
                          );
                        });
                      },
                    )
                  : bloc.mState == StateScreen.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Center(
                          child: Text("No se encontró resultados"),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
