import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/offer.dart';

class SliderWidget extends StatelessWidget {
  final List<Offer> offers;
  final String sliderPath;
  const SliderWidget({
    required this.sliderPath,
    required this.offers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: CarouselSlider(
        options: CarouselOptions(
            initialPage: 0,
            height: 150,
            enlargeCenterPage: true,
            reverse: false,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            onPageChanged: (index, reason) {}),
        items: offers
            .map(
              (offer) => ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/appTheme.png",
                    image: "$sliderPath/${offer.image}",
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
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
              ),
            )
            .toList(),
      ),
    );
  }
}

// Widget sliderList() {
//   return mSlidesModel == null
//       ? const SizedBox.shrink()
//       : 
// }
