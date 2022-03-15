import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/models/category.dart';
import 'package:pharmacy/widgets/category_widget.dart';

import '../../theme/color_theme.dart';

class ViewAllCategories extends StatelessWidget {
  final List<Category> categories;
  final String imagePath;
  final String heading;
  const ViewAllCategories({
    Key? key,
    required this.categories,
    required this.imagePath,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        title: Text(
          heading,
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColor.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.view_list,
              color: AppColor.whiteColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.7,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 4,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 25,
              ),
              itemCount: categories.length,
              itemBuilder: (context, i) {
                return CategoryBoxWidget(
                  category: categories[i],
                  imagePath: imagePath,
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
