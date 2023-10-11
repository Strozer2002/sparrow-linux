import 'package:flutter/material.dart';
import 'package:rabby/app_data/app_data.dart';

import 'init_bloc.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends InitBloc {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: onImageClicked,
          child: AnimatedBuilder(
            animation: animation!,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: animation!.value * 2 * 3.14159265359,
                child: Transform.scale(
                  scale: animation!.value,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppData.colors.middlePurple.withOpacity(0.4),
                          blurRadius: animationBg!.value,
                          spreadRadius: animationBg!.value,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppData.colors.middlePurple,
                      radius: 90 * animation!.value,
                      child: AppData.assets.svg.rabbit(size: 100),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
