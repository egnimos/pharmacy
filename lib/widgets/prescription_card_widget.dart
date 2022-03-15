import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/models/prescription.dart';

import '../screens/my_prescriptions.dart';

class PrescriptionCardWidget extends StatelessWidget {
  final List<Prescription> pres;
  const PrescriptionCardWidget({
    required this.pres,
    Key? key,
  }) : super(key: key);

  Widget topWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
          child: Text(
            "Uploaded",
            maxLines: 3,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
        ),
        // IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.delete_forever_outlined,
        //       color: Colors.red,
        //     ))
      ],
    );
  }

  Widget bottomWidget(Function() onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Submitted",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.green.shade800,
              fontSize: 14.6,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onTap,
          child: const Text(
            "view",
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            primary: Colors.green.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: ScrollController(keepScrollOffset: false),
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 55),
      itemCount: pres.length,
      itemBuilder: (context, i) {
        final DateTime now = DateTime.parse(pres[i].createdAt);

// final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
// if(aDate == today) {
//   ...
// } else if(aDate == yesterday) {
//   ...
// } else(aDate == tomorrow) {
//   ...
// }
        final DateFormat formatter = DateFormat('dd MMM yyyy ');
        final String formatDate = formatter.format(now);
        final String time = DateFormat().add_jm().format(now);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(14.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                // constraints: BoxConstraints.tight(const Size.square(100.0)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${pres[i].imageUriPath}${pres[i].imageName}"),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topWidget(),
                    Transform.translate(
                      offset: const Offset(0.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                            text: formatDate.toString(),
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: " $time",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.0,
                                ),
                              )
                            ]),
                        maxLines: 2,
                      ),
                    ),
                    // const SizedBox(height: 5),
                    // Text(
                    //   pres[i].name,
                    //   maxLines: 3,
                    //   style: const TextStyle(
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 17,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    bottomWidget(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenView(
                            img: "${pres[i].imageUriPath}${pres[i].imageName}",
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
