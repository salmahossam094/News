import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/models/category_model.dart';
import 'package:news/screens/widgets/category_item.dart';

// ignore: must_be_immutable
class Category extends StatelessWidget {
  Function onCategorySelected;

  Category(this.onCategorySelected);

  List<CategoryModel> categories = CategoryModel.getCategories();

  // late List<String> names;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/pattern.png',
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context)!.pick_your_category_of_interest,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        onCategorySelected(categories[index]);
                      },
                      child: CategoryItem(categories[index], index)),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
