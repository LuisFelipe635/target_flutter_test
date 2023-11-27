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
  static const _cardBorderRadius = Radius.elliptical(6.0, 48.0);
  static const _cardWidthFactor = 0.8;
  static const _cardHeightFactor = 0.5;
  static const _listVerticalPadding = 8.0;
  static const _listHorizontalPadding = 8.0;
  static const _dividerThickness = 2.0;
  static const _mainContentFlex = 5;
  static const _maxTextLines = 1;
  static const _fontSize = 18.0;
  static const _iconSize = 36.0;
  static const _animationDuration = Duration(milliseconds: 100);
  static const _spacerHeightFactor = 0.08;
  static const _textFieldBorderRadius = BorderRadius.all(Radius.circular(8.0));

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  (bool, int) _existingDataEditionInformation = (false, 0);

  @override
  void initState() {
    super.initState();
    widget._presenter.retrieveStoredData.call();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _scrollController.dispose();
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

  void _submit(final String input) {
    if (_formKey.currentState?.validate() == true) {
      if (_existingDataEditionInformation.$1) {
        widget._presenter.save.call([input], {'isEdit': true, 'index': _existingDataEditionInformation.$2});
        _existingDataEditionInformation = (false, 0);
      } else {
        widget._presenter.save.call([input]);
      }
    }
    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    const errorBorder = OutlineInputBorder(borderSide: BorderSide(color: Colors.orangeAccent));

    final mediaQuery = MediaQuery.of(context);
    final strings = AppStrings.of(context);

    return AppBackground(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: mediaQuery.size.width * _cardWidthFactor,
              height: mediaQuery.size.height * _cardHeightFactor,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: _cardBorderRadius,
                  right: _cardBorderRadius,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: _listVerticalPadding,
                  horizontal: _listHorizontalPadding,
                ),
                child: Observer(
                  builder: (final context) => ListView.separated(
                    itemCount: widget._presenter.allData.length,
                    separatorBuilder: (final context, final index) => const Divider(thickness: _dividerThickness),
                    itemBuilder: (final context, final index) => Row(
                      children: [
                        Expanded(
                          flex: _mainContentFlex,
                          child: Center(
                            child: Text(
                              widget._presenter.allTexts[index] ?? '',
                              maxLines: _maxTextLines,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: _fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () {
                              _existingDataEditionInformation = (true, index);
                              _textController.text = widget._presenter.allTexts[index] ?? '';
                              _scrollController.animateTo(
                                mediaQuery.viewInsets.bottom,
                                duration: _animationDuration,
                                curve: Curves.linear,
                              );
                            },
                            icon: const Icon(Icons.border_color),
                            iconSize: _iconSize,
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
                            iconSize: _iconSize,
                            color: const Color(0xFFDC2F35),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * _spacerHeightFactor),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(borderRadius: _textFieldBorderRadius),
                  errorStyle: const TextStyle(color: Colors.orangeAccent),
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Center(
                    child: Text(
                      strings.typeYourText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _fontSize,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _validateInput,
                onFieldSubmitted: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
