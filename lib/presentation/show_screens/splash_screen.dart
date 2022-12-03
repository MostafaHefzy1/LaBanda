import 'dart:async';

import 'package:flutter/material.dart';
import 'package:labanda/data/service/data_local/shared_preferences.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startdelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    if (CashHelper.getData(key: 'onBoarding') != null) {
      if (CashHelper.getData(key: 'token') != null)
        Navigator.pushReplacementNamed(context, Routes.homeScreenLayoutRoute);
      else
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
    } else
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    _startdelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.myWhite,
      body: Center(
        child: Image(
          image:    "assets/images/splach screen.jpeg"
          // AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

//Important Note
/*
if(CashHelper.getData(key: 'onBoarding')!=null)
      {
        if(CashHelper.getData(key: 'token')!=null)
          Navigator.pushNamed(context, Routes.homeScreenLayoutRoute);
        else
          Navigator.pushNamed(context, Routes.loginRoute);

      }
    else
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
 */

/*
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);

 */
