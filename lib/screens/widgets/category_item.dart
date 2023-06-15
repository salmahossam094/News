import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index;

  CategoryItem(this.categoryModel,this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20), topLeft: const Radius.circular(20),
          bottomLeft: index.isEven?const Radius.circular(20):const Radius.circular(0),
         bottomRight:  index.isOdd?const Radius.circular(20):const Radius.circular(0),
        ),
        color: categoryModel.color,
      ),
      child: Column(
        children: [
          Image.asset(
            categoryModel.image,
            scale: 1.0,
            height: 100,
          ),
          Text(
            categoryModel.id,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
    );
  }
}
