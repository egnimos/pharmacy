import 'package:flutter/material.dart';

class StepCardWidget extends StatelessWidget {
  final IconData iconData;
  final String leading;
  final String description;

  const StepCardWidget({
    required this.iconData,
    required this.leading,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              leading,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.green,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          //step count
          // const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(iconData),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                // softWrap: false,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  // color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
