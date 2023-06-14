import 'package:flutter/material.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/screens/tabs_screen.dart';
import 'package:news/shared/network/remote/api_manager.dart';

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
        FutureBuilder<SourceResponse>(
          future: ApiManager.getSources(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(snapshot.error.toString()),
                  ElevatedButton(onPressed: () {}, child: Text('try again'))
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.status != "ok") {
              return Column(
                children: [
                  Text('errorrr!'),
                  Text(snapshot.data?.message??''
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('try again'))
                ],
              );
            }
            var sources = snapshot.data?.sources ?? [];
            return TabsScreen(sources);
          },
        ),
      ],
    );
  }
}
