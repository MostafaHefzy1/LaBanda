import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/states.dart';

import '../../data/service/data_local/shared_preferences.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class HomeScreenLayout extends StatelessWidget {
  const HomeScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if (CashHelper.getData(key: 'isDark') == null)
          CashHelper.saveData(key: 'isDark', value: false);
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDark
              : ColorManager.myWhite,
          appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: CashHelper.getData(key: 'isDark')
                    ? ColorManager.primaryDark
                    : ColorManager.myWhite,
                statusBarIconBrightness: CashHelper.getData(key: 'isDark')
                    ? Brightness.light
                    : Brightness.dark,
                statusBarBrightness: CashHelper.getData(key: 'isDark')
                    ? Brightness.dark
                    : Brightness.light),
            backgroundColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDark
                : ColorManager.myWhite,
            elevation: 0.0,
            title: Text(
              'LaBanda',
              style: TextStyle(
                color: CashHelper.getData(key: 'isDark')
                    ? ColorManager.primaryDarkColor
                    : ColorManager.primaryColor,
                fontSize: 25,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.searchScreenRoute);
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                  color: CashHelper.getData(key: 'isDark')
                      ? ColorManager.primaryDarkColor
                      : ColorManager.primaryColor,
                  iconSize: 28,
                ),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            iconSize: 30,
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              color: CashHelper.getData(key: 'isDark')
                  ? ColorManager.primaryDarkColor
                  : ColorManager.primaryColor,
            ),
            backgroundColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDark
                : ColorManager.myWhite,
            selectedLabelStyle: TextStyle(
              color: CashHelper.getData(key: 'isDark')
                  ? ColorManager.primaryDarkColor
                  : ColorManager.primaryColor,
            ),
            selectedItemColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDarkColor
                : ColorManager.primaryColor,
            unselectedItemColor: ColorManager.myGrey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  label: 'Home'),
              // BottomNavigationBarItem(
              //     icon:Icon(
              //       Icons.category_outlined,) ,
              //     label: 'Categories'
              // ) ,
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  label: 'Cart'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
                backgroundColor: CashHelper.getData(key: 'isDark')
                    ? ColorManager.primaryDarkColor
                    : ColorManager.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
