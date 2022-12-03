import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/states.dart';

import '../../data/service/data_local/shared_preferences.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDark
              : ColorManager.myWhite,
          body: Padding(

            padding: EdgeInsets.all(13.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Expanded(
                    child: Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 81,
                              backgroundColor: ColorManager.myWhite,
                              child: CircleAvatar(
                                radius: 80.0,
                                backgroundImage: HomeCubit.get(context).function(),
                              ),
                            ),
                            IconButton(
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.camera_alt_sharp,
                                ),
                              ),
                              onPressed: () {
                                HomeCubit.get(context).getImage();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          CashHelper.getData(key: 'name'),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: CashHelper.getData(key: 'isDark')
                                ? ColorManager.myWhite
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : Colors.black,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.editProfile);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Mode',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : Colors.black,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeMode();
                        },
                        icon: Icon(
                          Icons.brightness_6_outlined,
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.myWhite
                              : Colors.black,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Help&Support',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : Colors.black,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'LOG',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.primaryDarkColor
                            : ColorManager.primaryColor,
                      ),
                    ),
                    Text(
                      'OUT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : ColorManager.myGrey,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        HomeCubit.get(context).SignOut(context);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.myWhite
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
