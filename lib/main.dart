import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/admin_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/presentation/resources/color_manager.dart';
import 'package:labanda/presentation/resources/routes_manager.dart';
import 'package:labanda/presentation/show_screens/splash_screen.dart';

import 'business_logic/user_logic/cubit.dart';
import 'data/service/data_local/shared_preferences.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
        BlocProvider<HomeCubit>(
            create: (BuildContext context) =>
            HomeCubit()
              ..getProduct()
              ..getCategory()
              ..getBurgerProduct()
              ..getCrepeProduct()
              ..getMealsProduct()
              ..getSandwichesProduct()
              ..getWaffleProduct()
              ..getPastaProduct()
              ..getAllProductToCart()
        ),
        BlocProvider<AdminCubit>(
          create: (BuildContext context) => AdminCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }


}