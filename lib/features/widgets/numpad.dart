import 'package:flutter/material.dart';

import '../../app_data/app_data.dart';
import '../settings/settings_service.dart';

// ignore: must_be_immutable
class NumPad extends StatefulWidget {
  final TextEditingController numberCode;
  final Color? bgButtonColor;
  final Color? textButtonColor;
  final Function() goNext;
  final bool Function() checkOnFull;
  const NumPad({
    super.key,
    required this.numberCode,
    this.bgButtonColor,
    this.textButtonColor,
    required this.goNext,
    required this.checkOnFull,
  });

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  final SettingsService _settingsService = SettingsService();
  final List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  String errorText = '';
  int? selectedIndex;
  Color? _buttonColor;
  Color? _textColor;
  @override
  void initState() {
    _buttonColor = widget.bgButtonColor ?? AppData.colors.middlePurple;
    _textColor = widget.textButtonColor ?? AppData.colors.middlePurple;
    super.initState();
  }

  bool checkPassword() {
    if (_settingsService.getPassCode() != null) {
      return _settingsService.getPassCode()! == widget.numberCode.text;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 40,
                width: 40,
                decoration: widget.numberCode.text.length > index
                    ? null
                    : BoxDecoration(
                        border: Border.all(
                          color: widget.numberCode.text.length == index
                              ? AppData.colors.middlePurple
                              : AppData.colors.lightPurple,
                          width: widget.numberCode.text.length == index ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                child: widget.numberCode.text.length <= index
                    ? const Text("")
                    : Center(
                        child: Text(
                          widget.numberCode.text[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: 6,
          ),
        ),
        Text(
          errorText,
          style: const TextStyle(color: Colors.red),
        ),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.25 / 1,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (BuildContext context, int index) => Container(
            margin: const EdgeInsets.all(4),
            width: 50,
            height: 50,
            child: index == 9
                ? null
                : TextButton(
                    onPressed: () {
                      setState(() {
                        widget.checkOnFull();
                        selectedIndex = index;
                        if (index == 11) {
                          if (widget.numberCode.text.isEmpty) {
                            return;
                          }
                          widget.numberCode.text = widget.numberCode.text
                              .substring(0, widget.numberCode.text.length - 1);
                        } else if (widget.numberCode.text.length > 5) {
                          widget.numberCode.text = widget.numberCode.text
                                  .substring(
                                      0, widget.numberCode.text.length - 1) +
                              numbers[index == 10 ? index - 1 : index]
                                  .toString();
                        } else {
                          widget.numberCode.text +=
                              numbers[index == 10 ? index - 1 : index]
                                  .toString();
                        }
                      });
                      setState(() {
                        _buttonColor = widget.bgButtonColor?.withOpacity(0.8) ??
                            AppData.colors.middlePurple.withOpacity(0.8);

                        _textColor = Colors.white;
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            _buttonColor = Colors.transparent;
                            _textColor = widget.textButtonColor ??
                                AppData.colors.middlePurple;
                          });
                        });
                      });
                      if (widget.numberCode.text.length == 6) {
                        setState(() {
                          if (!checkPassword()) {
                            errorText = "Password uncorrected";
                          } else {
                            errorText = ' ';
                          }
                        });
                      } else if (widget.numberCode.text.length < 6) {
                        errorText = ' ';
                      }
                      print(widget.numberCode.text);
                    },
                    style: selectedIndex != index
                        ? null
                        : ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(_buttonColor!),
                          ),
                    child: index == 11
                        ? Icon(
                            Icons.backspace_outlined,
                            color: selectedIndex == index
                                ? _textColor
                                : widget.textButtonColor ??
                                    AppData.colors.middlePurple,
                          )
                        : Text(
                            "${numbers[index == 10 ? index - 1 : index]}",
                            style: TextStyle(
                              fontSize: 25,
                              color: selectedIndex == index
                                  ? _textColor
                                  : widget.textButtonColor ??
                                      AppData.colors.middlePurple,
                            ),
                          ),
                  ),
          ),
          itemCount: 12,
        ),
      ],
    );
  }
}
