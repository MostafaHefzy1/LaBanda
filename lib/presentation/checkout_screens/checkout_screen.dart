import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/home_logic/states.dart';

import '../../business_logic/home_logic/cubit.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class CheckOutScreen extends StatelessWidget {
  var userController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: CashHelper.getData(key: 'isDark')
                  ? ColorManager.primaryDark
                  : ColorManager.myWhite,
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultTextFormField(
                              type: TextInputType.text,
                              controller: userController,
                              validate: (value) {
                                if (value!.isEmpty) return 'User is not empty';
                              },
                              text: 'UserName',
                              predix_Icon: Icons.person,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                              type: TextInputType.number,
                              controller: phoneController,
                              validate: (value) {
                                if (value!.isEmpty) return 'Phone is not empty';
                              },
                              text: 'Phone',
                              predix_Icon: Icons.phone_android_outlined,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                              type: TextInputType.text,
                              controller: addressController,
                              validate: (value) {
                                if (value!.isEmpty)
                                  return 'Address is not empty';
                              },
                              text: 'Address',
                              predix_Icon: Icons.home,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${HomeCubit.get(context).latitude.abs()}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color:  CashHelper.getData(key: 'isDark')
                                                ? ColorManager.myWhite
                                                : ColorManager.primaryDark,
                                          ),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          '${HomeCubit.get(context).longitude.abs()}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color:  CashHelper.getData(key: 'isDark')
                                                ? ColorManager.myWhite
                                                : ColorManager.primaryDark,                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: defaultButton(
                                        function: () {
                                          HomeCubit.get(context)
                                              .getLatitudeAndLongitude();
                                        },
                                        width: 210,
                                        color:  CashHelper.getData(key: 'isDark')
                                            ? ColorManager.primaryDarkColor
                                            : ColorManager.primaryColor,
                                        text: 'Add Location'
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: defaultButton(
                            function: () {
                              if (formkey.currentState!.validate()
                                  &&
                                  HomeCubit.get(context).latitude != 0)
                              {
                                HomeCubit.get(context).name = userController.text;
                                HomeCubit.get(context).phone = phoneController.text;
                                HomeCubit.get(context).address = addressController.text;

                                Navigator.pushNamed(context, Routes.summaryScreen);
                              }
                            },
                            width: 150,
                           color:  CashHelper.getData(key: 'isDark')
                                ? ColorManager.primaryDarkColor
                                : ColorManager.primaryColor,
                            text: 'Next'),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
/**/
