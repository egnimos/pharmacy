import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/screens/scheduled_your_test_screen.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../screens/MyCart/my_cart.dart';
import '../screens/notifications.dart';
import '../services/cart_service.dart';
import '../theme/color_theme.dart';

Widget cartButton(BuildContext context, Color color) {
  return IconButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyCart(),
        ),
      );
    },
    icon: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/icons/carticon.png',
          height: 30,
          color: color,
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Consumer<CartService>(
            builder: (context, cs, child) => cs.cartProducts.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child: Text(
                      cs.cartProducts.length.toString(),
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}

Widget notificationButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Notifications(),
        ),
      );
    },
    icon: Image.asset(
      'assets/icons/Path 4617@1X.png',
      height: 25,
      color: AppColor.appTheme,
    ),
  );
}

class AddToCartButton extends StatefulWidget {
  final Product product;
  const AddToCartButton({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isAddToCart = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (mounted) {
          setState(() {
            _isAddToCart = true;
          });
        }

        final cartProd = CartProduct(
          cartId: 0,
          productId: widget.product.productId,
          variantId: 0,
          simpleProductId: widget.product.productId,
          offInPercent: 0,
          productName: widget.product.productName,
          originaPrice: widget.product.mainPrice,
          originalOfferPrice: widget.product.offerPrice,
          mainPrice: widget.product.mainPrice,
          offerPrice: widget.product.offerPrice,
          quantity: 1,
          thumbnailPath: widget.product.thumbnailPath,
          thumbnail: widget.product.thumbnail,
          taxInfo: 0.0,
          soldBy: "unknown",
          currency: "INR",
        );
        await Provider.of<CartService>(context, listen: false)
            .addProductToCart(cartProd);
        if (mounted) {
          setState(() {
            _isAddToCart = false;
          });
        }
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: AppColor.orangeBtnColor,
        ),
        alignment: Alignment.center,
        child: _isAddToCart
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                'Add To Cart',
                style: GoogleFonts.nunitoSans(
                  color: AppColor.whiteColor,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}

class ScheduledYourTestButton extends StatefulWidget {
  final Product product;
  const ScheduledYourTestButton({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduledYourTestButton> createState() =>
      _ScheduledYourTestButtonState();
}

class _ScheduledYourTestButtonState extends State<ScheduledYourTestButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduledYourTest(
              product: widget.product,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: AppColor.orangeBtnColor,
        ),
        alignment: Alignment.center,
        child: Text(
          'scheduled test',
          style: GoogleFonts.nunitoSans(
            color: AppColor.whiteColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
