import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_bloc.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_events.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class DialogItemWorkOut extends StatefulWidget {
  final WorkOut workOut;

  DialogItemWorkOut({
    @required this.workOut,
  });

  @override
  _DialogItemWorkOutState createState() => _DialogItemWorkOutState();
}

class _DialogItemWorkOutState extends State<DialogItemWorkOut> {
  FavoriteTrainingBloc favoriteTrainingBloc;

  @override
  void initState() {
    super.initState();
    favoriteTrainingBloc = Injector.resolve<FavoriteTrainingBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => favoriteTrainingBloc,
      child: BlocConsumer<FavoriteTrainingBloc, FavoriteTrainingState>(
        builder: (context, state) {
          print('build dialog ${state.runtimeType}');
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
            child: Container(
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/data/${widget.workOut.anim}_0.gif'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextApp(
                            content: widget.workOut.title.toUpperCase(),
                            textColor: Colors.black,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ),
                        Icon(
                          Icons.videocam,
                          color: AppColor.main,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: TextApp(
                        content: widget.workOut.description,
                        size: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.main,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (widget.workOut.timeDefault == 0) {
                                  widget.workOut.countDefault--;
                                } else {
                                  widget.workOut.timeDefault--;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: TextApp(
                                  content: '-',
                                  textColor: Colors.white,
                                  size: 30,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: TextApp(
                          content: widget.workOut.timeDefault == 0
                              ? '${widget.workOut.countDefault}'
                              : '00:${widget.workOut.timeDefault}',
                          fontWeight: FontWeight.bold,
                          size: 20,
                        ),
                      ),
                      Material(
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.main,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (widget.workOut.timeDefault == 0) {
                                  widget.workOut.countDefault++;
                                } else {
                                  widget.workOut.timeDefault++;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: TextApp(
                                  content: '+',
                                  textColor: Colors.white,
                                  size: 30,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () {
                              print('reset');
                              favoriteTrainingBloc.add(
                                FavoriteTrainingResetItemWorkOutEvent(
                                  workOut: widget.workOut,
                                ),
                              );
                            },
                            color: AppColor.main,
                            padding: EdgeInsets.all(10),
                            textColor: Colors.white,
                            child: TextApp(
                              content: 'RESET',
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () {
                              Navigator.of(context).pop(widget.workOut);
                            },
                            padding: EdgeInsets.all(10),
                            color: AppColor.main,
                            textColor: Colors.white,
                            child: TextApp(
                              content: 'SAVE',
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          print('listen ngoai dialog ${state.runtimeType}');
          if (state is FavoriteTrainingStateResetWorkOut) {
            print('listen dialog ${state.runtimeType}');
            setState(() {
              widget.workOut.timeDefault = state.workOut.timeDefault;
              widget.workOut.countDefault = state.workOut.countDefault;
            });
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
    favoriteTrainingBloc.close();
  }
}