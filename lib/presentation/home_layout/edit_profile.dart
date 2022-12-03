import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/states.dart';

import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class EditProfile extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (CashHelper.getData(key: 'isDark') == null)
          CashHelper.saveData(key: 'isDark', value: false);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDark
                : ColorManager.myWhite,
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 24,
                color: CashHelper.getData(key: 'isDark')
                    ? ColorManager.myWhite
                    : Colors.black,
              ),
            ),
          ),
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDark
              : ColorManager.myWhite,
          body: Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    defaultTextFormField(
                      type: TextInputType.name,
                      controller: nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name can not be empty';
                        }
                      },
                      text: 'Name',
                      predix_Icon: Icons.person,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    defaultTextFormField(
                      type: TextInputType.name,
                      controller: addressController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Address can not be empty';
                        }
                      },
                      text: 'Address',
                      predix_Icon: Icons.home,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    defaultTextFormField(
                      type: TextInputType.number,
                      controller: phoneController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone can not be empty';
                        }
                      },
                      text: 'Phone',
                      predix_Icon: Icons.phone_android_outlined,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          {
                            CashHelper.saveData(
                                key: 'name', value: nameController.text.trim());
                            CashHelper.saveData(
                                key: 'phoneNumber',
                                value: phoneController.text);
                            CashHelper.saveData(
                                key: 'Address',
                                value: addressController.text.trim());
                          }
                          Navigator.pushNamed(
                              context, Routes.settingsScreenRoute);
                        }
                      },
                      text: 'Update',
                      width: 280,
                      color: CashHelper.getData(key: 'isDark')
                          ? ColorManager.primaryDarkColor
                          : ColorManager.primaryColor,
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
