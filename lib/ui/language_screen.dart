import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vingtun/widgets/appbar.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Choose Language')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SwitchListTileMenuItem(
                title: 'Russian',
                subtitle: 'Russian',
                locale:
                    context.supportedLocales[1] //BuildContext extension method
                ),
            _SwitchListTileMenuItem(
                title: 'English',
                subtitle: 'English',
                locale: context.supportedLocales[0]),
            _SwitchListTileMenuItem(
                title: 'Latvian',
                subtitle: 'Latvian',
                locale: context.supportedLocales[2]),
          ],
        ),
      ),
    );
  }
}

class _SwitchListTileMenuItem extends StatelessWidget {
  const _SwitchListTileMenuItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locale,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Locale locale;

  bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
        border: isSelected(context) ? Border.all(color: Colors.white) : null,
      ),
      child: ListTile(
          dense: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () async {
            log(locale.toString(), name: toString());
            await context.setLocale(locale);
          }),
    );
  }
}
