import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final List<Widget>? actions;

  const CustomDialog({
    Key? key,
    this.title,
    this.content,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (title != null)
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            if (content != null) const SizedBox(height: 16),
            if (content != null) Text(content ?? ''),
            const SizedBox(height: 24),
            ...(actions
                    ?.map((e) {
                      final result = <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: e,
                        )
                      ];
                      if ((actions?.indexOf(e) ?? 0) > 0) {
                        result.insert(0, const SizedBox(height: 8));
                      }
                      return result;
                    })
                    .expand((element) => element)
                    .toList() ??
                []),
          ]),
        ));
  }
}
