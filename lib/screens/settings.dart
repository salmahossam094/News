import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/providers/my_provider.dart';
import 'package:news/shared/styles/app_colors.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static const String routeName = 'settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedValue = 1;
  int selectedValueth = 1;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings,
            style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: AppColor.lightColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             AppLocalizations.of(context)!.language,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColor.lightColor),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding:
                  const EdgeInsets.only(bottom: 4, top: 4, left: 10, right: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColor.lightColor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: pro.language == 'en' ? selectedValue = 1 : selectedValue = 2,
                  onTap: () {},
                  items: [
                    DropdownMenuItem(
                      onTap: () {
                        pro.changeLanguage('en');
                      },
                      value: 1,
                      child: Text(AppLocalizations.of(context)!.english),
                    ),
                    DropdownMenuItem(
                      onTap: () {
                        pro.changeLanguage('ar');
                      },
                      value: 2,
                      child: Text(AppLocalizations.of(context)!.arabic),
                    )
                  ],
                  onChanged: (value) {
                    selectedValue = value!;
                    setState(() {});
                  },
                ),
              ),
            ),
            Text(
             'Theme',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColor.lightColor),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding:
              const EdgeInsets.only(bottom: 4, top: 4, left: 10, right: 10),
              decoration:
              BoxDecoration(border: Border.all(color: AppColor.lightColor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: pro.mode == ThemeMode.light ? selectedValue = 1 : selectedValue = 2,
                  onTap: () {},
                  items: [
                    DropdownMenuItem(
                      onTap: () {
                        pro.changeTheme(ThemeMode.light);
                        setState(() {

                        });
                      },
                      value: 1,
                      child: Text('Light'),
                    ),
                    DropdownMenuItem(
                      onTap: () {
                        pro.changeTheme(ThemeMode.dark);
                        setState(() {

                        });
                      },
                      value: 2,
                      child: Text('Dark'),
                    )
                  ],
                  onChanged: (value) {
                    selectedValue = value!;
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
