import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labanda/data/service/data_local/shared_preferences.dart';

import '../../../business_logic/user_logic/cubit.dart';
import '../../../business_logic/user_logic/states.dart';
import '../components/components_screens.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/value_manager.dart';

class LoginScreen extends StatelessWidget {
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is googleFailedState || state is LoginFailedState) {
        Center(
          child: LinearProgressIndicator(
            backgroundColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDarkColor
                : ColorManager.primaryColor,
          ),
        );
      }
      if (PasswordController.text == UserCubit.get(context).adminPassword &&
          EmailController.text == UserCubit.get(context).adminEmail) {
        Navigator.pushNamed(context, Routes.adminHomeRoute);
      } else if (state is LoginSuccessState) {
        CashHelper.saveData(key: 'token', value: state.uid).then((value) {
          Navigator.pushReplacementNamed(context, Routes.homeScreenLayoutRoute);
        });
      } else if (state is googleSuccessState) {
        CashHelper.saveData(key: 'token', value: state.uid).then((value) {
          Navigator.pushReplacementNamed(context, Routes.homeScreenLayoutRoute);
        });
      }
    }, builder: (context, state)
    {
      if (CashHelper.getData(key: 'isDark') == null)
        CashHelper.saveData(key: 'isDark', value: false);
      return Scaffold(
        backgroundColor: CashHelper.getData(key: 'isDark')
            ? ColorManager.primaryDark
            : ColorManager.myWhite,
        appBar: AppBar(
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDark
              : ColorManager.myWhite,
          elevation: 0.0,
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'LOG',
                        style: TextStyle(
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.primaryDarkColor
                              : ColorManager.primaryColor,
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      Text(
                        'IN',
                        style: TextStyle(
                          color: ColorManager.myGrey,
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s100,
                  ),
                  defaultTextFormField(
                    type: TextInputType.emailAddress,
                    controller: EmailController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'UserName can not be empty';
                      }
                    },
                    text: 'UserName',
                    predix_Icon: Icons.email,
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  defaultTextFormField(
                    type: TextInputType.visiblePassword,
                    controller: PasswordController,
                    validate: (value) {
                      if (value == null || value.isEmpty)
                        return 'Password can not be empty';
                    },
                    text: 'Password',
                    predix_Icon: Icons.lock,
                    Suffix_Icon: UserCubit.get(context).suffix,
                    Suffix_Function: () {
                      UserCubit.get(context).isShowFunction();
                    },
                    ispassword: UserCubit.get(context).isShow,
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                    },
                    child: Text(
                      AppStrings.forgetPassword,
                      style: TextStyle(
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.primaryDarkColor
                            : ColorManager.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  defaultButton(
                    color: CashHelper.getData(key: 'isDark')
                        ? ColorManager.primaryDarkColor
                        : ColorManager.primaryColor,
                    function: () {
                      if (formkey.currentState!.validate()) {
                        UserCubit.get(context).signInUsingFirebase(
                          email: EmailController.text,
                          password: PasswordController.text,
                        );
                      }
                    },
                    text: 'LOG IN',
                  ),
                  SizedBox(
                    height: AppSize.s20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          UserCubit.get(context).googleSignIn();
                        },
                        child: Image(
                          image: AssetImage(ImageAssets.googleLogo),
                        ),
                      ),
                      SizedBox(
                        width: AppSize.s12,
                      ),
                      InkWell(
                        onTap: () {
                          // UserCubit.get(context).signInWithFacebook() ;
                        },
                        child: Image(
                          image: AssetImage(ImageAssets.facebookLogo),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s100,
                  ),
                  Container(
                    height: 75,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CashHelper.getData(key: 'isDark')
                          ? ColorManager.primaryDarkColor
                          : ColorManager.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.registerString,
                          style: TextStyle(
                            color: ColorManager.myWhite,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: ColorManager.myWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
