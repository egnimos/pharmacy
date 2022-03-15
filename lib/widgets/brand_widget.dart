import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/main.dart';
import 'package:pharmacy/models/brand.dart';
import 'package:pharmacy/services/brand_service.dart';
import 'package:provider/provider.dart';

import '../Screens/brand_products.dart';
import '../theme/color_theme.dart';

class BrandWidget extends StatelessWidget {
  final List<Brand> brands;

  const BrandWidget({
    required this.brands,
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
            'All Brands',
            textAlign: TextAlign.start,
            style: GoogleFonts.nunitoSans(
              color: AppColor.fontColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.only(right: 30, top: 15),
            itemCount: brands.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BrandProducts(
                        brandId: brands[i].id,
                        brandName: brands[i].name,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(65 / 2),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/appTheme.png",
                          image: "$brandImagePath/${brands[i].imageName}",
                          height: 65,
                          width: 65,
                          imageErrorBuilder: (_, __, ___) {
                            return Image.asset(
                              "assets/images/appTheme.png",
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                      // CircleAvatar(
                      //   backgroundColor: Colors.grey,
                      //   child: Image.network(
                      //     "$brandImagePath/${brands[i].imageName}",
                      //     height: 100,
                      //     width: 100,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: SizedBox(
                          width: 85,
                          child: Text(
                            brands[i].name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
