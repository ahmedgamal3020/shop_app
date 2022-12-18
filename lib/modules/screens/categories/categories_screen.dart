
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder:(context,index)=>categoriesItems(ShopCubit.get(context).varCategoriesModel!.data!.categories![index]) ,
            separatorBuilder:(context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).varCategoriesModel!.data!.categories!.length);
      },
    );
  }


  Widget categoriesItems(CategoriesData model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 80,
          height:80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(model.image!)
              )
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 200,
          child: Text(model.name!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:const  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: (){},
            icon:const Icon(Icons.arrow_forward_ios))

      ],
    ),
  );
}
