
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/style/color.dart';

ThemeData defaultTheme() {
  return
  ThemeData(
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color:defaultColor,size: 35
          ),
          titleTextStyle: TextStyle(
            color: defaultColor,
            fontSize: 20
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          )
      ),
      primarySwatch: defaultColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme:const  IconThemeData(
        color: defaultColor,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: defaultColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
              color: Colors.grey
          )

      )

  );
}