
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

   var searchController=TextEditingController();
   var formKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
          listener:(context,state){},
          builder:(context,state){
            return Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      Container(
                        child: defaultTextFromFiled(
                            controller: searchController,
                            validator: (String? value)
                            {
                              if(value!.isEmpty){
                                return 'can not be empty ';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text ,
                            prefixIcon: const Icon(Icons.search),
                            label:'Search',
                            onFieldSubmitted: (String text)
                            {
                              ShopCubit.get(context).search(text);
                            }
                        ),
                      ),
                      if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                      if(state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context,index)=>
                                  buildListItemProducts(ShopCubit.get(context).model!.data!.data![index],context),
                              separatorBuilder: (context,index)=>myDivider(),
                              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length
                          ),
                        ),
                    ],
                  ),
                )
              ),
            );
          },
      );

  }


}
