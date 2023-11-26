import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../presenters/main_presenter.dart';
import '../shared/app_background.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required final MainPresenter presenter,
  }) : _presenter = presenter;

  final MainPresenter _presenter;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  (bool, int) _existingDataEditionInformation = (false, 0);

  @override
  void initState() {
    super.initState();
    widget._presenter.retrieveStoredData.call();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildExclusionPopup(final BuildContext context, final int dataIndex) {
    final strings = AppStrings.of(context);

    return AlertDialog(
      title: Text(strings.delete),
      content: Text(strings.deleteDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            strings.no,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            widget._presenter.deleteDataAtIndex.call([dataIndex]);
            Navigator.of(context).pop();
          },
          child: Text(
            strings.yes,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  String? _validateInput(final String? input) {
    return (input != null && input.isNotEmpty) ? null : AppStrings.of(context).typeYourTextError;
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
                child: Observer(
                  builder: (final context) => ListView.separated(
                    itemCount: widget._presenter.data.length,
                    separatorBuilder: (final context, final index) => const Divider(thickness: 2.0),
                    itemBuilder: (final context, final index) => Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(
                            child: Text(
                              widget._presenter.data[index] ?? '',
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
                            onPressed: () {
                              _existingDataEditionInformation = (true, index);
                              _textController.text = widget._presenter.data[index] ?? '';
                              _focusNode.requestFocus();
                            },
                            icon: const Icon(Icons.border_color),
                            iconSize: 36.0,
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (final context) => _buildExclusionPopup(context, index),
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
            ),
            SizedBox(height: mediaQuery.size.height * 0.08),
            TextFormField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                errorStyle: const TextStyle(color: Colors.orangeAccent),
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
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
              ),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateInput,
              onFieldSubmitted: (final input) {
                if (_existingDataEditionInformation.$1) {
                  widget._presenter.save.call([input], {'isEdit': true, 'index': _existingDataEditionInformation.$2 });
                  _existingDataEditionInformation = (false, 0);
                } else {
                  widget._presenter.save.call([input]);
                }

                _textController.clear();
                _focusNode.requestFocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}