import 'package:flutter/material.dart';

import '../../app_data/app_data.dart';

// ignore: must_be_immutable
class NumPad extends StatefulWidget {
  final TextEditingController numberCode;
  final Color? bgButtonColor;
  final Color? textButtonColor;
  const NumPad({
    super.key,
    required this.numberCode,
    this.bgButtonColor,
    this.textButtonColor,
  });

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  final List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  int? selectedIndex;
  Color? _buttonColor;
  Color? _textColor;

  @override
  void initState() {
    _buttonColor = widget.bgButtonColor ?? AppData.colors.middlePurple;
    _textColor = widget.textButtonColor ?? AppData.colors.middlePurple;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                    selectedIndex = index;
                    if (index == 11) {
                      if (widget.numberCode.text.isEmpty) {
                        return;
                      }
                      widget.numberCode.text = widget.numberCode.text
                          .substring(0, widget.numberCode.text.length - 1);
                    } else if (widget.numberCode.text.length > 5) {
                      widget.numberCode.text = widget.numberCode.text
                              .substring(0, widget.numberCode.text.length - 1) +
                          numbers[index == 10 ? index - 1 : index].toString();
                    } else {
                      widget.numberCode.text +=
                          numbers[index == 10 ? index - 1 : index].toString();
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
    );
  }
}
