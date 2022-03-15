import 'package:flutter/material.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/widgets/product.dart';

import '../theme/color_theme.dart';

class ProductsWidget extends StatelessWidget {
  final String heading;
  final List<Product> products;
  const ProductsWidget({
    required this.heading,
    required this.products,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            heading,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColor.fontColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 4,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
          itemCount: products.length,
          itemBuilder: (context, i) {
            return ProductWidget(
              product: products[i],
            );
          },
        ),
      ],
    );
  }
}
