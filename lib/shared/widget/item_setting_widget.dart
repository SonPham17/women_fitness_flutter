import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ItemSettingWidget extends StatefulWidget {
  final String title;
  final IconData iconData;

  ItemSettingWidget({@required this.title, @required this.iconData});

  @override
  _ItemSettingWidgetState createState() => _ItemSettingWidgetState();
}

class _ItemSettingWidgetState extends State<ItemSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print('');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55,
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                Icon(
                  widget.iconData,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: TextApp(
                      content: widget.title,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: TextApp(
                    content: '30 secs',
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
