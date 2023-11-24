import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_strings.dart';

import '../shared/app_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildExclusionPopup(final BuildContext context) {
    final strings = AppStrings.of(context);

    return AlertDialog(
      title: Text(strings.delete),
      content: Text(strings.deleteDescription),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            strings.no,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            strings.yes,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const errorBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent));

    final mediaQuery = MediaQuery.of(context);
    final strings = AppStrings.of(context);

    return AppBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: mediaQuery.size.width * 0.8,
              height: mediaQuery.size.height * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(6.0, 48.0),
                  right: Radius.elliptical(6.0, 48.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: ListView.separated(
                  itemCount: 5,
                  separatorBuilder: (final context, final index) => const Divider(thickness: 2.0),
                  itemBuilder: (final context, final index) => Row(
                    children: [
                      const Expanded(
                        flex: 5,
                        child: Align(
                          child: Text(
                            'Texto Digitado 1',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.border_color),
                          iconSize: 36.0,
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (final context) => _buildExclusionPopup(context),
                            );
                          },
                          icon: const Icon(Icons.cancel),
                          iconSize: 36.0,
                          color: const Color(0xFFDC2F35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.08),
            TextFormField(
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Center(
                  child: Text(
                    strings.typeYourText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                errorStyle: const TextStyle(color: Colors.orangeAccent),
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
