import 'package:flutter/material.dart';

class PhotoInfoCard extends StatelessWidget {
  PhotoInfoCard({super.key, required this.dataType, required this.data});

  final String dataType;
  final String data;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dataType,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          data,
          style: theme.textTheme.bodyMedium,
        )
      ],
    );
  }
}
