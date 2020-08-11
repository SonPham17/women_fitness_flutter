import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class BarChartFitness extends StatefulWidget {
  final String title;
  final String month;

  BarChartFitness({@required this.title,@required this.month});

  @override
  _BarChartFitnessState createState() => _BarChartFitnessState();
}

class _BarChartFitnessState extends State<BarChartFitness> {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 85, top: 10),
                    child: TextApp(
                      content: 'thg 7, 2020',
                      textColor: Colors.white,
                    ),
                  ),
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
                                return 'Monday';
                              case 1:
                                return 'Te';
                              case 2:
                                return 'Wd';
                              case 3:
                                return 'Tu';
                              case 4:
                                return 'Fr';
                              case 5:
                                return 'St';
                              case 6:
                                return 'Sn';
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
                              y: 1, color: Colors.lightBlueAccent, width: 15)
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
