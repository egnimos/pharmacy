import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pharmacy/widgets/step_card_widget.dart';

import '../../theme/color_theme.dart';

class AffiliatesScreen extends StatelessWidget {
  final String referCode;
  const AffiliatesScreen({
    this.referCode = "no-code",
    Key? key,
  }) : super(key: key);

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Dawa dodtor',
      text: 'hello user',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appTheme,
        title: const Text("Refer & Earn"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            //info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Refer a friend & earn 15% of their transaction fees forever",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            //referal code
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 22.0,
                  ),
                  child: Text(
                    "Your referal code",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 22.0,
                  ),
                  onPressed: () {
                    share();
                  },
                  icon: const Icon(
                    Icons.share,
                    // size: 16.0,
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 4.0,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey.shade100,
              ),
              child: Text(
                referCode,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            //how it works (Steps)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 26.0,
                  ),
                  child: Text(
                    "How it works?",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const StepCardWidget(
              iconData: Icons.login,
              leading: "Step 1",
              description: "Sign up with dawa doctor and get verified",
            ),
            const StepCardWidget(
              iconData: Icons.share,
              leading: "Step 2",
              description:
                  "Invite your friends to dawa doctor with your referal code",
            ),
            const StepCardWidget(
              iconData: Icons.calendar_month,
              leading: "Step 3",
              description: "start earning after they register and buy product",
            ),
          ],
        ),
      ),
    );
  }
}
