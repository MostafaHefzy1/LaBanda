import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:labanda/business_logic/admin_logic/states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/admin_category_model.dart';
import '../../data/model/cart_product.dart';
import '../../data/model/category_model.dart';
import '../../presentation/admin/admin_all_order_screen.dart';
import '../../presentation/admin/admin_screen.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  String ID = '';

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    AdminScreen(),
    OrdersScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AdminBottomNavState());
  }

  File? productImage;

  final picker = ImagePicker();

  ImageProvider function() {
    if (productImage != null)
      return FileImage(
        productImage!,
      );
    else
      return NetworkImage(
          'https://tse3.mm.bing.net/th?id=OIP.E9HNeBpYIP5SPFvXTQx8zQHaGC&pid=Api&P=0&w=236&h=192');
  }

  Future<void> getImage() async {
    final pickFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickFile != null) {
      productImage = File(pickFile.path);
      emit(ImagePickerSuccess());
    } else
      emit(ImagePickerFailed());
  }

  void uploadImage({
    required String title,
    required String description,
    required String numberCategory,
    required String price,
  }) {
    CategoryModel model = CategoryModel();
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Product/${Uri
        .file(productImage!.path)
        .pathSegments
        .last}')
        .putFile(productImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createProduct(
          image: value,
          title: title,
          description: description,
          numberCategory: numberCategory,
          price: price,
        );
        emit(UploadProductSuccessState());
      }).catchError((onError) {
        emit(UploadProductFailedState(onError));
      });
    }).catchError((onError) {
      emit(UploadProductFailedState(onError));
    });
  }

  createProduct({
    required String title,
    required String description,
    required String price,
    required String numberCategory,
    String? image,
  }) {
    emit(CreateProductLoadingState());
    AdminCategoryModel model = AdminCategoryModel(
      title: title,
      description: description,
      image: image ?? '',
      price: price,
      numberCategory: numberCategory,
    );
    FirebaseFirestore.instance
        .collection(' Product')
        .add(model.toMap())
        .then((value) {
      emit(CreateProductSuccessState());
    }).catchError((error) {
      emit(CreateProductFailedState(error));
    });
  }

  Future<void> goToMaps(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final String emcodeUrl = Uri.encodeFull(googleUrl);
    if (!await canLaunch(emcodeUrl)) {
      await launch(emcodeUrl);
      emit(GoToMapSuccessState());
    } else {
      emit(GoToMapFailedState());
      throw 'Could not open the map.';
    }
  }

  List<CartModel> products = [];

  deleteOrder(docID) async
  {
    await FirebaseFirestore.instance.collection('orders').doc(docID).delete();
    FirebaseFirestore.instance.collection('orders').doc(docID).collection('orderDetails').doc().delete() ;
  }

}


