import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/login_Screen/login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/network/remote/die_helper.dart';
import 'package:shop/on_boarding.dart';

import 'style/themes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget? widget;
  DioHelper.init();
  await CacheHelper.init();
  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
   if(onBoarding!=null){
     if(token!=null) {
       widget= HomeScreen();
     } else {
       widget= LoginScreen();
     }
   }
   else{
     widget=const OnBoarding();
   }

  runApp(MyApp(

    startWidget: widget,

  ));

}

class MyApp extends StatelessWidget {
  final Widget startWidget;
   const MyApp( {
     super.key,
     required this.startWidget
   });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context)=>
        ShopCubit()
          ..getHomeData()
          ..getCategoryData()
          ..getFavoritesData()
          ..getUserData(),
        ),
    ],
      child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:defaultTheme(),
              home: startWidget
          ),
    );

  }
}
