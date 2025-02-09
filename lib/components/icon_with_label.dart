import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  const IconWithLabel(this.icon, this.label, this.onPressed, {super.key});

  final Icon icon;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Column(
        children: [
          icon,
          const SizedBox(height: 2.0),
          Text(label, style: theme.textTheme.headlineSmall)
        ],
      ),
    );
  }
}
