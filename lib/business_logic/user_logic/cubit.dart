import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:labanda/business_logic/user_logic/states.dart';
import 'package:labanda/data/model/user_model.dart';
import 'package:labanda/presentation/resources/color_manager.dart';

import '../../data/service/data_local/shared_preferences.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialState());

  static UserCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String adminPassword = '01156890539';

  String adminEmail = 'admin@gmail.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // final FacebookLogin _facebookLogin = FacebookLogin() ;

  IconData suffix = Icons.visibility_off;
  bool isShow = true;

  void isShowFunction() {
    isShow = !isShow;
    suffix = isShow ? Icons.visibility_off : Icons.remove_red_eye;
    emit(ShowAndHidePassword());
  }

  void signUpUsingFirebase({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      createUser(
        name: name,
        email: email,
        uid: user.user!.uid,
        phone: phone,
      );
      CashHelper.saveData(key: 'name', value: name);
      CashHelper.saveData(key: 'email', value: email);
      CashHelper.saveData(key: 'phoneNumber', value: phone);
      CashHelper.saveData(
          key: 'image',
          value:
              'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-1.jpg');
      print(CashHelper.getData(key: 'name'));
      print(CashHelper.getData(key: 'email'));
      print(CashHelper.getData(key: 'phoneNumber'));
      print(CashHelper.getData(key: 'image'));

      emit(RegisterSuccessState());
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: ColorManager.primaryDarkColor,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(RegisterFailedState(error));
    });
  }

  void signInUsingFirebase({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Email Or Password is Wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: ColorManager.primaryDarkColor,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginFailedState(error));
    });
  }

  void googleSignIn() async {
    emit(googleLoadingState());
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    print(googleSignInAccount);
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    await _auth.signInWithCredential(credential).then((user) {
      createUser(
        uid: user.user!.uid,
        email: user.user?.email ?? '',
        name: user.user?.displayName ?? '',
        picture: user.user?.photoURL ?? '',
        phone: user.user?.phoneNumber ?? '',
      );

      CashHelper.saveData(key: 'name', value: user.user?.displayName);
      CashHelper.saveData(key: 'email', value: user.user?.email);
      CashHelper.saveData(key: 'phoneNumber', value: user.user?.phoneNumber);
      CashHelper.saveData(key: 'image', value: user.user?.photoURL);

      emit(googleSuccessState(user.user!.uid));
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: ColorManager.primaryDarkColor,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(googleFailedState(error)) ;
    });
  }

  void createUser({
    required String name,
    required String email,
    String? phone,
    required String uid,
    String? picture,
  }) {
    UserModel model = UserModel(
      email: email,
      userId: uid,
      name: name,
      phonre: phone,
      picture: picture,
    );
    CashHelper.saveData(key: 'token', value: uid);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(createUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(createUserFailedState(error.toString()));
    });
  }

  void resetUsingFirebase({required String email}) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(forgetpasswordsucess());
    }).catchError((onError) {

      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: ColorManager.primaryDarkColor,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(forgetpasswordFaield(onError));
    });
  }
}
