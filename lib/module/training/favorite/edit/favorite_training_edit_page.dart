import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_fitness_flutter/injector/injector.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_bloc.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_events.dart';
import 'package:women_fitness_flutter/module/training/favorite/favorite_training_states.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/model/section.dart';
import 'package:women_fitness_flutter/shared/model/work_out.dart';
import 'package:women_fitness_flutter/shared/widget/dialog_item_workout.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class FavoriteTrainingEditPage extends StatefulWidget {
  final Section section;

  FavoriteTrainingEditPage({@required this.section});

  @override
  _FavoriteTrainingEditPageState createState() =>
      _FavoriteTrainingEditPageState();
}

class _FavoriteTrainingEditPageState extends State<FavoriteTrainingEditPage> {
  List<WorkOut> listWorkOutBySection;
  FavoriteTrainingBloc _favoriteTrainingBloc;
  WorkOut currentWorkOut;

  @override
  void initState() {
    super.initState();
    _favoriteTrainingBloc = Injector.resolve<FavoriteTrainingBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arg = ModalRoute.of(context).settings.arguments as Map;
    if (arg != null) {
      listWorkOutBySection = arg['data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteTrainingBloc>(
      create: (_) => _favoriteTrainingBloc,
      child: BlocConsumer<FavoriteTrainingBloc, FavoriteTrainingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: TextApp(
                content: 'EDIT PLAN',
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (value) {
                    _favoriteTrainingBloc
                        .add(FavoriteTrainingResetListWorkOutEvent(
                      section: widget.section,
                    ));
                  },
                  itemBuilder: (context) {
                    return {'RESET'}
                        .map(
                          (choice) => PopupMenuItem<String>(
                            value: choice,
                            child: TextApp(
                              content: choice,
                            ),
                          ),
                        )
                        .toList();
                  },
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ReorderableListView(
                      onReorder: _onReorder,
                      scrollDirection: Axis.vertical,
                      children: listWorkOutBySection
                          .map((workOut) => _buildItemWorkOut(workOut))
                          .toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FlatButton(
                      padding: EdgeInsets.all(10),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: AppColor.main,
                      onPressed: () {
                        Navigator.of(context).pop(listWorkOutBySection);
                      },
                      child: Center(
                        child: TextApp(
                          content: 'SAVE',
                          size: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is FavoriteTrainingStateResetListDone) {
            setState(() {
              listWorkOutBySection = state.listWorkOutReset;
            });
          }
        },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final WorkOut item = listWorkOutBySection.removeAt(oldIndex);
        listWorkOutBySection.insert(newIndex, item);
      },
    );
  }

  Widget _buildItemWorkOut(WorkOut workOut) => Container(
        key: Key('${listWorkOutBySection.indexOf(workOut)}'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: () {
                currentWorkOut = WorkOut.copyModel(workOut);
                showDialog(
                  context: context,
                  builder: (context) => DialogItemWorkOut(
                    workOut: currentWorkOut,
                  ),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      workOut.timeDefault = (value as WorkOut).timeDefault;
                      workOut.countDefault = (value as WorkOut).countDefault;
                    });
                  }
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'assets/data/${workOut.anim}_0.gif',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextApp(
                          content: workOut.title.toUpperCase(),
                          size: 19,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        TextApp(
                          content: workOut.timeDefault == 0
                              ? 'x${workOut.countDefault}'
                              : '00:${workOut.timeDefault}',
                          textColor: AppColor.main,
                          size: 17,
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _favoriteTrainingBloc.close();
  }
}
