import 'package:flutter/material.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';

class CategoryLogo extends StatefulWidget {
  final Category category;
  const CategoryLogo({
    super.key,
    required this.category,
  });

  @override
  State<CategoryLogo> createState() => _CategoryLogoState();
}

class _CategoryLogoState extends State<CategoryLogo> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 20,
      maxRadius: 30,
      backgroundColor: Color(widget.category.color),
      child: Icon(
        IconData(
          widget.category.icon,
          fontFamily: 'MaterialIcons',
        ),
        color: Colors.white,
      ),
    );
  }
}
