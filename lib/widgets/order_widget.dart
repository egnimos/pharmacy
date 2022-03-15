import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';
import '../screens/MyOrders/my_order_detail.dart';
import '../theme/color_theme.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  const OrderWidget({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productDetail = myOrders[i]['invoices'][0];
    final DateTime now = DateTime.parse(order.createdAt);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyOrderDetail(
              id: order.orderId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: AppColor.fontColor, width: 0.3),
          // color: AppColor.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //order ID
            Text(
              '#${order.orderId}',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            //order date
            Text(
              formatted,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16.0),
            //total items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.qtyTotal.toString()} items',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                //order total
                RichText(
                  text: TextSpan(
                    text: "₹ ",
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: order.orderTotal,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fontColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 2.0),
            //payment mode
            Text(
              'Payment Mode: ' + order.paymentMethod,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            //product details

            //divider
            const Divider(
              endIndent: 10.0,
              indent: 10.0,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //order status
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColor.greenColor,
                      width: 2.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: AppColor.greenColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Track Order",
                    style: TextStyle(
                      color: AppColor.greenColor,
                    ),
                  ),
                ),
                //view details
                // TextButton.icon(
                //   onPressed: () {},
                //   icon: const Icon(
                //     Icons.file_copy,
                //     color: AppColor.appTheme,
                //   ),
                //   label: const Text(
                //     "View Details",
                //     style: TextStyle(
                //       color: AppColor.greenColor,
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Row(
//                   children: [
//                     Text(
//                       'Amount: ',
//                       maxLines: 1,
//                       style: GoogleFonts.nunitoSans(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),

// {
//       "id": 22,
//       "inv_no": "1015",
//       "order_id": "15",
//       "qty": 1,
//       "variant_id": 0,
//       "simple_pro_id": 81,
//       "vender_id": 3,
//       "price": 83.18999999999999772626324556767940521240234375,
//       "discount": 0,
//       "tax_amount": "0.00",
//       "shipping": "0",
//       "handlingcharge": 0,
//       "status": "pending",
//       "local_pick": null,
//       "loc_deliv_date": null,
//       "created_at": "2022-03-12T10:32:41.000000Z",
//       "updated_at": "2022-03-12T10:32:41.000000Z",
//       "paid_to_seller": "NO",
//       "igst": null,
//       "sgst": null,
//       "cgst": null,
//       "deleted_at": null,
//       "tracking_id": "UGPPJYR72Q",
//       "gift_charge": 0,
//       "courier_channel": null,
//       "tracking_link": null,
//       "exp_delivery_date": null,
//       "cashback": null,
//       "type": null,
//       "remaning_amount": 0,
//       "rem_tax_amount": 0,
//       "variant": null,
//       "simple_product": {
//           "id": 81,
//           "product_name": {
//               "en": "Ketanov 10mg Tablet"
//           },
//           "slug": "ketanov-10mg-tablet",
//           "product_detail": {
//               "en": "<p>Ketanov 10mg Tablet</p>"
//           },
//           "category_id": 1,
//           "product_tags": "test,excel",
//           "price": 70.7049999999999982946974341757595539093017578125,
//           "offer_price": 83.18999999999999772626324556767940521240234375,
//           "tax": 10.5600000000000004973799150320701301097869873046875,
//           "tax_rate": 7.29000000000000003552713678800500929355621337890625,
//           "thumbnail": "ketanov-10mg.jpg",
//           "hover_thumbnail": "thumb.jpg",
//           "product_file": "",
//           "status": 1,
//           "stock": 4,
//           "min_order_qty": 1,
//           "store_id": 2,
//           "brand_id": 850,
//           "qty": 0,
//           "deleted_at": null,
//           "created_at": "-000001-11-30T00:00:00.000000Z",
//           "updated_at": "2022-02-27T05:43:37.000000Z",
//           "actual_offer_price": 69,
//           "actual_selling_price": 58.64999999999999857891452847979962825775146484375,
//           "commission_rate": 6.9000000000000003552713678800500929355621337890625,
//           "max_order_qty": 10,
//           "external_product_link": null,
//           "subcategory_id": 1,
//           "child_id": null,
//           "free_shipping": 1,
//           "featured": 1,
//           "cancel_avbl": 1,
//           "cod_avbl": 1,
//           "upd_pres": 0,
//           "return_avbl": 1,
//           "policy_id": 1,
//           "type": "simple_product",
//           "tax_name": "GST",
//           "key_features": {
//               "en": "<p>Ketanov 10mg Tablet</p>"
//           },
//           "model_no": "123",
//           "sku": "123",
//           "hsin": "123",
//           "360_image": null,
//           "sale_tag": null,
//           "sale_tag_color": "#000000",
//           "sale_tag_text_color": "#000000",
//           "pre_order": 0,
//           "preorder_type": null,
//           "partial_payment_per": null,
//           "product_avbl_date": null,
//           "size_chart": 0,
//           "other_cats": null,
//           "overview": null,
//           "usage_dosage": "Pain relief,",
//           "interactions": "Not Listed",
//           "side_effects": "Vomiting,Stomach pain/epigastric pain,Nausea,Indigestion,Diarrhea,Heartburn,Loss of appetite,",
//           "expert_advice": "Take this medicine in the dose and duration as advised by your doctor. Swallow it as a whole. Do not chew, crush or break it. Ketanov 10mg Tablet is to be taken with food.",
//           "not_to_use": "Not Listed",
//           "warning": "Not Listed",
//           "other_details": "Not Listed",
//           "composition": "Ketorolac (10mg),",
//           "type_of_sell": "10 tablets in 1 strip",
//           "prescription": 1
//       }
//   },
//   {
//       "id": 23,
//       "inv_no": "1015",
//       "order_id": "15",
//       "qty": 1,
//       "variant_id": 0,
//       "simple_pro_id": 60,
//       "vender_id": 3,
//       "price": 87.248999999999995225152815692126750946044921875,
//       "discount": 0,
//       "tax_amount": "0.00",
//       "shipping": "0",
//       "handlingcharge": 0,
//       "status": "pending",
//       "local_pick": null,
//       "loc_deliv_date": null,
//       "created_at": "2022-03-12T10:32:41.000000Z",
//       "updated_at": "2022-03-12T10:32:41.000000Z",
//       "paid_to_seller": "NO",
//       "igst": null,
//       "sgst": null,
//       "cgst": null,
//       "deleted_at": null,
//       "tracking_id": "ABTQJ5VSW9",
//       "gift_charge": 0,
//       "courier_channel": null,
//       "tracking_link": null,
//       "exp_delivery_date": null,
//       "cashback": null,
//       "type": null,
//       "remaning_amount": 0,
//       "rem_tax_amount": 0,
//       "variant": null,
//       "simple_product": {
//           "id": 60,
//           "product_name": {
//               "en": "Almox 500 Capsule"
//           },
//           "slug": "almox-500-capsule",
//           "product_detail": {
//               "en": "<p>Almox 500 Capsule</p>"
//           },
//           "category_id": 1,
//           "product_tags": "test,excel",
//           "price": 74.1680000000000063664629124104976654052734375,
//           "offer_price": 87.248999999999995225152815692126750946044921875,
//           "tax": 11.0299999999999993605115378159098327159881591796875,
//           "tax_rate": 7.95000000000000017763568394002504646778106689453125,
//           "thumbnail": "Almox-500.jpg",
//           "hover_thumbnail": "thumb.jpg",
//           "product_file": "",
//           "status": 1,
//           "stock": 6,
//           "min_order_qty": 1,
//           "store_id": 2,
//           "brand_id": 830,
//           "qty": 0,
//           "deleted_at": null,
//           "created_at": "-000001-11-30T00:00:00.000000Z",
//           "updated_at": "2022-02-27T05:50:47.000000Z",
//           "actual_offer_price": 72.090000000000003410605131648480892181396484375,
//           "actual_selling_price": 61.280000000000001136868377216160297393798828125,
//           "commission_rate": 7.208999999999999630517777404747903347015380859375,
//           "max_order_qty": 10,
//           "external_product_link": null,
//           "subcategory_id": 1,
//           "child_id": null,
//           "free_shipping": 1,
//           "featured": 1,
//           "cancel_avbl": 1,
//           "cod_avbl": 1,
//           "upd_pres": 0,
//           "return_avbl": 1,
//           "policy_id": 1,
//           "type": "simple_product",
//           "tax_name": "GST",
//           "key_features": {
//               "en": "<p>Almox 500 Capsule</p>"
//           },
//           "model_no": "123",
//           "sku": "123",
//           "hsin": "123",
//           "360_image": null,
//           "sale_tag": null,
//           "sale_tag_color": "#000000",
//           "sale_tag_text_color": "#000000",
//           "pre_order": 0,
//           "preorder_type": null,
//           "partial_payment_per": null,
//           "product_avbl_date": null,
//           "size_chart": 0,
//           "other_cats": null,
//           "overview": null,
//           "usage_dosage": "Bacterial infections,",
//           "interactions": "Not Listed",
//           "side_effects": "Rash,Vomiting,Allergic reaction,Nausea,Diarrhea,",
//           "expert_advice": "Take this medicine in the dose and duration as advised by your doctor. Do not chew, crush or break it. Almox 500 Capsule may be taken with or without food, but it is better to take it at a fixed time.",
//           "not_to_use": "Not Listed",
//           "warning": "Not Listed",
//           "other_details": "Not Listed",
//           "composition": "Amoxycillin (500mg),Amoxicillin,",
//           "type_of_sell": "10 capsules in 1 strip",
//           "prescription": 1
//       }
//   }
// ]
// }
