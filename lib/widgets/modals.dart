import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/screens/my_prescriptions.dart';
import 'package:pharmacy/theme/color_theme.dart';
import 'package:pharmacy/widgets/search_cities_widget.dart';
import 'package:pharmacy/widgets/search_states_widget.dart';

import '../models/address.dart' as address;
import '../Screens/navigation_screen.dart';

void showModalForStates(
  BuildContext context, {
  required int countryId,
  required void Function(address.State value) selectedStateInfo,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SearchStatesWidget(
        countryId: countryId,
        selectedStateInfo: (value) {
          selectedStateInfo(value);
        },
      );
    },
  );
}

void showModalForCities(
  BuildContext context, {
  required int stateId,
  required void Function(address.City value) selectedCityInfo,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SearchCitiesWidget(
        stateId: stateId,
        selectedCityInfo: (value) {
          selectedCityInfo(value);
        },
      );
    },
  );
}

void showModalForPaymentResult(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          height: 350,
          child: Column(
            children: <Widget>[
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: AppColor.appTheme,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Thank You',
                style: TextStyle(
                  color: AppColor.fontColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Your order will be delivered with invoice #PQ4568907. You can track the delivery in the "Orders" Section.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationPage(
                        currentTab: 0,
                      ),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: AppColor.appTheme,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Continue Order',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(
                      currentTab: 2,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                ),
                child: const Text(
                  'Go to orders',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> alertForPrescription(BuildContext context) async {
  await showModal(
      context: context,
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 100),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: AppColor.appTheme,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Hooray!!',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Your Prescription is uploaded successfully, you can check it by clicking the below button',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyPrescriptions(),
                      ),
                    ),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: AppColor.appTheme,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'My Prescription',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
}
