import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labanda/business_logic/admin_logic/states.dart';
import 'package:labanda/presentation/components/components_screens.dart';
import 'package:labanda/presentation/resources/color_manager.dart';
import 'package:labanda/presentation/resources/value_manager.dart';

import '../../business_logic/admin_logic/cubit.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var imageController = TextEditingController();

  String? selectedValue;
  List<String> items = [
    'Crepe',
    'Burger',
    'Meals',
    'Pasta',
    'Sandwiches',
    'Waffle',
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is CreateProductSuccessState) {
          Fluttertoast.showToast(
              msg: "Order Upload",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 81,
                          backgroundColor: ColorManager.myWhite,
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundImage: cubit.function(),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            child: Icon(
                              Icons.camera_alt_sharp,
                            ),
                          ),
                          onPressed: () {
                            cubit.getImage();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      type: TextInputType.name,
                      controller: titleController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'title can not be empty';
                        }
                      },
                      text: 'Title',
                      predix_Icon: Icons.title,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      type: TextInputType.name,
                      controller: descriptionController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'description can not be empty';
                        }
                      },
                      text: 'Description',
                      predix_Icon: Icons.description,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      type: TextInputType.number,
                      controller: priceController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'price can not be empty';
                        }
                      },
                      text: 'price',
                      predix_Icon: Icons.price_change,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: CustomDropdownButton2(
                        hint: 'Select Item',
                        dropdownItems: items,
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    defaultButton(
                      text: 'uploading',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.uploadImage(
                            title: titleController.text.trim(),
                            numberCategory: selectedValue!,
                            description: descriptionController.text.trim(),
                            price: priceController.text,
                          );
                        }
                        Fluttertoast.showToast(
                            msg: "Upload Success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      color: ColorManager.primaryColor,
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
