import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompressionOptionCard extends StatelessWidget {
  const CompressionOptionCard(this.index, this.icon, this.title,
      this.description, this.isSelected, this.onClick,
      {super.key});

  final int index;
  final Icon icon;
  final String title;
  final String description;
  final bool isSelected;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations localizations = AppLocalizations.of(context)!;

    Color cardColor;

    if (isSelected) {
      cardColor = theme.colorScheme.primary;
    } else {
      cardColor = theme.colorScheme.surfaceDim;
    }

    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: cardColor),
          borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: icon,
        title: Text(title, style: theme.textTheme.displaySmall),
        subtitle: Text(title, style: theme.textTheme.bodySmall),
      ),
    );
  }
}
