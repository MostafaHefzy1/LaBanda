import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labanda/business_logic/home_logic/states.dart';
import 'package:labanda/data/service/data_local/cart_database_sqflite.dart';
import 'package:labanda/data/service/data_local/shared_preferences.dart';
import 'package:labanda/presentation/home_layout/producats_screen.dart';
import 'package:labanda/presentation/home_layout/setting_screen.dart';
import 'package:labanda/presentation/resources/constants_manager.dart';

import '../../data/model/cart_product.dart';
import '../../data/model/category_model.dart';
import '../../data/model/product_model.dart';
import '../../presentation/home_layout/cart_screen.dart';
import '../../presentation/resources/routes_manager.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // ------------------------------------------------------------------------------------------------------
  //HomeScreen Logic
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProducatsScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeBottomNavState());
  }

  // ------------------------------------------------------------------------------------------------------

  bool isDark = true;

  changeMode() {
    isDark = !isDark;
    CashHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(IsDarkState());
    });
  }

  final picker = ImagePicker();
  File? EditUser;

  ImageProvider function() {
    if (EditUser != null)
      return FileImage(
        EditUser!,
      );
    else
      return NetworkImage(CashHelper.getData(key: 'image'));
  }

  Future<void> getImage() async {
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      EditUser = File(pickFile.path);
      uploadImage();
      emit(UserEditingImageSuccess());
    } else
      emit(UserEditingImageFailed());
  }

  void uploadImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('User/${Uri.file(EditUser!.path).pathSegments.last}')
        .putFile(EditUser!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CashHelper.saveData(key: 'image', value: value);
        emit(GETEditingImageSuccess());
      });
    }).catchError((error) {
      emit(GETEditingImageFailed());
    });
  }

  //Search

  List<ProductModel> searchList = [];

  void searchLogic(String searchName) {
    searchName = searchName.toLowerCase();

    searchList = productModel.where((search) {
      var searchTitle = search.title!;
      var searchPrice = search.price!;
      return searchTitle.contains(searchName) ||
          searchPrice.contains(searchName);
    }).toList();
    print(searchList[0]);

    emit(StateSearchLogic());
  }

  void clearSearch() {
    searchList.clear();
    emit(ClearSearchLogic());
  }

  // ------------------------------------------------------------------------------------------------------
  //Product
  List<CategoryModel> categoryModel = [];

  getCategory() async {
    await FirebaseFirestore.instance
        .collection('Category')
        // .where('title', isEqualTo: 'Crepe')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        categoryModel.add(CategoryModel.fromJson(value.docs[i].data()));
        // print(categoryModel.length) ;
      }
      emit(GetCategorySuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryFailedSate(error.toString()));
    });
  }

  List<ProductModel> productModel = [];

  getProduct() async {
    await FirebaseFirestore.instance.collection(' Product').get().then((value) {
      print(value);
      print(value.docs[0].data());
      for (int i = 0; i < value.docs.length; i++) {
        productModel.add(ProductModel.fromJson(value.docs[i].data()));
        print(productModel.length);
      }
      emit(GetProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductsFailedSate(error.toString()));
    });
  }

  List<ProductModel> crepeProductModel = [];

  getCrepeProduct() async {
    await FirebaseFirestore.instance
        .collection(' Product')
        .where('numberCategory', isEqualTo: 'Crepe')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        crepeProductModel.add(ProductModel.fromJson(value.docs[i].data()));
      }
      emit(GetCrepeProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetCrepeProductsFailedSate(error.toString()));
    });
  }

  List<ProductModel> burgerProductModel = [];

  getBurgerProduct() async {
    await FirebaseFirestore.instance
        .collection(' Product')
        .where('numberCategory', isEqualTo: 'Burger')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        burgerProductModel.add(ProductModel.fromJson(value.docs[i].data()));
      }
      emit(GetBurgerProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetBurgerProductsFailedSate(error.toString()));
    });
  }

  List<ProductModel> mealsProductModel = [];

  getMealsProduct() async {
    await FirebaseFirestore.instance
        .collection(' Product')
        .where('numberCategory', isEqualTo: 'Meals')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        mealsProductModel.add(ProductModel.fromJson(value.docs[i].data()));
      }
      emit(GetMealsProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetMealsProductsFailedSate(error.toString()));
    });
  }

  List<ProductModel> pastaProductModel = [];

  getPastaProduct() async {
    await FirebaseFirestore.instance
        .collection(' Product')
        .where('numberCategory', isEqualTo: 'Pasta')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        pastaProductModel.add(ProductModel.fromJson(value.docs[i].data()));
      }
      emit(GetPastaProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetPastaProductsFailedSate(error.toString()));
    });
  }

  List<ProductModel> sandwichesProductModel = [];

  getSandwichesProduct() async {
    await FirebaseFirestore.instance
        .collection(' Product')
        .where('numberCategory', isEqualTo: 'Sandwiches')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        sandwichesProductModel.add(ProductModel.fromJson(value.docs[i].data()));
      }
      emit(GetSandwichesProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetSandwichesProductsFailedSate(error.toString()));
    });
  }

  List<ProductModel> waffleProductModel = [];

  getWaffleProduct() async {
    await FirebaseFirestore.instance
        .collection(' Product')
        .where('numberCategory', isEqualTo: 'Burger')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        waffleProductModel.add(ProductModel.fromJson(value.docs[i].data()));
      }
      emit(GetWaffleProductSuccessSate());
    }).catchError((error) {
      print(error.toString());
      emit(GetWaffleProductsFailedSate(error.toString()));
    });
  }

  // ------------------------------------------------------------------------------------------------------
  // Cart
  addProductToCart(CartModel cartModel) async {
    for (int i = 0; i < cartProductModel.length; i++) {
      if (cartProductModel[i].image == cartModel.image) return;
    }

    var dbHelper = CartDataBaseHelper.db;
    await dbHelper.insert(cartModel);
    cartProductModel.add(cartModel);
    emit(IncreaseCartState());
  }

  List<CartModel> cartProductModel = [];

  getAllProductToCart() async {
    var dbHelper = CartDataBaseHelper.db;
    cartProductModel = await dbHelper.getAllProduct();
    print(cartProductModel.length);
    getTotalPrice();
    emit(GetAllProductToCartState());
  }

  double totalPrice = 0;

  getTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < cartProductModel.length; i++) {
      totalPrice += double.parse(
            cartProductModel[i].price!,
          ) *
          cartProductModel[i].quatity!;
    }
  }

  increaseQuatity(int index) async {
    cartProductModel[index].quatity = (cartProductModel[index].quatity! + 1);
    totalPrice += double.parse(
      cartProductModel[index].price!,
    );
    await CartDataBaseHelper.db.updateProduct(cartProductModel[index]);
    emit(IncreaseCartState());
  }

  decreaseQuatity(int index) async {
    if (cartProductModel[index].quatity == 1) {
      await CartDataBaseHelper.db.deleteProduct(cartProductModel[index]);
      getAllProductToCart();
      emit(DeleteDataToCart());
    } else {
      cartProductModel[index].quatity = (cartProductModel[index].quatity! - 1);
      totalPrice -= double.parse(
        cartProductModel[index].price!,
      );
      await CartDataBaseHelper.db.updateProduct(cartProductModel[index]);
      emit(DecreaseCartState());
    }
  }

  deleteToCart(int index) async {
    await CartDataBaseHelper.db.deleteProduct(cartProductModel[index]);
    getAllProductToCart();
    emit(DeleteDataToCart());
  }

  void SignOut(context) {
    CashHelper.removeData(key: 'token').then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    }).catchError((error) {});
  }

  //Location
  double latitude = 0;

  double longitude = 0;

  getLatitudeAndLongitude() async {
    Position position = await _determinePosition();
    latitude = position.latitude;
    longitude = position.longitude;
    emit(StateAddLocation());
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  String? name, phone, address;

//   void orderToProducts (
//   {
//     required String name ,
//     required String phone ,
//     required String address ,
//     required List <CartModel> product ,
//   }
// )
//   {
//     OrderModel model = OrderModel(
//       name: name,
//       phone: phone ,
//       address: address ,
//       latitude: latitude ,
//       longitude: longitude ,
//       products: product
//     )  ;
//     FirebaseFirestore.instance.collection('order').add(model.toMap());
//   }
//

  storeOrder(data, List<CartModel> cartModel) {
    var documentRef = FirebaseFirestore.instance.collection('orders').doc();
    documentRef.set(data);
    for (var CartModel in cartModel) {
      documentRef.collection('orderDetails').doc().set({
        AppConstants.kProductName: CartModel.name,
        AppConstants.kProductPrice: CartModel.price,
        AppConstants.kProductQuantity: CartModel.quatity,
      });
    }
  }
}
