import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/home_logic/cubit.dart';
import '../../business_logic/home_logic/states.dart';
import '../../data/model/category_model.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../resources/color_manager.dart';
import 'details_products.dart';

class BurgerProduct extends StatelessWidget {
  CategoryModel model;

  BurgerProduct(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetBurgerProductsFailedSate &&
            HomeCubit.get(context).burgerProductModel.length == 0)
          CircularProgressIndicator(
            color: ColorManager.primaryColor,
            backgroundColor: ColorManager.primaryColor,
          );
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: CashHelper.getData(key: 'isDark')
                ? ColorManager.primaryDark
                : ColorManager.myWhite,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  Container(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1 / 1.4,
                      children: List.generate(
                        HomeCubit.get(context).burgerProductModel.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailsProduct(
                                          HomeCubit.get(context)
                                              .burgerProductModel[index],
                                        )));
                          },
                          child: defaultProductItem(
                              HomeCubit.get(context).burgerProductModel[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
