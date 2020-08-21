import 'package:flutter/material.dart';
import 'package:women_fitness_flutter/generated/l10n.dart';
import 'package:women_fitness_flutter/shared/app_color.dart';
import 'package:women_fitness_flutter/shared/widget/responsive_dialog.dart';
import 'package:women_fitness_flutter/shared/widget/scroll_picker.dart';

class DialogPicker extends StatefulWidget {
  final List<String> items;
  final String title;
  final String initValue;

  DialogPicker({this.items, this.title, this.initValue});

  @override
  _DialogPickerState createState() => _DialogPickerState();
}

class _DialogPickerState extends State<DialogPicker> {
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDialog(
      context: context,
      buttonTextColor: AppColor.main,
      confirmText: S.current.dialog_picker_ok.toUpperCase(),
      cancelText: S.current.dialog_picker_cancel.toUpperCase(),
      title: widget.title,
      child: ScrollPicker(
        items: widget.items,
        initialValue: widget.initValue,
        onChanged: (value) => setState(() => selectedItem = value),
      ),
      okPressed: () => Navigator.of(context).pop(selectedItem),
    );
  }
}
