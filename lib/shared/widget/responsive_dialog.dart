import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_material_pickers/interfaces/common_dialog_properties.dart';
import 'package:women_fitness_flutter/shared/widget/text_app.dart';

const Duration _dialogSizeAnimationDuration = Duration(milliseconds: 200);

class ResponsiveDialog extends StatefulWidget
    implements ICommonDialogProperties {
  ResponsiveDialog({
    this.context,
    String title,
    Widget child,
    this.headerColor,
    this.headerTextColor,
    this.backgroundColor,
    this.buttonTextColor,
    this.forcePortrait = false,
    double maxLongSide,
    double maxShortSide,
    this.hideButtons = false,
    this.okPressed,
    this.cancelPressed,
    this.confirmText,
    this.cancelText,
  })  : title = title ?? "Title Here",
        child = child ?? Text("Content Here"),
        maxLongSide = maxLongSide ?? 400,
        maxShortSide = maxShortSide ?? 300;

  // Variables
  final BuildContext context;
  @override
  final String title;
  final Widget child;
  final bool forcePortrait;
  @override
  final Color headerColor;
  @override
  final Color headerTextColor;
  @override
  final Color backgroundColor;
  @override
  final Color buttonTextColor;
  @override
  final double maxLongSide;
  @override
  final double maxShortSide;
  final bool hideButtons;
  @override
  final String confirmText;
  @override
  final String cancelText;

  // Events
  final VoidCallback cancelPressed;
  final VoidCallback okPressed;

  @override
  _ResponsiveDialogState createState() => _ResponsiveDialogState();
}

class _ResponsiveDialogState extends State<ResponsiveDialog> {
  Color _backgroundColor;
  Color _buttonTextColor;

  Widget header(BuildContext context, Orientation orientation) {
    return Container(
      height: (orientation == Orientation.portrait)
          ? kPickerHeaderPortraitHeight
          : null,
      width: (orientation == Orientation.landscape)
          ? kPickerHeaderLandscapeWidth
          : null,
      child: Center(
        child: TextApp(
          content: widget.title,
          size: 20,
          textColor: Colors.black,
        ),
      ),
      padding: EdgeInsets.all(20.0),
    );
  }

  Widget actionBar(BuildContext context) {
    if (widget.hideButtons) return Container();

    var localizations = MaterialLocalizations.of(context);

    return Container(
      height: kDialogActionBarHeight,
      child: Container(
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              textColor: _buttonTextColor,
              child: TextApp(
                content: widget.cancelText ?? localizations.cancelButtonLabel,
                size: 20,
              ),
              onPressed: () => (widget.cancelPressed == null)
                  ? Navigator.of(context).pop()
                  : widget.cancelPressed(),
            ),
            FlatButton(
              textColor: _buttonTextColor,
              child: TextApp(
                content: widget.confirmText ?? localizations.okButtonLabel,
                size: 20,
              ),
              onPressed: () => (widget.okPressed == null)
                  ? Navigator.of(context).pop()
                  : widget.okPressed(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(context != null);

    var theme = Theme.of(context);
    _buttonTextColor = widget.buttonTextColor ?? theme.textTheme.button.color;
    _backgroundColor = widget.backgroundColor ?? theme.dialogBackgroundColor;

    final Orientation orientation = MediaQuery.of(context).orientation;

    // constrain the dialog from expanding to full screen
    final Size dialogSize = (orientation == Orientation.portrait)
        ? Size(widget.maxShortSide, widget.maxLongSide)
        : Size(widget.maxLongSide, widget.maxShortSide);

    return Dialog(
      backgroundColor: _backgroundColor,
      child: AnimatedContainer(
        width: dialogSize.width,
        height: dialogSize.height,
        duration: _dialogSizeAnimationDuration,
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            assert(orientation != null);
            assert(context != null);

            if (widget.forcePortrait) orientation = Orientation.portrait;

            switch (orientation) {
              case Orientation.portrait:
                return Column(
                  children: <Widget>[
                    header(context, orientation),
                    Expanded(
                      child: Container(
                        child: widget.child,
                      ),
                    ),
                    actionBar(context),
                  ],
                );
              case Orientation.landscape:
                return Row(
                  children: <Widget>[
                    header(context, orientation),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: widget.child,
                          ),
                          actionBar(context),
                        ],
                      ),
                    ),
                  ],
                );
            }
            return null;
          },
        ),
      ),
    );
  }
}
