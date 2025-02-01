import 'package:flutter/material.dart';

class PhotoInfoCard extends StatelessWidget {
  const PhotoInfoCard({super.key, required this.title, required this.info});

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.labelSmall,
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          info,
          style: theme.textTheme.displaySmall,
        )
      ],
    );
  }
}
