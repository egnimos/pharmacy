import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final List _list = [
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            'Payment History',
            style: GoogleFonts.nunitoSans(
              color: AppColor.whiteColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: _list.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          // setBackToOrderQues(_list, index, "OrderPaymentDetail");
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Icon(
                                    Icons.account_balance,
                                    size: 35,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  textbold(_list[index]['market'].toString()),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              textbold(
                                  _list[index]['paymentMethod'].toString()),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _list[index]['currencySign'].toString() +
                                        '' +
                                        _list[index]['totalAmount'].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color:
                                            _list[index]['operator'] == 'credit'
                                                ? Colors.green
                                                : Colors.red),
                                    child: Text(
                                      _list[index]['operator'],
                                      style: const TextStyle(
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                               Text(
                                "Description : Payment done for the product",
                                style: GoogleFonts.nunitoSans(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget textbold(text) {
    return Text(
      text,
      maxLines: 1,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
    );
  }
}
