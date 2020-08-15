import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_page.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ItemCircleChallengeWeek extends StatefulWidget {
  final int day;
  final List<WorkOut> listWorkOuts;
  final Section section;

  ItemCircleChallengeWeek({@required this.day,@required this.listWorkOuts,@required this.section});

  @override
  _ItemCircleChallengeWeekState createState() => _ItemCircleChallengeWeekState();
}

class _ItemCircleChallengeWeekState extends State<ItemCircleChallengeWeek> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.black54,
            )),
        child: Center(
          child: TextApp(
            content: '${widget.day}',
            size: 18,
          ),
        ),
      ),
    );
  }
}
