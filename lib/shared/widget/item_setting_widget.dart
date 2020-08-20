import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

class ItemSettingWidget extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Function function;
  final bool isShowTime;
  final String selection;

  ItemSettingWidget({
    @required this.title,
    @required this.iconData,
    this.function,
    this.isShowTime = false,
    this.selection = '',
  });

  @override
  _ItemSettingWidgetState createState() => _ItemSettingWidgetState();
}

class _ItemSettingWidgetState extends State<ItemSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
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
                  opacity: widget.isShowTime ? 1 : 0,
                  child: TextApp(
                    content: widget.selection,
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
