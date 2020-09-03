import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/ad/ad_task.dart';
import 'package:women_fitness_flutter/ad/reward_listener.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/module/in_app_purchase/IAPPage.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DialogIAP extends StatefulWidget {
  final RewardListener rewardListener;

  DialogIAP({@required this.rewardListener});

  @override
  _DialogIAPState createState() => _DialogIAPState();
}

class _DialogIAPState extends State<DialogIAP>{
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            TextApp(
              content: S.current.iap_dialog_title,
              textColor: Colors.white,
              textAlign: TextAlign.center,
              size: 17,
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
              onPressed: () {
                AdTask.instance.loadRewardGoogle(widget.rewardListener);
                Navigator.of(context).pop();
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/advertising.svg",
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: TextApp(
                        content: S.current.iap_dialog_ads,
                        textColor: Colors.white,
                        size: 17,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: IAPPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              color: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/crown.svg",
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: TextApp(
                        content: S.current.iap_dialog_premium,
                        textColor: Colors.white,
                        size: 17,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: TextApp(
                    content: S.current.dialog_picker_cancel.toUpperCase(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
