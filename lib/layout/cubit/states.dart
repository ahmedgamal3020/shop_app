
import 'package:shop/models/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeButtonNavState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopHomeSuccessState extends ShopStates{}

class ShopHomeErrorState extends ShopStates{
  final dynamic error;

  ShopHomeErrorState(this.error);

}

class ShopCategoriesLoadingState extends ShopStates{}

class ShopCategoriesSuccessState extends ShopStates{}

class ShopCategoriesErrorState extends ShopStates{
  final dynamic error;

  ShopCategoriesErrorState(this.error);

}

class ShopFavoritesSuccessState extends ShopStates{
  final ChangeFavoritesModel model;

  ShopFavoritesSuccessState(this.model);
}

class ShopFavoritesErrorState extends ShopStates{
  final dynamic error;

  ShopFavoritesErrorState(this.error);

}

class ShopChangeFavoritesSuccessState extends ShopStates{

}

class ShopFavoritesLoadingState extends ShopStates{}

class ShopGetFavoritesSuccessState extends ShopStates{}

class ShopGetFavoritesErrorState extends ShopStates{
  final dynamic error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopGetUserDataSuccessState extends ShopStates{}

class ShopGetUserDataErrorState extends ShopStates{
  final dynamic error;

  ShopGetUserDataErrorState(this.error);
}


class ShopUpdateUserDataSuccessState extends ShopStates{}

class ShopUpdateUserDataErrorState extends ShopStates{
  final dynamic error;

  ShopUpdateUserDataErrorState(this.error);
}
class ShoEditProfileState extends ShopStates{}

class ShopToggleFavoritesState extends ShopStates{}

class SearchLoadingState extends ShopStates{}

class SearchSuccessState extends ShopStates{}

class SearchErrorState extends ShopStates{}
