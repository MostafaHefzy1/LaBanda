import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/user_logic/cubit.dart';
import '../../business_logic/user_logic/states.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';
import '../resources/value_manager.dart';

class ForgetPasswordScreen extends StatelessWidget {
  var EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is forgetpasswordsucess) Navigator.pop(context);
    }, builder: (context, state) {
      return Scaffold(
        // backgroundColor:AppConstants.isDark?ColorManager.primaryDark : ColorManager.myWhite,

        appBar: AppBar(
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDarkColor
              : ColorManager.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              children: [
                Text(
                  AppStrings.forgetPasswordMassage,
                  style: TextStyle(
                    fontSize: 24,
                    color: CashHelper.getData(key: 'isDark')
                        ? ColorManager.myWhite
                        : Colors.black,
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
                ),
                Image(
                  image: AssetImage(
                    ImageAssets.forgetPasswprdImage,
                  ),
                ),
                SizedBox(
                  height: AppSize.s20,
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
                defaultButton(
                  color: CashHelper.getData(key: 'isDark')
                      ? ColorManager.primaryDarkColor
                      : ColorManager.primaryColor,
                  function: () {
                    UserCubit.get(context).resetUsingFirebase(
                      email: EmailController.text.trim(),
                    );
                  },
                  text: 'send',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
