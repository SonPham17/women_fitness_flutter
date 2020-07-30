import 'package:flutter/material.dart';

class WorkOutRoutinesPage extends StatefulWidget {
  const WorkOutRoutinesPage();

  @override
  _WorkOutRoutinesPageState createState() => _WorkOutRoutinesPageState();
}

class _WorkOutRoutinesPageState extends State<WorkOutRoutinesPage>
    with AutomaticKeepAliveClientMixin<WorkOutRoutinesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'routines',
        ),
      ),
    );
  }
}
