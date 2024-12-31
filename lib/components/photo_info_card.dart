import 'package:flutter/material.dart';

class PhotoInfoCard extends StatelessWidget {
  const PhotoInfoCard({super.key, required this.title, required this.info});

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          info,
          style: theme.textTheme.bodyMedium,
        )
      ],
    );
  }
}
