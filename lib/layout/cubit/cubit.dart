
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/network/end_point/end_point.dart';
import 'package:shop/network/remote/die_helper.dart';
import 'package:shop/screens/categories/categories_screen.dart';
import 'package:shop/screens/favorites/favorites_screen.dart';
import 'package:shop/screens/products/porducts_screen.dart';
import 'package:shop/screens/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>{

   ShopCubit() :super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);




  int currentIndex=0;
  List<Widget> bottomNavScreens=[

    const ProductsScreen(),
    const CategoriesScreen(),
     FavoritesScreen(),
     SettingsScreen(),

  ];

  void changeNav(index){
    currentIndex=index;
    emit(ShopChangeButtonNavState());

  }
  
   Map<int,bool> favorites={};
   HomeModel? homeModel;
   Future<dynamic>? getHomeData(){
    emit(ShopHomeLoadingState());
    DioHelper.getData(
        url: HOME,
        token: token
        ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);

      for (var i in homeModel!.data!.products!) {
        favorites.addAll(
          {
           i.id!:i.inFavorites!
          }
        );
      }


      emit(ShopHomeSuccessState());
      //print(favorites.toString());


    }).catchError((error)
    {
      emit(ShopHomeErrorState(error));
      print('$error ahmed');
    });
  }
   //  var x ;
   // Products? model;
   //  toggleFavorites(context)
   // {
   //
   //   if(favorites[model!.id]!)
   //   {
   //     x=const Icon(Icons.favorite);
   //     emit(ShopToggleFavoritesState());
   //   }
   //   x=Icon(Icons.favorite_outline);
   //
   //   emit(ShopToggleFavoritesState());
   // }

   CategoriesModel? varCategoriesModel;
   Future<dynamic>? getCategoryData(){
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
        url: CATEGORIES,
        token: token
        ).then((value)
    {
      varCategoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
       //print(varCategoriesModel!.data!.categories![0].name);

    }).catchError((error)
    {
      emit(ShopCategoriesErrorState(error));
      if (kDebugMode) {
        print('$error ahmed');
      }
    });
  }


   ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeFavoritesSuccessState());

    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          "product_id":productId
        },
       token: token
    ).then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value!.data);
      //print(value.data);
      if(!changeFavoritesModel!.status!)
        {
          favorites[productId]=!favorites[productId]!;

        }else{
        getFavoritesData();
        emit(ShopFavoritesLoadingState());
      }
      emit(ShopFavoritesSuccessState(changeFavoritesModel!));

    }).catchError((error)
    {
      favorites[productId]=!favorites[productId]!;
      emit(ShopFavoritesErrorState(error));
    });
  }

   FavoritesModel? favoritesModel;
   Future<dynamic>? getFavoritesData(){

    emit(ShopFavoritesLoadingState());

    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
      //print(favoritesModel!.data!.data.toString());

    }).catchError((error)
    {
      emit(ShopGetFavoritesErrorState(error));

        print('$error ahmed');

    });
  }


   ShopUserModel? userDataModel;
   Future<dynamic>? getUserData(){

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value)
    {
      userDataModel=ShopUserModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessState());
      print("${userDataModel!.data!.name} + ${userDataModel!.data!.token}");

    }).catchError((error)
    {
      emit(ShopGetUserDataErrorState(error));

        print('$error = Profile');

    });
  }


  void updateProfile({
  @required String? email,
  @required String? phone,
  @required String? name,
})
  {
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          'email':email,
          'phone':phone,
          'name':name,
        },
        token: token
    )!.then((value)
    {
      userDataModel=ShopUserModel.fromJson(value.data);
      emit(ShopUpdateUserDataSuccessState());
    }).catchError((error)
    {
      emit(ShopUpdateUserDataErrorState(error));
      print("Error Update Profile = ${error} ");
    });

  }

  bool? editProfile=false;
  void changeProfile()
  {
    editProfile=!editProfile!;
    emit(ShoEditProfileState());

  }


   SearchModel? model;
   void search(String?text)
   {
     emit(SearchLoadingState());
     DioHelper.postData(
       url: SEARCH,
       data:{
         'text':text
       },
       token: token,
     ).then((value)
     {
       model=SearchModel.fromJson(value!.data);
       emit(SearchSuccessState());
     }).catchError((error)
     {
       emit(SearchErrorState());

     });

   }
}