import 'package:flutter/material.dart';
import 'package:news/screens/widgets/search_widget.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => SearchWidget(query);

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Row(
      children: [

      ],
    );
  }
}
