import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/states.dart';
import 'package:labanda/presentation/product_screens/burger_product.dart';
import 'package:labanda/presentation/product_screens/crepe_product.dart';
import 'package:labanda/presentation/product_screens/details_products.dart';
import 'package:labanda/presentation/product_screens/pasta_product.dart';
import 'package:labanda/presentation/product_screens/sandwiches_product.dart';
import 'package:labanda/presentation/product_screens/waffle_product.dart';
import 'package:labanda/presentation/resources/assets_manager.dart';
import 'package:labanda/presentation/resources/color_manager.dart';

import '../../data/model/category_model.dart';
import '../../data/model/product_model.dart';
import '../../data/service/data_local/shared_preferences.dart';
import '../product_screens/meals_product_screen.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';

class ProducatsScreen extends StatelessWidget {
  List<String> imageList = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: HomeCubit.get(context).productModel.length > 0 &&
                HomeCubit.get(context).categoryModel.length > 0,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: imageList
                        .map((e) => Image(
                              image: AssetImage(e),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              color: CashHelper.getData(key: 'isDark')
                                  ? ColorManager.myWhite
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 100.0,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  if (index == 0)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CrepeProduct(
                                                  HomeCubit.get(context)
                                                      .categoryModel[index],
                                                )));
                                  if (index == 1)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => BurgerProduct(
                                                  HomeCubit.get(context)
                                                      .categoryModel[index],
                                                )));
                                  if (index == 2)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MealsProduct(
                                                  HomeCubit.get(context)
                                                      .categoryModel[index],
                                                )));
                                  if (index == 3)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PastaProduct(
                                                  HomeCubit.get(context)
                                                      .categoryModel[index],
                                                )));
                                  if (index == 4)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SandwichesProduct(
                                                  HomeCubit.get(context)
                                                      .categoryModel[index],
                                                )));
                                  if (index == 5)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => WaffleProduct(
                                                  HomeCubit.get(context)
                                                      .categoryModel[index],
                                                )));
                                },
                                child: buildCategoryItem(HomeCubit.get(context)
                                    .categoryModel[index]),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 10.0,
                              ),
                              itemCount:
                                  HomeCubit.get(context).categoryModel.length,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'New Products',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                  color: CashHelper.getData(key: 'isDark')
                                      ? ColorManager.myWhite
                                      : Colors.black,
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.allProduct);
                                  },
                                  child: Text(
                                    'See All',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: CashHelper.getData(key: 'isDark')
                                          ? ColorManager.primaryDarkColor
                                          : ColorManager.primaryColor,
                                      // fontWeight: FontWeight.w800,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 400.0,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailsProduct(
                                                HomeCubit.get(context)
                                                    .productModel[index],
                                              )));
                                },
                                child: buildProductItem(
                                    HomeCubit.get(context).productModel[index]),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 10.0,
                              ),
                              itemCount:
                                  HomeCubit.get(context).productModel.length,
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ),
            fallback: (context) => LinearProgressIndicator(
              color: ColorManager.primaryColor,
              backgroundColor: CashHelper.getData(key: 'isDark')
                  ? ColorManager.primaryDarkColor
                  : ColorManager.primaryColor,
            ),
          );
        });
  }
}

Widget buildCategoryItem(CategoryModel model) => Container(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 120.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(
              .8,
            ),
            width: 100.0,
            child: Text(
              '${model.title}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

Widget buildProductItem(ProductModel model) => Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 200.0,
            width: 200.0,
            fit: BoxFit.cover,
          ),
          Text(
            ''
            '${model.title}',
            style: TextStyle(
              color: CashHelper.getData(key: 'isDark')
                  ? ColorManager.myWhite
                  : Colors.black,
            ),
          ),
          Text(
            '${model.price}',
            style: TextStyle(
              color: CashHelper.getData(key: 'isDark')
                  ? ColorManager.primaryDarkColor
                  : ColorManager.primaryColor,
            ),
          ),
        ],
      ),
    );
