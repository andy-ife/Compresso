import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomCompressionSizeDialog extends StatefulWidget {
  const CustomCompressionSizeDialog(
      this.controller, this.onUnitChanged, this.onConfirmClick,
      {super.key});

  final TextEditingController controller;
  final Function(dynamic value) onUnitChanged;
  final Function onConfirmClick;

  @override
  State<CustomCompressionSizeDialog> createState() =>
      _CustomCompressionSizeDialogState();
}

class _CustomCompressionSizeDialogState
    extends State<CustomCompressionSizeDialog> {
  String unit = 'KB';
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title:
          Text(localizations.customFileSize, style: theme.textTheme.bodyLarge),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: widget.controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: theme.textTheme.displayMedium,
            decoration: InputDecoration(
                constraints: const BoxConstraints(maxWidth: 160.0),
                fillColor: theme.colorScheme.surfaceDim,
                hintText: localizations.enterDesiredSize,
                hintStyle: theme.textTheme.labelMedium,
                filled: true),
          ),
          DropdownButton(
              value: unit,
              items: const [
                DropdownMenuItem(
                  value: 'KB',
                  child: Text('KB'),
                ),
                DropdownMenuItem(value: 'MB', child: Text('MB')),
              ],
              onChanged: (value) {
                widget.onUnitChanged(value);
                setState(() {
                  unit = value!;
                });
              })
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.onConfirmClick();
            },
            style: ButtonStyle(
              textStyle: WidgetStatePropertyAll(theme.textTheme.displaySmall),
              backgroundColor:
                  WidgetStatePropertyAll(theme.colorScheme.primaryContainer),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              elevation: const WidgetStatePropertyAll(2.0),
            ),
            child: Text(localizations.compress))
      ],
    );
  }
}
