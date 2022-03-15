import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../services/cart_service.dart';
import '../theme/color_theme.dart';

class CartProductWidget extends StatefulWidget {
  final CartProduct cartProduct;
  const CartProductWidget({
    required this.cartProduct,
    Key? key,
  }) : super(key: key);

  @override
  State<CartProductWidget> createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  bool _isDeleting = false;

  Widget quantityCounter(BuildContext context, CartProduct cartProd) {
    return Row(
      children: [
        //INCREMENT THE QUANTITY
        IconButton(
          padding: const EdgeInsets.all(1),
          onPressed: () async {
            //get the updated sub total
            final initSubTotal = double.parse(
                Provider.of<CartService>(context, listen: false)
                    .cartInf
                    .subTotal);
            final updatedSubTotal =
                double.parse(cartProd.originalOfferPrice) + initSubTotal;
            await Provider.of<CartService>(context, listen: false)
                .changeProductQuantity(
              cartId: cartProd.cartId,
              variantid: cartProd.variantId,
              qty: cartProd.quantity + 1,
              initialQty: cartProd.quantity,
              subTotal: updatedSubTotal,
              initialSubTotal: initSubTotal,
            );
          },
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.grey[700],
          ),
        ),
        Text(
          cartProd.quantity.toString(),
          style: GoogleFonts.nunitoSans(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColor.fontColor,
          ),
          maxLines: 2,
        ),
        //DECREMENT THE QUANTITY
        IconButton(
          padding: const EdgeInsets.only(left: 1),
          onPressed: () async {
            final initSubTotal = double.parse(
                Provider.of<CartService>(context, listen: false)
                    .cartInf
                    .subTotal);
            final updatedSubTotal =
                initSubTotal - double.parse(cartProd.originalOfferPrice);
            if (cartProd.quantity > 1) {
              await Provider.of<CartService>(context, listen: false)
                  .changeProductQuantity(
                cartId: cartProd.cartId,
                variantid: cartProd.variantId,
                qty: cartProd.quantity - 1,
                initialQty: cartProd.quantity,
                subTotal: updatedSubTotal,
                initialSubTotal: initSubTotal,
              );
            } else {
              updateState(true);
              await Provider.of<CartService>(context, listen: false)
                  .removeCartProduct(
                cartProd,
                initSubTotal,
              );
              updateState(false);
            }
          },
          icon: Icon(
            Icons.remove_circle_outline,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  void updateState(bool val) {
    if (mounted) {
      setState(() {
        _isDeleting = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 2.5,
          ),
        ),
        color: AppColor.whiteColor,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 70,
            child: Image.network(
              widget.cartProduct.thumbnailPath +
                  '/' +
                  widget.cartProduct.thumbnail,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.cartProduct.productName,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    _isDeleting
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () async {
                              updateState(true);
                              final initSubTotal = double.parse(
                                Provider.of<CartService>(context, listen: false)
                                    .cartInf
                                    .subTotal,
                              );
                              await Provider.of<CartService>(context,
                                      listen: false)
                                  .removeCartProduct(
                                widget.cartProduct,
                                initSubTotal,
                              );
                              updateState(false);
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹' + widget.cartProduct.originalOfferPrice.toString(),
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '₹' + widget.cartProduct.originaPrice.toString(),
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cartProduct.offInPercent.toString() +
                          '%OFF'.toString(),
                      style: GoogleFonts.nunitoSans(
                        fontSize: 15,
                        color: AppColor.appTheme,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                    ),

                    //PRODUCT QUANTITY COUNTER
                    quantityCounter(context, widget.cartProduct),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
