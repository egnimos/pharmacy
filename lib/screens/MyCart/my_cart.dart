import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/models/cart.dart';
import 'package:pharmacy/screens/Checkout/payment_detail_screen.dart';
import 'package:pharmacy/widgets/cart_empty_message_widget.dart';
import 'package:pharmacy/widgets/cart_payment_summary_widget.dart';
import 'package:pharmacy/widgets/cart_product_widget.dart';
import 'package:provider/provider.dart';
import '../../services/cart_service.dart';
import '../../theme/color_theme.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool isLoading = false;
  List<int> deletingId = [];
  bool isApply = false;
  bool isClear = false;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      Provider.of<CartService>(context, listen: false)
          .getCartProducts()
          .then((value) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget showCartItemsInfo(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 25,
          child: Text(
            '$count Items in your Cart',
            style: GoogleFonts.nunitoSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            if (mounted) {
              setState(() {
                isClear = true;
              });
            }
            await Provider.of<CartService>(context, listen: false).clearCart();
            if (mounted) {
              setState(() {
                isClear = false;
              });
            }
          },
          child: SizedBox(
            height: 25,
            child: isClear
                ? const CircularProgressIndicator()
                : Text(
                    'Clear Cart',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15.5,
                      color: AppColor.appTheme,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartInf = Provider.of<CartService>(context).cartInf;
    final cartProducts = Provider.of<CartService>(context).cartProducts;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'My Cart',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomSheet: CartBottomWidget(
        cartInf: cartInf,
        cartProducts: cartProducts,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: cartProducts.isEmpty
                    ? const CartEmptyMessageWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //CART ITEMS INFO
                          showCartItemsInfo(cartProducts.length),
                          //LIST OF CART PRODUCTS
                          ListView.builder(
                              shrinkWrap: true,
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              scrollDirection: Axis.vertical,
                              itemCount: cartProducts.length,
                              itemBuilder: (context, i) {
                                return CartProductWidget(
                                  cartProduct: cartProducts[i],
                                );
                              }),
                          SizedBox(
                            height: cartProducts.length == 1
                                ? 270
                                : cartProducts.length == 2
                                    ? 180
                                    : 30,
                          ),

                          //CART PAYMENT SUMMARY INFO
                          CartPaymentSummaryWidget(
                            cartInf: cartInf,
                          ),

                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}

//Cart Bottom Widget
class CartBottomWidget extends StatelessWidget {
  final List<CartProduct> cartProducts;
  final CartInfo cartInf;
  const CartBottomWidget({
    required this.cartInf,
    required this.cartProducts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.only(left: 25, right: 25),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, offset: const Offset(-4, -4))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total ' + cartInf.symbol + cartInf.grandTotal.toString(),
            style: GoogleFonts.nunitoSans(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            maxLines: 2,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDetailScreen(
                    qty: cartProducts.length.toString(),
                    total: cartInf.grandTotal.toString(),
                    subtotal: cartInf.subTotal.toString(),
                    symbol: cartInf.symbol.toString(),
                  ),
                ),
              );
            },
            child: Container(
              height: 47,
              padding: const EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: AppColor.appTheme,
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: Alignment.center,
              child: Text(
                'Checkout',
                style: GoogleFonts.nunitoSans(
                  color: AppColor.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
