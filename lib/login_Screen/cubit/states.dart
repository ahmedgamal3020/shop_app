import 'package:shop/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopShowPassword extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {

    final ShopUserModel model;

  ShopLoginSuccessState(this.model);
}

class ShopLoginErrorState extends ShopLoginStates {

    final dynamic error;
   ShopLoginErrorState(this.error);
}
