import 'package:flutter/material.dart';
import '../sektor_model.dart';
import 'sektor_item_widget.dart';

class SektorGrid extends StatelessWidget {
  final List<Sektor> sektorList;

  const SektorGrid({
    Key? key,
    required this.sektorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: sektorList.map((sektor) {
        return SizedBox(
          width: 80,
          child: SektorItemWidget(
            title: sektor.name,
            imagePath: sektor.imagePath,
            onTap: sektor.onTap,
          ),
        );
      }).toList(),
    );
  }
}