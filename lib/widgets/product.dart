import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/services/product_service.dart';
import 'package:provider/provider.dart';

import '../screens/Dashboard/product_details_screen.dart';
import '../theme/color_theme.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isInWishList = false;
  String format(double value) {
    final currencyFormatter = NumberFormat('#,##0', 'en_US');
    final priceGet = currencyFormatter.format(value);
    // var price = priceGet.replaceAll(',', '.00 ');
    return priceGet;
  }

  @override
  void initState() {
    setState(() {
      isInWishList = widget.product.isInWishList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              id: widget.product.productId,
              variantid: widget.product.variantId,
              from: 'dashboard',
              data: const [],
            ),
          ),
        );
      },
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () async {
                      if (mounted) {
                        setState(() {
                          isInWishList = !isInWishList;
                        });
                        await Provider.of<ProductService>(context,
                                listen: false)
                            .addProductToWishlist(
                          widget.product.productId,
                          widget.product.variantId,
                        );
                      }
                    },
                    child: isInWishList
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                          ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/appTheme.png",
                    image:
                        "${widget.product.thumbnailPath}/${widget.product.thumbnail}",
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    imageErrorBuilder: (_, __, ___) {
                      return Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/appTheme.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                widget.product.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                ),
                child: Text(
                  widget.product.typeOfSell,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            //PRODUCT PRICE TAGS
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.symbol.toString() +
                          '' +
                          format(double.parse(widget.product.offerPrice)),
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.product.symbol.toString() +
                          '' +
                          format(double.parse(widget.product.mainPrice)),
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.product.offPercent.toString() + '% OFF',
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
