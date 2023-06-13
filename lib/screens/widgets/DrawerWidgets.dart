import 'package:flutter/material.dart';
import 'package:news/shared/styles/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  Function onCategoryDrawer;
  Function onSettingDrawer;

  DrawerWidget(this.onCategoryDrawer, this.onSettingDrawer);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .70,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .20,
            color: AppColor.lightColor,
            child: Center(
                child: Text(
              "News App",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white, fontSize: 24),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  onCategoryDrawer();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.list,
                      color: Colors.black,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Categories',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 0.8),
            child: TextButton(
                onPressed: () {
                  onSettingDrawer();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Settings',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
