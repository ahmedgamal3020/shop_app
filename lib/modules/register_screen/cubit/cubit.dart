
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/register_screen/cubit/states.dart';
import 'package:shop/network/end_point/end_point.dart';
import 'package:shop/network/remote/die_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);


  bool isPassword=true;

  void showPassword(){
    isPassword  =! isPassword;
    emit(ShopShowRegisterPasswordState());
  }

  //use to take user data
   ShopUserModel? registerModel;
  void userRegister(
  {
  @required String? email,
  @required String? password,
  @required String? name,
  @required String? phone,

  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'email': email!,
          'password': password!,
          'phone':phone!,
          'name':name!,
        },
        token: token,

        ).then((value) {
      registerModel=ShopUserModel.fromJson(value!.data);
          print(registerModel!.data!.name);
          emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error));
      print('${error.toString()} assa');
      print('${email} assa');
    });

  }

  }
