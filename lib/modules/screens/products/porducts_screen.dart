
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/modules/screens/products/view_prodect_screen.dart';
import 'package:shop/style/color.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopFavoritesSuccessState)
          {
            if(!state.model.status!)
              {
                defaultToast(
                    state: ToastState.error,
                    message:state.model.message!
                );
              }else
              {
                defaultToast(
                    state: ToastState.success,
                    message:state.model.message!
                );

              }
          }

      },
      builder: (context,state)
      {
        var cubit =ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[200],
            body: ConditionalBuilder(
                condition: ShopCubit.get(context).homeModel!=null,
                builder:(context)=>productsBuilder(cubit.homeModel!,context,cubit.varCategoriesModel!),
                fallback: (context)=> const Center(child: CircularProgressIndicator(),)
            )
        );
      },

    );
  }

  Widget productsBuilder( HomeModel model,context,CategoriesModel? categoriesModel)=> SingleChildScrollView(

    physics:const  BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: model.data!.banners!.map((e){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage('${e.image}'),
                            fit: BoxFit.cover
                          )
                        ),

                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1,
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayAnimationDuration:const Duration(seconds: 1),
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlayCurve: Curves.easeInBack,
                    autoPlayInterval:const  Duration(seconds: 3),
                    scrollDirection: Axis.horizontal,

                  ),
              ),
              const SizedBox(height: 10,),
              const Text('CATEGORIES',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=>buildCategoriesItem(categoriesModel.data!.categories![index]),
                    separatorBuilder: (context,index)=>const SizedBox(width: 8,),
                    itemCount:categoriesModel!.data!.categories!.length ),
              ),
              const SizedBox(height: 10,),
              const Text('NEW PRODUCTS',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
            ],
          ),
        ),


        GridView.count(
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics() ,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1/1.70,
          padding:const  EdgeInsets.all(10),

          children:List.generate(model.data!.products!.length,
                  (index) => buildGridView(model.data!.products![index],context),

          ),
        )




      ]
    ),
  );

  Widget buildCategoriesItem(CategoriesData categoryModel)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Stack(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(image:NetworkImage(categoryModel.image!),
                  fit: BoxFit.cover),
            ),),
          Positioned(
            bottom: 1,

            child: Container(
              color: Colors.black.withOpacity(.8),
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  categoryModel.name!,style:const TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ) ,
                )
            ),
          ),

        ],

      ),

    ],
  );

  Widget buildGridView(Products model,context)=>InkWell(
    onTap: (){
     productImage=model.image;
     productTitle=model.description;
     productName=model.name;
     navigateTo(context,const ViewProduct());
    },
    child: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image:NetworkImage(model.image),
                    fit: BoxFit.fill,)
                ),

              ),
              if(model.discount!=0)
              Positioned(
                bottom: 1,
                left: 1,
                  child:Container(
                    color: Colors.red,
                  child:const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white),
                  )
              ),

              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const  TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text('${model.price!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:const  TextStyle(
                        color: defaultColor,
                        fontSize: 14.0
                      ),
                    ),
                    const SizedBox(width: 8,),
                    if(model.oldPrice !=model.price)
                    Text('${model.oldPrice}',
                      style: TextStyle(
                        fontSize: 10,

                        color: Colors.grey[900],
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed:()
                        {
                         ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon:ShopCubit.get(context).favorites[model.id]==true?
                        const Icon(Icons.favorite,size: 14,):
                        const Icon(Icons.favorite_outline,size: 17,)

                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
