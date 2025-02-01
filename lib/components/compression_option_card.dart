import 'package:flutter/material.dart';

class CompressionOptionCard extends StatelessWidget {
  const CompressionOptionCard(this.index, this.icon, this.title,
      this.description, this.isSelected, this.onTap,
      {super.key});

  final int index;
  final Icon icon;
  final String title;
  final String description;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Color cardColor;
    Color iconColor;

    if (isSelected) {
      cardColor = theme.colorScheme.primary;
      iconColor = theme.colorScheme.primary;
    } else {
      cardColor = theme.colorScheme.surfaceDim;
      iconColor = theme.colorScheme.onSurface;
    }

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 0.0,
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: cardColor),
            borderRadius: BorderRadius.circular(10.0)),
        child: ListTile(
          leading: icon,
          iconColor: iconColor,
          title: Text(title, style: theme.textTheme.displaySmall),
          subtitle: Text(description, style: theme.textTheme.bodySmall),
        ),
      ),
    );
  }
}
