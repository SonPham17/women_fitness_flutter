import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';

class ScrollPicker extends StatefulWidget {
  ScrollPicker({
    Key key,
    @required this.items,
    @required this.initialValue,
    @required this.onChanged,
  })  : assert(items != null),
        super(key: key);

  // Events
  final ValueChanged<String> onChanged;

  // Variables
  final List<String> items;
  final String initialValue;

  @override
  _ScrollPickerState createState() => _ScrollPickerState(initialValue);
}

class _ScrollPickerState extends State<ScrollPicker> {
  _ScrollPickerState(this.selectedValue);

  // Constants
  static const double itemHeight = 50.0;

  // Variables
  double widgetHeight;
  int numberOfVisibleItems;
  int numberOfPaddingRows;
  double visibleItemsHeight;
  double offset;

  String selectedValue;

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    int initialItem = widget.items.indexOf(selectedValue);
    scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    TextStyle defaultStyle = themeData.textTheme.bodyText2;
    TextStyle selectedStyle =
    themeData.textTheme.headline5.copyWith(color: AppColor.main);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        widgetHeight = constraints.maxHeight;

        return Stack(
          children: <Widget>[
            GestureDetector(
              onTapUp: _itemTapped,
              child: ListWheelScrollView.useDelegate(
                childDelegate: ListWheelChildBuilderDelegate(
                    builder: (BuildContext context, int index) {
                      if (index < 0 || index > widget.items.length - 1) {
                        return null;
                      }

                      var value = widget.items[index];

                      final TextStyle itemStyle =
                      (value == selectedValue) ? selectedStyle : defaultStyle;

                      return Center(
                        child: Text(value, style: itemStyle),
                      );
                    }),
                controller: scrollController,
                itemExtent: itemHeight,
                onSelectedItemChanged: _onSelectedItemChanged,
                physics: FixedExtentScrollPhysics(),
              ),
            ),
            Center(
              child: Container(
                height: itemHeight,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.main, width: 0.5),
                    bottom:
                    BorderSide(color: AppColor.main, width: 0.5),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _itemTapped(TapUpDetails details) {
    Offset position = details.localPosition;
    double center = widgetHeight / 2;
    double changeBy = position.dy - center;
    double newPosition = scrollController.offset + changeBy;

    // animate to and center on the selected item
    scrollController.animateTo(newPosition,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _onSelectedItemChanged(int index) {
    String newValue = widget.items[index];
    if (newValue != selectedValue) {
      selectedValue = newValue;
      widget.onChanged(newValue);
    }
  }
}
