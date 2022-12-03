import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/user_logic/cubit.dart';
import '../../business_logic/user_logic/states.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/string_manager.dart';
import '../resources/value_manager.dart';

class RegisterScreen extends StatelessWidget {
  var UserController = TextEditingController();
  var PhoneController = TextEditingController();
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is createUserSuccessState) {
          Navigator.pushNamed(context, Routes.homeScreenLayoutRoute);
        }
      },
      builder: (context, state) {
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'SIGN',
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
                      height: AppSize.s60,
                    ),
                    defaultTextFormField(
                      type: TextInputType.emailAddress,
                      controller: UserController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'UserName can not be empty';
                        }
                      },
                      text: 'Name',
                      predix_Icon: Icons.person,
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    defaultTextFormField(
                      type: TextInputType.emailAddress,
                      controller: EmailController,
                      on_saved: (value) {},
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'UserName can not be empty';
                        }
                      },
                      on_Tap: () {},
                      text: 'UserName',
                      predix_Icon: Icons.email,
                    ),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    defaultTextFormField(
                      type: TextInputType.phone,
                      controller: PhoneController,
                      validate: (value) {
                        if (value == null || value.isEmpty)
                          return 'Phone can not be empty';
                      },
                      text: 'Phone',
                      predix_Icon: Icons.phone_android_outlined,
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
                      ispassword: UserCubit.get(context).isShow,
                      Suffix_Function: () {
                        UserCubit.get(context).isShowFunction();
                      },
                      on_saved: (value) {},
                      on_Tap: () {},
                    ),
                    SizedBox(
                      height: AppSize.s40,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) => defaultButton(
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.primaryDarkColor
                            : ColorManager.primaryColor,
                        function: () {
                          if (formkey.currentState!.validate()) {
                            UserCubit.get(context).signUpUsingFirebase(
                              name: UserController.text.trim(),
                              email: EmailController.text.trim(),
                              phone: PhoneController.text.trim(),
                              password: PasswordController.text,
                            );
                            print(UserController.text);
                            print(PasswordController.text);
                            print(PhoneController.text);
                            print(EmailController.text);
                          }
                        },
                        text: 'Sign UP',
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.primaryDarkColor
                              : ColorManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s60,
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
                            AppStrings.loginString,
                            style: TextStyle(
                              color: ColorManager.myWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.loginRoute);
                            },
                            child: Text(
                              'Log in',
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
      },
    );
  }
}
/*

 */
