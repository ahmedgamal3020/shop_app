
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';

class ViewProduct extends StatelessWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(productImage),
                        fit: BoxFit.fill
                      )
                    ),
                ),
                Center(child: Text(productName,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),

                ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(productTitle,
                    style:const TextStyle(
                        fontSize: 25,
                        ),),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
