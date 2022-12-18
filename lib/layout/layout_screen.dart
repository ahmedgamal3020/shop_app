import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/screens/search/search_screen.dart';


class HomeScreen extends StatelessWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>
        ShopCubit()
      ..getHomeData()
      ..getCategoryData()
      ..getFavoritesData()
      ..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state)async{
            if(state is ShopHomeLoadingState){


            }
          },
          builder: (context,state){
            var cubit =ShopCubit.get(context);

            return  Scaffold(
              appBar:AppBar(
                title: const Text('Menu'),
                actions: [
                  IconButton(
                      onPressed:(){
                        navigateTo(context,const SearchScreen());
                      }, icon:(const Icon(Icons.search))
                  )
                ]
                ,),
              body: cubit.bottomNavScreens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (index){
                    cubit.changeNav(index);
                  },

                  items:const [
                  BottomNavigationBarItem(
                      icon:Icon(Icons.home),
                      label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.apps),
                      label: 'Categories'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.favorite),
                      label: 'Favorites'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(Icons.settings),
                      label: 'Settings'
                  ),
                ],

                ),
              );

          },
        ),
    );

  }
}
