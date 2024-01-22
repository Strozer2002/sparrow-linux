import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/app_data/app_data.dart';
import 'package:sparrow/features/widgets/custom_button.dart';

class WelcomeTxAppScreen extends StatefulWidget {
  const WelcomeTxAppScreen({super.key});

  @override
  State<WelcomeTxAppScreen> createState() => _WelcomeTxAppScreenState();
}

class _WelcomeTxAppScreenState extends State<WelcomeTxAppScreen> {
  @override
  void initState() {
    super.initState();
    go();
  }

  int selectScreen = 0;
  Future<void> go() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      context.go(AppData.routes.bankAccountScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            tileMode: TileMode.repeated,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Color.fromARGB(255, 206, 248, 248),
              Color.fromARGB(255, 206, 248, 248),
              Color.fromARGB(255, 206, 248, 248),
              Color.fromARGB(255, 206, 248, 248),
              Color.fromARGB(255, 151, 220, 252),
              Color.fromARGB(255, 143, 217, 252),
              Color.fromARGB(255, 123, 209, 248),
            ],
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppData.assets.image.sparrowIcon(width: 400),
            Text(
              selectScreen == 0
                  ? "Intuitive Design"
                  : "In-Depth Finance Monitoring",
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              selectScreen == 0
                  ? "App contemporary, user-friendly design that eases the burden of financial management, ensuring a relaxed user experience"
                  : "This application permits precistracking of financial activities over different intervals providing key insights into eamings and expenditute trends",
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            Container(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIcon(
                  onPressed: selectScreen == 0
                      ? null
                      : () => setState(() {
                            selectScreen = 0;
                          }),
                  child: const Text("Previous"),
                ),
                CustomIcon(
                  onPressed: selectScreen == 1
                      ? null
                      : () => setState(() {
                            selectScreen = 1;
                          }),
                  child: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
