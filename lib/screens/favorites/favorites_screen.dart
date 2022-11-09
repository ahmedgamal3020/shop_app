
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/style/color.dart';

class FavoritesScreen extends StatelessWidget {
   FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return
        //   ShopCubit.get(context).favoritesModel!.data!.data!.length>0 ?
        // ListView.separated(
        //     itemBuilder: (context,index)=>buildItemFavorites(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
        //     separatorBuilder: (context,index)=>myDivider(),
        //     itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length)
        //     :Center(child: Icon(Icons.menu,size: 100,color: Colors.grey,));




          ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildListItemProducts(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context)=> Center(child: Icon(Icons.menu,size: 100,color: Colors.grey,)),
        );
      },
    );
  }


}
