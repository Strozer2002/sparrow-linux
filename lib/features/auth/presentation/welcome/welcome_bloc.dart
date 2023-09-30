import 'package:flutter/material.dart';
import 'package:rabby/features/auth/presentation/welcome/welcome.dart';

abstract class WelcomeBloc extends State<WelcomeScreen> {
  // selected screen (0,3)
  int selectedScreen = 0;

  // width for topNavigation
  double pickedWidth = 16;
  double unpickedWidth = 6;
}
