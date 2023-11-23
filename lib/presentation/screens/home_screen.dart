import 'package:flutter/material.dart';

import '../shared/app_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildExclusionPopup() {
    return AlertDialog(
      title: Text('Excluir'),
      content: Text('Tem certeza que deseja excluir? Esta ação não pode ser desfeita.'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'NÃO',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'SIM',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
                              builder: (final context) => _buildExclusionPopup(),
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
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Center(
                  child: Text(
                    'Digite seu texto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                errorStyle: TextStyle(color: Colors.orangeAccent),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
