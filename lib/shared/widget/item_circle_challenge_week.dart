import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/db/hive/challenge_week.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_page.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ItemCircleChallengeWeek extends StatefulWidget {
  final int day;
  final List<WorkOut> listWorkOuts;
  final Section section;

  ItemCircleChallengeWeek({
    @required this.day,
    @required this.listWorkOuts,
    @required this.section,
  });

  @override
  _ItemCircleChallengeWeekState createState() =>
      _ItemCircleChallengeWeekState();
}

class _ItemCircleChallengeWeekState extends State<ItemCircleChallengeWeek> {
  bool enable;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    var challengeBox = Hive.box('challenge_week');
    int lengthBox = challengeBox.length;
    if (challengeBox.get(widget.section.id) != null) {
      ChallengeWeek challengeWeek = challengeBox.get(widget.section.id);
      int indexChallenge = challengeWeek.index;
      if (indexChallenge<lengthBox-1) {
        isFinished = true;
      }
      enable = true;
    } else {
      enable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable
          ? () {
              pushNewScreenWithRouteSettings(
                context,
                screen: FavoriteTrainingPage(
                  section: widget.section,
                  listWorkOuts: widget.listWorkOuts,
                ),
                settings: RouteSettings(
                  name: '/training/favorite',
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }
          : null,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isFinished ? AppColor.main : Colors.transparent,
          border: Border.all(
            width: 1,
            color: enable ? AppColor.main : Colors.grey,
          ),
        ),
        child: Center(
          child: isFinished
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : TextApp(
                  content: '${widget.day}',
                  size: 18,
                  textColor: enable ? AppColor.main : Colors.grey,
                ),
        ),
      ),
    );
  }
}
