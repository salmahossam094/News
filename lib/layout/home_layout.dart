import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/screens/category.dart';
import 'package:news/screens/home/news_screen.dart';
import 'package:news/screens/settings.dart';
import 'package:news/screens/widgets/DrawerWidgets.dart';
import 'package:news/screens/widgets/search_delegate.dart';
import 'package:news/shared/styles/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static const String routeName = 'home-layout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var sController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/pattern.png',
          fit: BoxFit.fill,
          height: double.infinity,
        ),
        Scaffold(
          appBar: AppBar(
            title:  Text(categoryModel == null ? AppLocalizations.of(context)!.news : categoryModel!.name,
                    style: Theme.of(context).textTheme.bodyLarge),
            backgroundColor: AppColor.lightColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            actions: [
              categoryModel != null
                  ? IconButton(
                      onPressed: () {

                        showSearch(
                            context: context, delegate: MySearchDelegate());

                      },
                      icon:  const Icon(Icons.search))
                  : const Text('')
            ],
          ),
          drawer: DrawerWidget(onCategoryDrawer, onSettingDrawer),
          body: categoryModel == null
              ? Category(onCategorySelected)
              : NewsScreen(categoryModel!.id),
        ),
      ],
    );
  }

  CategoryModel? categoryModel;


  onCategorySelected(category) {
    categoryModel = category;
    setState(() {});
  }

  onCategoryDrawer() {
    categoryModel = null;
    Navigator.pop(context);
    setState(() {});
  }

  onSettingDrawer() {
    Navigator.pushNamed(context, Settings.routeName);
    setState(() {

    });
  }
// onSearchClicked(){
//   return SearchWidget();
// }

//
// onCategoryDrawer() {
//   categoryModel = null;
//   Navigator.pop(context);
//   setState(() {
//
//   });
//
// }
//

//
// onCategorySelected(category) {
//   categoryModel = category;
//   setState(() {});
// }
}
