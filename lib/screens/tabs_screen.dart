// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/screens/widgets/news_item.dart';
import 'package:news/screens/widgets/source_item.dart';
import 'package:news/shared/network/remote/api_manager.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen(this.sources);

  List<Sources> sources;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: TabBar(
                indicatorColor: Colors.transparent,
                isScrollable: true,
                onTap: (value) {
                  selectedItem = value;
                  setState(() {});
                },
                tabs: widget.sources
                    .map((source) =>
                    Tab(
                        child: SourceItem(source,
                            widget.sources.indexOf(source) == selectedItem)))
                    .toList())),
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text('error'),
                  ElevatedButton(onPressed: () {}, child: Text('try again'))
                ],
              );
            }
            if (snapshot.data?.status != 'ok') {
              return Column(
                children: [
                  Text('error'),
                  ElevatedButton(onPressed: () {}, child: Text('try again'))
                ],
              );
            }
            var news = snapshot.data?.articles ?? [];

            return Expanded(
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap:() {
                      Navigator.pushNamed(context, NewsDetails.routeName,arguments: news[index]);
                      setState(() {

                      });

                    },
                      child: NewsItem(news[index]));
                },
              ),
            );
          },
          future: ApiManager.getNewsData(widget.sources[selectedItem].id ?? ""),
        )
      ],
    );
  }

}
