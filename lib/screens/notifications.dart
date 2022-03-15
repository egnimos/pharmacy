import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/color_theme.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List notificationsData = [
    {
      'title': 'Payment Confirmed',
      'time': '23:43',
      'description': 'This is notification to confirm your payment'
    },
    {
      'title': 'Payment Success',
      'time': '1143',
      'description': 'This is notification to confirm your payment'
    },
    {
      'title': 'Payment Pending',
      'time': '04:43',
      'description': 'This is notification to confirm your payment'
    },
    {
      'title': 'Payment Confirmed',
      'time': '02:43',
      'description': 'This is notification to confirm your payment'
    },
    {
      'title': 'Payment Pending',
      'time': '19:43',
      'description': 'This is notification to confirm your payment'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.appTheme,
        title: Text(
          'Notifications',
          style: GoogleFonts.nunitoSans(
            fontSize: 18,
            color: AppColor.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 120),
            itemCount: notificationsData.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 15),
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: i == 2
                              ? Colors.purple
                              : i % 2 == 0
                                  ? AppColor.appTheme
                                  : Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.notifications,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notificationsData[i]['title'],
                                  maxLines: 2,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.fontColor,
                                  ),
                                ),

                                Text(
                                  notificationsData[i]['time'],
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              notificationsData[i]['description'],
                              maxLines: 2,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.fontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
