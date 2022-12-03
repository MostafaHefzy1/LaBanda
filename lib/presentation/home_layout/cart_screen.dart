import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:labanda/presentation/resources/assets_manager.dart';
import 'package:labanda/presentation/resources/color_manager.dart';

import '../../business_logic/home_logic/cubit.dart';
import '../../business_logic/home_logic/states.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/routes_manager.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDark
                : ColorManager.myWhite,
            body: HomeCubit.get(context).totalPrice != 0
                ? Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                            itemBuilder: (context, index) => Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 120,
                                      child: Image(
                                        image: NetworkImage(
                                          HomeCubit.get(context)
                                              .cartProductModel[index]
                                              .image!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          HomeCubit.get(context)
                                              .cartProductModel[index]
                                              .name!,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: CashHelper.getData(
                                                    key: 'isDark')
                                                ? ColorManager.myWhite
                                                : Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          HomeCubit.get(context)
                                              .cartProductModel[index]
                                              .price!,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: CashHelper.getData(
                                                    key: 'isDark')
                                                ? ColorManager.primaryDarkColor
                                                : ColorManager.primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 130,
                                              color: Colors.grey[300],
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      HomeCubit.get(context)
                                                          .increaseQuatity(
                                                              index);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    HomeCubit.get(context)
                                                        .cartProductModel[index]
                                                        .quatity
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      bottom: 13,
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        HomeCubit.get(context)
                                                            .decreaseQuatity(
                                                                index);
                                                      },
                                                      child: Icon(
                                                        Icons.minimize,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  HomeCubit.get(context)
                                                      .deleteToCart(index);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: CashHelper.getData(
                                                          key: 'isDark')
                                                      ? ColorManager.myWhite
                                                      : Colors.black,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            itemCount:
                                HomeCubit.get(context).cartProductModel.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: CashHelper.getData(key: 'isDark')
                                        ? ColorManager.myWhite
                                        : ColorManager.myGrey,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  HomeCubit.get(context).totalPrice.toString(),
                                  //HomeCubit.get(context).totalPrice.toString()  ,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: CashHelper.getData(key: 'isDark')
                                        ? ColorManager.primaryDarkColor
                                        : ColorManager.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: 100,
                              width: 200,
                              padding: EdgeInsets.all(20),
                              child: defaultButton(
                                text: 'checkout',
                                function: () {
                                  Navigator.pushNamed(
                                      context, Routes.checkOutScreen);
                                },
                                width: 200,
                                color: CashHelper.getData(key: 'isDark')
                                    ? ColorManager.primaryDarkColor
                                    : ColorManager.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : EmptyCart());
      },
    );
  }
}

Widget EmptyCart() => SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: CashHelper.getData(key: 'isDark')
                  ? SvgPicture.asset(
                      ImageAssets.emptyCartDark,
                      height: 350,
                      width: 350,
                    )
                  : SvgPicture.asset(
                      ImageAssets.emptyCartLight,
                      height: 350,
                      width: 350,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Cart Empty',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: CashHelper.getData(key: 'isDark')
                    ? ColorManager.primaryDarkColor
                    : ColorManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
