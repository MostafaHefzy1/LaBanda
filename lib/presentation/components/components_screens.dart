import 'dart:ui';

import 'package:flutter/material.dart';

import '../../data/model/product_model.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../resources/color_manager.dart';

// defaultTextFormField
Widget defaultTextFormField({
  required TextInputType type,
  required TextEditingController controller,
  required String? Function(String? val) validate,
  required String text,
  required IconData? predix_Icon,
  IconData? Suffix_Icon,
  bool ispassword = false,
  Function? Suffix_Function,
  Function? on_Tap,
  Function? on_saved,
}) =>
    TextFormField(
      onTap: () {
        on_Tap != null ? on_Tap() : '';
      },
      keyboardType: type,
      controller: controller,
      obscureText: ispassword,
      validator: (value) {
        return validate(value);
      },
      onSaved: (value) {
        on_saved!();
      },
      decoration: InputDecoration(
        fillColor: ColorManager.myWhite,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        hintText: '$text',
        prefixIcon: Icon(
          predix_Icon,
        ),
        prefixStyle: TextStyle(
          color: ColorManager.mypink,
        ),
        suffixIcon: Suffix_Icon != null
            ? IconButton(
                icon: Icon(Suffix_Icon),
                onPressed: () {
                  Suffix_Function!();
                },
              )
            : null,
      ),
    );

//defaultButton
Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: color,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          '${text.toUpperCase()}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultProductItem(ProductModel model) => Container(
      color: CashHelper.getData(key: 'isDark')
          ? ColorManager.primaryDark
          : ColorManager.myWhite,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image(
          image: NetworkImage(
            '${model.image}',
          ),
          width: double.infinity,
          height: 200.0,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '${model.title}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.3,
                color: CashHelper.getData(key: 'isDark')
                    ? ColorManager.myWhite
                    : Colors.black,
              ),
            ),
            Text(
              '${model.price}',
              style: TextStyle(
                fontSize: 12.0,
                color: CashHelper.getData(key: 'isDark')
                    ? ColorManager.primaryDarkColor
                    : ColorManager.primaryColor,
              ),
            ),
          ]),
        )
      ]),
    );
