import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

// ignore: must_be_immutable
class DialogSettingTime extends StatefulWidget {
  int time;
  bool isRestSet;

  DialogSettingTime({@required this.time, @required this.isRestSet});

  @override
  _DialogSettingTimeState createState() => _DialogSettingTimeState();
}

class _DialogSettingTimeState extends State<DialogSettingTime> {
//  int time = 30;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Container(
        height: 250,
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              content: widget.isRestSet
                  ? '${S.current.dialog_set_duration} (15 ~ 180 ${S.current.dialog_second})'
                  : '${S.current.dialog_set_duration} (10 ~ 30 ${S.current.dialog_second})',
              size: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          child: InkWell(
                            child: Icon(Icons.chevron_left),
                            onTap: () {
                              setState(() {
                                if (widget.isRestSet) {
                                  if (widget.time > 15) {
                                    widget.time--;
                                  }
                                } else {
                                  if (widget.time > 10) {
                                    widget.time--;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      TextApp(
                        content: widget.time > 59
                            ? Utils.convertSecondToTime(widget.time)
                            : '00:${widget.time}',
                        size: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          child: InkWell(
                            child: Icon(Icons.chevron_right),
                            onTap: () {
                              setState(() {
                                if (widget.isRestSet) {
                                  if (widget.time < 180) {
                                    widget.time++;
                                  }
                                } else {
                                  if (widget.time < 30) {
                                    widget.time++;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextApp(
                    content: S.current.dialog_second,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: TextApp(
                    content: S.current.dialog_picker_cancel.toUpperCase(),
                    textColor: AppColor.main,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(widget.time);
                  },
                  child: TextApp(
                    content: S.current.dialog_set.toUpperCase(),
                    textColor: AppColor.main,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
