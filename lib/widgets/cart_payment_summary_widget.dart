import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/models/cart.dart';

import '../constants/input_form_field.dart';
import '../theme/color_theme.dart';

class CartPaymentSummaryWidget extends StatelessWidget {
  final CartInfo cartInf;
  const CartPaymentSummaryWidget({
    required this.cartInf,
    Key? key,
  }) : super(key: key);

  Widget rowInfo({
    required String leading,
    required String trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$leading ',
          style: GoogleFonts.nunitoSans(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
          maxLines: 2,
        ),
        Text(
          trailing,
          style: GoogleFonts.nunitoSans(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: GoogleFonts.nunitoSans(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColor.fontColor,
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Sub Total ',
        //       style: GoogleFonts.nunitoSans(
        //         fontSize: 17,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.grey[700],
        //       ),
        //       maxLines: 2,
        //     ),
        //     Text(
        //       cartInf.symbol + cartInf.subTotal.toString(),
        //       style: GoogleFonts.nunitoSans(
        //         fontSize: 17,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.grey[700],
        //       ),
        //       maxLines: 2,
        //     ),
        //   ],
        // ),
        rowInfo(
          leading: 'Sub Total',
          trailing: cartInf.symbol + cartInf.subTotal.toString(),
        ),
        const SizedBox(height: 8),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       'Shipping ',
        //       style: GoogleFonts.nunitoSans(
        //         fontSize: 17,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.grey[700],
        //       ),
        //       maxLines: 2,
        //     ),
        //     Text(
        //       cartInf.symbol + cartInf.shipping.toString(),
        //       style: GoogleFonts.nunitoSans(
        //         fontSize: 17,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.grey[700],
        //       ),
        //       maxLines: 2,
        //     ),
        //   ],
        // ),
        rowInfo(
          leading: 'Shipping',
          trailing: cartInf.symbol + cartInf.shipping.toString(),
        ),
        const SizedBox(height: 8),
        rowInfo(
          leading: 'Coupon',
          trailing: cartInf.symbol + cartInf.couponDiscount.toString(),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: SizedBox(
                height: 70,
                child: CouponInput(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CouponInput extends StatefulWidget {
  const CouponInput({
    Key? key,
  }) : super(key: key);

  @override
  State<CouponInput> createState() => _CouponInputState();
}

class _CouponInputState extends State<CouponInput> {
  bool _isApply = false;

  @override
  Widget build(BuildContext context) {
    return AllInputDesign(
      labelText: _isApply ? 'You Saved 100' : 'Enter Coupon Code',
      suffixIcon: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: GestureDetector(
          onTap: () {
            if (mounted) {
              setState(() {
                _isApply = !_isApply;
              });
            }
          },
          child: Text(
            _isApply ? 'Edit' : 'Apply',
            style: const TextStyle(color: AppColor.appTheme),
          ),
        ),
      ),
      filledColor: AppColor.appTheme.withOpacity(0.15),
      prefixIcon: const Icon(Icons.confirmation_num_outlined),
      keyBoardType: TextInputType.number,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: AppColor.appTheme),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: AppColor.appTheme),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: AppColor.appTheme),
      ),
      inputborder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 2, color: AppColor.appTheme),
      ),
    );
  }
}
