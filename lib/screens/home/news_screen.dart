import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/home/cubit/cubit.dart';
import 'package:news/screens/home/cubit/states.dart';
import 'package:news/screens/tabs_screen.dart';

class NewsScreen extends StatefulWidget {
  String id;

  NewsScreen(this.id);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/pattern.png',
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        BlocProvider(
          create: (context) => HomeCubit()..getSources(widget.id),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeGetSourcesLoadingState ||
                  state is HomeGetNewsLoadingState) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Center(
                        child: CircularProgressIndicator(
                      color: Colors.green,
                    )),
                  ),
                );
              }
              if (state is HomeGetSourcesErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error!"),
                    content: Text(state.error),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }
              if (state is HomeGetSourcesSuccessState) {
                HomeCubit.get(context).getNewsData();
              }
              if (state is HomeGetNewsErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error!"),
                    content: Text(state.error),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }
              if (state is HomeGetNewsSuccessState) {
                Navigator.pop(context);
              }
              if (state is HomeChangeSource) {
                HomeCubit.get(context).getNewsData();
              }

              if (state is HomeGetNewsDetailsLoadState) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    title: Center(
                        child: CircularProgressIndicator(
                      color: Colors.green,
                    )),
                  ),
                );
              }
              if (state is HomeGetNewsDetailsSuccessState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return TabsScreen(HomeCubit.get(context).sources);
            },
          ),
        )
        // FutureBuilder<SourceResponse>(
        //   future: ApiManager.getSources(widget.id),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Column(
        //         children: [
        //           Text(snapshot.error.toString()),
        //           ElevatedButton(onPressed: () {}, child: const Text('try again'))
        //         ],
        //       );
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     if (snapshot.data!.status != "ok") {
        //       return Column(
        //         children: [
        //           const Text('errorrr!'),
        //           Text(snapshot.data?.message??''
        //           ),
        //           ElevatedButton(onPressed: () {}, child: const Text('try again'))
        //         ],
        //       );
        //     }
        //     var sources = snapshot.data?.sources ?? [];
        //     return TabsScreen(sources);
        //   },
        // ),
      ],
    );
  }
}
