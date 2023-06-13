import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/news_details.dart';
import 'package:news/shared/network/remote/api_manager.dart';
import 'package:news/shared/styles/app_colors.dart';

class SearchWidget extends StatelessWidget {
  String query;

  SearchWidget(this.query);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: ApiManager.search(query),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [Text('error')],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var searchItems = snapshot.data?.articles ?? [];
            return Expanded(
              child: Column(
                children: [
                  Text('Total results: ${searchItems.length}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchItems.length,
                      itemBuilder: (context, index) {
                        return  InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, NewsDetails.routeName,arguments: searchItems[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: CachedNetworkImage(
                                        height: 160,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                        imageUrl: searchItems[index].urlToImage ?? '',
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress.progress),
                                            ),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      searchItems[index].title ?? '',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize:14,color: AppColor.lightColor ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
