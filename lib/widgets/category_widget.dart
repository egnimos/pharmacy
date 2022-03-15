import 'package:flutter/material.dart';
import 'package:pharmacy/models/category.dart';

import '../screens/Dashboard/view_category_products.dart';
import '../theme/color_theme.dart';

class Categories extends StatelessWidget {
  final String imagePath;
  final List<Category> categories;
  const Categories({
    required this.categories,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 25, right: 25),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return CategoryWidget(
            category: categories[i],
            imagePath: imagePath,
          );
        },
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final Category category;
  final String imagePath;
  const CategoryWidget({
    required this.category,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewCategoryProducts(
              catId: category.id,
              heading: category.title,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(65 / 2),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/appTheme.png",
                  image: "$imagePath/${category.iconImageName}",
                  height: 65,
                  width: 65,
                  imageErrorBuilder: (_, __, ___) {
                    return Image.asset(
                      "assets/images/appTheme.png",
                      fit: BoxFit.fill,
                      height: 65,
                      width: 65,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                category.title,
              ),
            ],
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

class CategoryBoxWidget extends StatelessWidget {
  final Category category;
  final String imagePath;
  const CategoryBoxWidget({
    required this.category,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewCategoryProducts(
              catId: category.id,
              heading: category.title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(65 / 2),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/appTheme.png",
                image: "$imagePath/${category.iconImageName}",
                height: 65,
                width: 65,
                imageErrorBuilder: (_, __, ___) {
                  return Image.asset(
                    "assets/images/appTheme.png",
                    fit: BoxFit.fill,
                    height: 65,
                    width: 65,
                  );
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                category.title,
              ),
            )
          ],
        ),
      ),
    );
  }
}
