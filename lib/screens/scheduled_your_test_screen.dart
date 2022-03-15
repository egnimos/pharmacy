import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pharmacy/models/product.dart';
import 'package:pharmacy/widgets/buttons_widget.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../services/cart_service.dart';
import '../theme/color_theme.dart';

class ScheduledYourTest extends StatefulWidget {
  final Product product;
  const ScheduledYourTest({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduledYourTest> createState() => _ScheduledYourTestState();
}

class _ScheduledYourTestState extends State<ScheduledYourTest> {
  List<String> dates = [
    "10:00 AM",
    "6:00 AM",
    "9:00 AM",
    "11:00 AM",
    "10:30 AM",
    "8:30 AM",
    "9:30 AM",
  ];
  List<Map<String, dynamic>> days = [
    {
      "day": "Monday",
      "icon": LineIcons.cloudWithSun,
    },
    {
      "day": "Evening",
      "icon": LineIcons.cloudWithMoon,
    },
  ];
  var selectedDateIndex;
  var selectedDayIndex;
  DateTime selectedDate = DateTime.now();
  bool _isAddToCart = false;

  //pick date & time
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  Widget timeCard(
    String text,
    int selectedIndex,
    int index,
  ) {
    return Stack(
      children: [
        //chip label
        Chip(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 12.0,
          ),
          backgroundColor: Colors.grey.shade50,
          side: BorderSide(
            color: selectedIndex == index ? AppColor.greenColor : Colors.grey,
            width: 2.0,
          ),
          label: SizedBox(
            // width: 90.0,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        //check icon
        if (selectedIndex == index)
          const Positioned(
            top: -2.0,
            left: -2.0,
            child: Icon(
              Icons.check_circle,
              color: AppColor.greenColor,
            ),
          ),
      ],
    );
  }

  Widget rowText({
    required IconData iconData,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Row(
        children: [
          //icon
          Icon(
            iconData,
            color: AppColor.greenColor,
          ),
          //text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Scheduled Your Time',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
        actions: [
          cartButton(context, Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15.0,
              ),
              //location
              rowText(
                iconData: Icons.location_on_rounded,
                text: "235 Square Street, NY",
              ),
              const SizedBox(
                height: 6.0,
              ),
              //test name
              rowText(
                iconData: Icons.local_hospital_rounded,
                text: widget.product.productName,
              ),
              const SizedBox(
                height: 30.0,
              ),
              //date & time
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    DateFormat()
                        .addPattern('d MMMM, EEEE')
                        .format(selectedDate),
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              //slots box
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < days.length; i++)
                    //morning
                    GestureDetector(
                      onTap: () {
                        print(days[i]["icon"].toString());
                        setState(() {
                          selectedDayIndex = i;
                        });
                      },
                      child: DaysBox(
                        day: days[i]["day"],
                        icon: days[i]["icon"],
                        index: i,
                        selectedIndex: selectedDayIndex,
                      ),
                    ),
                ],
              ),

              const SizedBox(
                height: 24.0,
              ),

              Align(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12.0,
                  runSpacing: 10.0,
                  children: [
                    for (var i = 0; i < dates.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = i;
                          });
                        },
                        child: timeCard(dates[i], selectedDateIndex, i),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 80.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
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
              margin: const EdgeInsets.only(bottom: 20.0),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26.0),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class DaysBox extends StatelessWidget {
  final String day;
  final IconData icon;
  final int selectedIndex;
  final int index;

  //days box
  const DaysBox({
    required this.index,
    required this.selectedIndex,
    required this.day,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      width: 155.0,
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedIndex == index
              ? AppColor.greenColor
              : Colors.grey.shade600,
          width: 1.8,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //icon
          Icon(
            icon,
            size: 22.0,
            color: selectedIndex == index
                ? AppColor.greenColor
                : Colors.grey.shade600,
          ),
          //text
          Flexible(
            child: Text(
              day,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: selectedIndex == index
                    ? AppColor.greenColor
                    : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
