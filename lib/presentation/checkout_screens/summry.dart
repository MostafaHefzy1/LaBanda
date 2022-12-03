import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/states.dart';

import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          height: 300,
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.primaryDark
                              : ColorManager.myWhite,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 180,
                                    child: Image.network(
                                      HomeCubit.get(context)
                                          .cartProductModel[index]
                                          .image
                                          .toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    HomeCubit.get(context)
                                        .cartProductModel[index]
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                      color: CashHelper.getData(key: 'isDark')
                                          ? ColorManager.myWhite
                                          : ColorManager.primaryDark,

                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    HomeCubit.get(context)
                                        .cartProductModel[index]
                                        .price
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: CashHelper.getData(key: 'isDark')
                                          ? ColorManager.primaryDarkColor
                                          : ColorManager.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemCount:
                                HomeCubit.get(context).cartProductModel.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Shipping Information',
                          style: TextStyle(
                            fontSize: 20,
                            color: CashHelper.getData(key: 'isDark')
                                ? ColorManager.primaryDarkColor
                                : ColorManager.primaryColor,
                        ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HomeCubit.get(context).name.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              HomeCubit.get(context).phone.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              HomeCubit.get(context).address.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: defaultButton(
                          function: () {
                            Navigator.pushNamed(context, Routes.checkOutScreen);
                          },
                          width: 150,
                          color: ColorManager.myGrey,
                          text: 'Back'),
                    ),
                    Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: defaultButton(
                          function: () {
                            try {
                              HomeCubit.get(context).storeOrder({
                                'title': HomeCubit.get(context).name.toString(),
                                'phone':
                                    HomeCubit.get(context).phone.toString(),
                                'address':
                                    HomeCubit.get(context).address.toString(),
                                'latitude': HomeCubit.get(context).latitude,
                                'longitude': HomeCubit.get(context).longitude,
                                'price': HomeCubit.get(context).totalPrice,
                              }, HomeCubit.get(context).cartProductModel);
                              Fluttertoast.showToast(
                                  msg: "Order success",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:CashHelper.getData(key: 'isDark')
                                      ? ColorManager.primaryDarkColor
                                      : ColorManager.primaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushNamed(
                                  context, Routes.homeScreenLayoutRoute);
                            } catch (ex) {
                              print(ex.toString());
                            }
                          },
                          width: 150,
                         color:  CashHelper.getData(key: 'isDark')
                              ? ColorManager.primaryDarkColor
                              : ColorManager.primaryColor,
                          text: 'Finish'),
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
