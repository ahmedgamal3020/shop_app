import 'package:shop/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopShowRegisterPasswordState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {

    final ShopUserModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {

    final dynamic error;
   ShopRegisterErrorState(this.error);
}
