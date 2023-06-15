import 'package:flutter/material.dart';
import 'package:news/models/SourceResponse.dart';
import 'package:news/shared/styles/app_colors.dart';

// ignore: must_be_immutable
class SourceItem extends StatelessWidget {
  Sources source;
  bool selected;

  SourceItem(this.source, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:4,horizontal: 12),
      decoration: BoxDecoration(
        color: selected ? AppColor.lightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color:AppColor.lightColor, width: 2),
      ),
      child: Text(
        source.name ?? "",
        style: TextStyle(color: selected ? Colors.white : AppColor.lightColor),
      ),
    );
  }
}
