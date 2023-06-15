import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            if (snapshot.data!.totalResults == 0) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.faceFrown,
                      size: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        AppLocalizations.of(context)!.sorry,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              );
            }
            var searchItems = snapshot.data?.articles ?? [];
            return Expanded(
              child: Column(
                children: [
                  Text(
                      '${AppLocalizations.of(context)!.total} ${searchItems.length}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, NewsDetails.routeName,
                                arguments: searchItems[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
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
                                        imageUrl: searchItems[index]
                                                .urlToImage ??
                                            'https://icon-library.com/images/no-image-icon/no-image-icon-0.jpg',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      searchItems[index].title ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontSize: 14,
                                              color: AppColor.lightColor),
                                      maxLines: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            searchItems[index].source?.name ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: Colors.grey),
                                          ),
                                          Spacer(),
                                          Text(
                                            searchItems[index]
                                                    .publishedAt
                                                    ?.substring(0, 10) ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    )
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
