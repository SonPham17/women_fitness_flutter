import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/size_config.dart';
import 'package:women_fitness_flutter/shared/widget/item_circle_challenge_week.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ChallengeWeekWidget extends StatefulWidget {
  final int week;
  final bool isWeekSelected;
  final List<WorkOut> listWorkOuts;
  final List<Section> listSections;
  final int dayFinish;

  ChallengeWeekWidget({
    @required this.week,
    @required this.isWeekSelected,
    @required this.listWorkOuts,
    @required this.listSections,
    @required this.dayFinish,
  });

  @override
  _ChallengeWeekWidgetState createState() => _ChallengeWeekWidgetState();
}

class _ChallengeWeekWidgetState extends State<ChallengeWeekWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: widget.isWeekSelected ? AppColor.main : Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            TextApp(
              content:
                  '${S.current.challenge_week.toUpperCase()} ${widget.week}',
              textColor: widget.isWeekSelected ? AppColor.main : Colors.grey,
            ),
            Spacer(),
            Opacity(
              opacity: widget.isWeekSelected ? 1 : 0,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '${widget.dayFinish}',
                      style: TextStyle(
                        color: AppColor.main,
                      ),
                    ),
                    TextSpan(text: '/7'),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Opacity(
              opacity: widget.week == 4 ? 0 : 1,
              child: Container(
                margin: EdgeInsets.only(left: 12, top: 0),
                width: 1,
                height: 150,
                color: widget.isWeekSelected ? AppColor.main : Colors.grey,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[50],
                ),
                padding: EdgeInsets.only(
                    top: SizeConfig.defaultSize * 1.5,
                    left: SizeConfig.defaultSize,
                    right: SizeConfig.defaultSize,
                    bottom: SizeConfig.defaultSize * 1.5),
                margin: EdgeInsets.only(
                  left: SizeConfig.defaultSize * 2,
                  top: SizeConfig.defaultSize,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ItemCircleChallengeWeek(
                          listWorkOuts: widget.listWorkOuts,
                          day: 1,
                          section: widget.listSections[0],
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        ItemCircleChallengeWeek(
                          listWorkOuts: widget.listWorkOuts,
                          day: 2,
                          section: widget.listSections[1],
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        ItemCircleChallengeWeek(
                          listWorkOuts: widget.listWorkOuts,
                          day: 3,
                          section: widget.listSections[2],
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        ItemCircleChallengeWeek(
                          listWorkOuts: widget.listWorkOuts,
                          day: 4,
                          section: widget.listSections[3],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.defaultSize * 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ItemCircleChallengeWeek(
                          day: 5,
                          section: widget.listSections[4],
                          listWorkOuts: widget.listWorkOuts,
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        ItemCircleChallengeWeek(
                          listWorkOuts: widget.listWorkOuts,
                          day: 6,
                          section: widget.listSections[5],
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        ItemCircleChallengeWeek(
                          section: widget.listSections[6],
                          listWorkOuts: widget.listWorkOuts,
                          day: 7,
                        ),
                        Icon(Icons.keyboard_arrow_right),
                        SvgPicture.asset(
                          'assets/svg/trophy.svg',
                          width: 45,
                          height: 45,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
