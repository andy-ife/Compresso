import 'dart:io';

import 'package:flutter/material.dart';

class CompressionSuccessPhoto extends StatelessWidget {
  const CompressionSuccessPhoto(this.file, this.title, {super.key});

  final File file;
  final String title;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: theme.textTheme.displaySmall),
        const SizedBox(
          height: 8.0,
        ),
        Container(height: 200.0, child: Image.file(file))
      ],
    );
  }
}
