import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labanda/business_logic/home_logic/cubit.dart';
import 'package:labanda/business_logic/home_logic/states.dart';
import 'package:labanda/presentation/resources/color_manager.dart';

import '../../data/service/data_local/shared_preferences.dart';
import '../components/components_screens.dart';
import '../product_screens/details_products.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var seacrController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CashHelper.getData(key: 'isDark')
              ? ColorManager.primaryDark
              : ColorManager.myWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                TextField(
                  onChanged: (searchName) {
                    HomeCubit.get(context).searchLogic(searchName);
                  },
                  controller: seacrController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: seacrController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              HomeCubit.get(context).clearSearch();
                              seacrController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          )
                        : null,
                    hintText: 'Search with name & price',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                seacrController.text.isNotEmpty
                    ? Column(
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
                                HomeCubit.get(context).searchList.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailsProduct(
                                                  HomeCubit.get(context)
                                                      .searchList[index],
                                                )));
                                  },
                                  child: defaultProductItem(
                                      HomeCubit.get(context).searchList[index]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(),
              ],
            ),
          ),
        );
      },
    );
  }
}

/*

  late File image ;
  final picker  =ImagePicker() ;

  Future<void>getImage() async {
    final pickFile = await picker.pickImage(source:ImageSource.gallery)  ;
    if(pickFile!=null)
      {
        image = File(pickFile.path) ;
        print(pickFile.path) ;
      }
    else
      print('No image selected ') ;

  }
 */
