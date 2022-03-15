import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:pharmacy/models/payment_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/navigation_screen.dart';
import '../widgets/modals.dart';
import '../widgets/toast_widget.dart';

class PaymentService with ChangeNotifier {
  //place the order
  Future<void> placeOrder(BuildContext context, PaymentInfo info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('access_token');
    try {
      var request = await http.post(
        Uri.parse(
          'https://dawadoctor.co.in/public/api/confirm/order?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14&currency=INR',
        ),
        body: info.toJson(),
        headers: {
          'Authorization': 'Bearer $auth',
          'Cookie':
              'XSRF-TOKEN=eyJpdiI6InRXTmFUU2hscEdoWDJoVFZlUnN4UVE9PSIsInZhbHVlIjoiQzVGejVMNWFoN1cwbzAxbUJVNHVodDZOY1psYjU4NTYvZTBaSWc4K3BnTGt3Rk9wV0c4SUR4aTI1SWpKcVBMQVQ3NzRMUCtvYlNLZXdoekZ4dnVudUh5SFNaNGx5TGgrbjdwbmdPRXc2dzVOTGNnWUQwbVJPMkFFWVpNTW5BZE8iLCJtYWMiOiI0ODZlM2JlZWQ2ZDNmNmE3ZjhjNDM5M2EzNTlmNzliYTU4YjQzNDQ1MDg3NWNmYTYzZGFkOTUzODZhOGZiMTExIiwidGFnIjoiIn0%3D; dawadoctor_session=eyJpdiI6IlhBVHZrK1RkVHAyQVVrNTVmbktidHc9PSIsInZhbHVlIjoibnFSNlpEajNPSVE4M1RXSUdmc1JvRkhiN3YvZVFwSk9XaXI4REVrdmMxbFdZK00yU1B5YkhuMXBQaWh4eFNscUVvdGR5R1N4RlNqVTNYaEd5WW1MVTExRWN3cXhMU2h3V1JVVFB2eTRUZDhkWlpKNGFKQkROeDFWQ2tVWXdZcHEiLCJtYWMiOiI4ZGEzMGZiMDFkZWUxNzQ4ZGJhYTg1Y2FjOTM1YzliMzEwNWRmYTQ2YjAzOTBkMzBkOTM5NjlmYjY0ZTljOGQ1IiwidGFnIjoiIn0%3D'
        },
      );
      var response = json.decode(request.body);
      // print('sucess---- $body');
      print('sucess---- $response');
      if (request.statusCode == 200) {
        if (response['status'] == 'fail') {
          showToast(response['msg']);
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationPage(
                currentTab: 3,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        showToast(response['msg']);
      }
    } catch (error) {
      print('exception-- $error');
      showToast(error.toString());
    }
  }
}
