import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/NewsResponse.dart';

// ignore: must_be_immutable
class NewsItem extends StatelessWidget {
  Articles article;

  NewsItem(this.article);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  imageUrl: article.urlToImage ?? '',
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
                article.title ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize:14 ),
                maxLines: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                article.description ?? '',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                article.author ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10, color: Colors.black87),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  article.publishedAt?.substring(0, 10) ?? '',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10,color: Colors.black45),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
