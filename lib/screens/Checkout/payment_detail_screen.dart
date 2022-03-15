// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy/models/payment_info.dart';
import 'package:pharmacy/screens/Checkout/add_new_address.dart';
import 'package:pharmacy/services/address_service.dart';
import 'package:pharmacy/widgets/address_card_widget.dart';
import 'package:provider/provider.dart';

import '../../services/payment_service.dart';
import '../../theme/color_theme.dart';
import '../../widgets/modals.dart';
import '../../widgets/toast_widget.dart';

class PaymentDetailScreen extends StatefulWidget {
  final String qty;
  final String total;
  final String subtotal;
  final String symbol;
  const PaymentDetailScreen(
      {Key? key,
      required this.qty,
      required this.total,
      required this.subtotal,
      required this.symbol})
      : super(key: key);
  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  // ignore: prefer_typing_uninitialized_variables
  int? selectedId;
  // ignore: prefer_typing_uninitialized_variables
  var cardselect;
  bool isLoading = false;
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool _isInit = true;
  List payments = [
    {
      'image': 'assets/icons/credit-card-visa.png',
      'name': 'Debit Card',
      'add': 'end with 4356'
    },
    {
      'image': 'assets/icons/Group 527.png',
      'name': 'Pay Pal',
      'add': 'my@paypal.com'
    },
    {
      'image': 'assets/icons/credit-card-visa.png',
      'name': 'Credit Card',
      'add': 'XXXX-XXXX-4356'
    },
    {
      'image': 'assets/icons/ic_location.png',
      'name': 'Cash on Delivery',
      'add': '  '
    },
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (mounted) {
        setState(() {
          isLoading1 = true;
        });
      }
      Provider.of<AddressService>(context, listen: false)
          .getAddressList()
          .then((value) {
        if (mounted) {
          setState(() {
            isLoading1 = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _pullRefresh() async {
    Provider.of<AddressService>(context, listen: false).getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Payment Details',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomSheet: Container(
        height: 70,
        padding: const EdgeInsets.only(left: 25, right: 25),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () async {
            if (mounted) {
              setState(() {
                isLoading = true;
              });
            }
            if (selectedId == null || cardselect == null) {
              showToast(
                'Please select${selectedId == null ? ' Address ' : ''}${selectedId == null && cardselect == null ? 'and ' : ''}${cardselect == null ? ' Payment' : ''}',
              );
            } else {
              if (cardselect == 'Cash on Delivery') {
                final paymentInfo = PaymentInfo(
                  subTotal: widget.subtotal,
                  amount: widget.total,
                  paymentMethod: "COD",
                  selectedId: selectedId ?? 0,
                );
                await Provider.of<PaymentService>(context, listen: false)
                    .placeOrder(context, paymentInfo);
              } else {
                showModalForPaymentResult(context);
              }
            }
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: Container(
            height: 47,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
              color: AppColor.appTheme,
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Pay Now ${widget.symbol}${widget.total}',
                    style: GoogleFonts.nunitoSans(
                      color: AppColor.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: isLoading1
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.qty} Items in your Cart',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(children: [
                            Text(
                              'Total',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.total,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Delivery Address',
                        style: GoogleFonts.nunitoSans(
                          color: AppColor.fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Consumer<AddressService>(
                        builder: (ctx, anas, child) => anas.addresses.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                children: anas.addresses
                                    .map(
                                      (addr) => AddressCardWidget(
                                          selectedId: selectedId ?? 0,
                                          address: addr,
                                          select: (id) {
                                            setState(() {
                                              selectedId = id;
                                            });
                                          }),
                                    )
                                    .toList(),
                              ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddNewAddress(
                                  from: 'payment',
                                ),
                              ),
                            );
                            // if (result) {
                            //   _pullRefresh();
                            // }
                            // clearCart();
                          },
                          child: SizedBox(
                            height: 25,
                            child: Text(
                              '+Add new',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 15.5,
                                color: AppColor.appTheme,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Payment Method',
                        style: GoogleFonts.nunitoSans(
                          color: AppColor.fontColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (int k = 0; k < payments.length; k++) ...[
                        Container(
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 8),
                          // width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: ListTile(
                            leading: Image.asset(payments[k]['image']),
                            title: Text(payments[k]['name']),
                            subtitle: Text(payments[k]['add']),
                            onTap: () {
                              setState(() {
                                cardselect = payments[k]['name'];
                              });
                            },
                            trailing: cardselect == payments[k]['name']
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.circle,
                                  ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
