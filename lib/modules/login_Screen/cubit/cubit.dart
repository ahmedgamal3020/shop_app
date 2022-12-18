
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/login_Screen/cubit/states.dart';
import 'package:shop/network/end_point/end_point.dart';
import 'package:shop/network/remote/die_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of<ShopLoginCubit>(context);

  //use to take user data

  bool isPassword=true;

  void showPassword(){
    isPassword=! isPassword;
    emit(ShopShowPassword());
  }

  ShopUserModel? model;

  void userLogin(
  {
  required String email,
  required String password
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:
        {
          "email": email,
          'password': password
        }).then((value) {
          model=ShopUserModel.fromJson(value!.data);
          print(model!.data!.name);
          emit(ShopLoginSuccessState(model!));
    }).catchError((error){
      emit(ShopLoginErrorState(error));
      print('${error.toString()} assa');
    });

  }

  }
