import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/admin_logic/cubit.dart';
import 'package:labanda/business_logic/admin_logic/states.dart';

import '../resources/color_manager.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.myWhite,
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            iconSize: 30,
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              color: ColorManager.primaryColor,
            ),
            backgroundColor: ColorManager.myWhite,
            selectedLabelStyle: TextStyle(
              color: ColorManager.primaryColor,
            ),
            selectedItemColor: ColorManager.primaryColor,
            unselectedItemColor: ColorManager.myGrey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.edit,
                  ),
                  label: 'Add'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.production_quantity_limits,
                ),
                label: 'Order',
                backgroundColor: ColorManager.primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
