import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/utils.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class BarChartFitness extends StatefulWidget {
  final String title;
  final String month;

  BarChartFitness({@required this.title, @required this.month});

  @override
  _BarChartFitnessState createState() => _BarChartFitnessState();
}

class _BarChartFitnessState extends State<BarChartFitness> {
  List<String> dayOfWeek;
  int controlWeek;

  @override
  void initState() {
    super.initState();
    dayOfWeek = Utils.getDaysOfWeek('en', 0);
    controlWeek = 0;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: const Color(0xff2c4260),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: TextApp(
                      content: widget.title,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 85, top: 10),
                      child: TextApp(
                        content: '${Utils.getYearFromControl(controlWeek)}',
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 5),
                    child: InkWell(
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          controlWeek += 7;
                          dayOfWeek = Utils.getDaysOfWeek('en', controlWeek);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: InkWell(
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          controlWeek -= 7;
                          dayOfWeek = Utils.getDaysOfWeek('en', controlWeek);
                        });
                      },
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceEvenly,
                      maxY: 501,
                      groupsSpace: 12,
                      barTouchData: BarTouchData(
                        enabled: false,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.transparent,
                          tooltipPadding: const EdgeInsets.all(0),
                          tooltipBottomMargin: 8,
                          fitInsideHorizontally: true,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return BarTooltipItem(
                              rod.y.round().toString(),
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                              color: const Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                          margin: 10,
                          rotateAngle: 0,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return dayOfWeek[0];
                              case 1:
                                return dayOfWeek[1];
                              case 2:
                                return dayOfWeek[2];
                              case 3:
                                return dayOfWeek[3];
                              case 4:
                                return dayOfWeek[4];
                              case 5:
                                return dayOfWeek[5];
                              case 6:
                                return dayOfWeek[6];
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 10),
                          rotateAngle: 45,
                          getTitles: (double value) {
                            if (value == 0) {
                              return '0';
                            }
                            return '${value.toInt()}';
                          },
                          interval: 100,
                          margin: 8,
                          reservedSize: 30,
                        ),
                        rightTitles: SideTitles(
                          showTitles: true,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 10),
                          rotateAngle: -225,
                          getTitles: (double value) {
                            if (value == 0) {
                              return '0';
                            }
                            return '${value.toInt()}';
                          },
                          interval: 100,
                          margin: 8,
                          reservedSize: 30,
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (value) {
                          if (value == 0) {
                            return true;
                          }
                          return value % 100 == 0;
                        },
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.white,
                            strokeWidth: 0.8,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(
                              y: 8, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(
                              y: 210, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(
                              y: 114, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                        BarChartGroupData(x: 3, barRods: [
                          BarChartRodData(
                              y: 315, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                        BarChartGroupData(x: 4, barRods: [
                          BarChartRodData(
                              y: 413, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                        BarChartGroupData(x: 5, barRods: [
                          BarChartRodData(
                              y: 210, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                        BarChartGroupData(x: 6, barRods: [
                          BarChartRodData(
                              y: 300, color: Colors.lightBlueAccent, width: 15)
                        ], showingTooltipIndicators: [
                          0
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
