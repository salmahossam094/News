// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/screens/home/cubit/cubit.dart';
import 'package:news/screens/widgets/news_item.dart';
import 'package:news/screens/widgets/source_item.dart';

class TabsScreen extends StatelessWidget {
  TabsScreen(this.sources);

  List<Sources> sources;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: sources.length,
            child: TabBar(
                indicatorColor: Colors.transparent,
                isScrollable: true,
                onTap: (value) {
                  HomeCubit.get(context).changeSource(value);
                },
                tabs: sources
                    .map((source) => Tab(
                        child: SourceItem(
                            source,
                            sources.indexOf(source) ==
                                HomeCubit.get(context).selectedItem)))
                    .toList())),
        Expanded(
          child: ListView.builder(
            itemCount: HomeCubit.get(context).articles.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {

                    // Navigator.pushNamed(context, NewsDetails.routeName,
                    //     arguments: HomeCubit.get(context).articles[index]);
                    // setState(() {});
                    HomeCubit.get(context).NavigateToDetails(context);
                  },
                  child: NewsItem(HomeCubit.get(context).articles[index]));
            },
          ),
        ),

        // FutureBuilder(
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     if (snapshot.hasError) {
        //       return Column(
        //         children: [
        //           const Text('error'),
        //           ElevatedButton(onPressed: () {}, child: const Text('try again'))
        //         ],
        //       );
        //     }
        //     if (snapshot.data?.status != 'ok') {
        //       return Column(
        //         children: [
        //           const Text('error'),
        //           ElevatedButton(onPressed: () {}, child: const Text('try again'))
        //         ],
        //       );
        //     }
        //     var news = snapshot.data?.articles ?? [];
        //
        //     return Expanded(
        //       child: ListView.builder(
        //         itemCount: news.length,
        //         itemBuilder: (context, index) {
        //           return InkWell(
        //             onTap:() {
        //               Navigator.pushNamed(context, NewsDetails.routeName,arguments: news[index]);
        //               setState(() {
        //
        //               });
        //
        //             },
        //               child: NewsItem(news[index]));
        //         },
        //       ),
        //     );
        //   },
        //   future: ApiManager.getNewsData(widget.sources[selectedItem].id ?? ""),
        // )
      ],
    );
  }
}
