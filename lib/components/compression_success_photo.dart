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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.displaySmall),
        SizedBox(height: 8.0),
        Container(
          height: 300.0,
          color: theme.colorScheme.surfaceDim,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Image.file(
            file,
            semanticLabel: title,
            fit: BoxFit.contain,
          ),
        )
      ],
    );
  }
}
