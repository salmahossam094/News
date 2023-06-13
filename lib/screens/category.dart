import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/screens/widgets/category_item.dart';

// ignore: must_be_immutable
class Category extends StatelessWidget {
  var categories = CategoryModel.getCategories();
  Function onCategorySelected;

  Category(this.onCategorySelected);

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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Pick your category of interest',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        onCategorySelected(categories[index]);
                      },
                      child: CategoryItem(categories[index], index)),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
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
