import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/data/model/product_model.dart';
import 'package:labanda/presentation/resources/color_manager.dart';

import '../../business_logic/home_logic/cubit.dart';
import '../../business_logic/home_logic/states.dart';
import '../../data/model/cart_product.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';

class DetailsProduct extends StatelessWidget {
  ProductModel model;

  DetailsProduct(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDark
              : ColorManager.myWhite,
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage('${model.image}'),
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${model.title}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.myWhite
                              : Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${model.description}',
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.2,
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.myWhite
                              : Colors.black,

                          // fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: CashHelper.getData(key: 'isDark')
                              ? ColorManager.primaryDarkColor
                              : ColorManager.primaryColor,
                        ),
                      ),
                      Spacer(),
                      defaultButton(
                        function: () {
                          HomeCubit.get(context).addProductToCart(CartModel(
                            name: model.title,
                            price: model.price,
                            image: model.image,
                            quatity: 1,
                          ));
                          print(model.title);
                          print(model.price);
                          print(model.image);
                          print(model.numberCategory);
                          HomeCubit.get(context).getAllProductToCart();
                        },
                        text: 'Add',
                        width: 120,
                        color: CashHelper.getData(key: 'isDark')
                            ? ColorManager.primaryDarkColor
                            : ColorManager.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
