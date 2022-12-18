
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/register_screen/cubit/states.dart';

class SettingsScreen extends StatefulWidget {
 const  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController? nameController =TextEditingController();

  TextEditingController? emailController =TextEditingController();

  TextEditingController? phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){

            nameController!.text=ShopCubit.get(context).userDataModel!.data!.name!;
            emailController!.text=ShopCubit.get(context).userDataModel!.data!.email!;
            phoneController!.text=ShopCubit.get(context).userDataModel!.data!.phone!;
          }
        },
        builder: (context,state){
          var model=ShopCubit.get(context);

            nameController!.text=model.userDataModel!.data!.name!;
            emailController!.text=model.userDataModel!.data!.email!;
            phoneController!.text=model.userDataModel!.data!.phone!;

          return ConditionalBuilder(
            condition:nameController!=null,
            fallback: (context)=>const Center(child: CircularProgressIndicator()),
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                [
                   Row(
                     children: [
                       Text('Profile',
                  style:Theme.of(context).textTheme.headline5,
                  ),
                       const Spacer(),
                       defaultTextButton(
                           onPressed:(){
                             model.changeProfile();
                           },
                           text:'edit profile'),
                     ],
                   ),
                  const SizedBox(height: 10,),
                  Container(
                    child: defaultTextFromFiled(
                      enabled:model.editProfile ,
                      controller: nameController,
                      validator: (String? value){
                        return 'name must be not empty';
                      },
                      keyboardType:TextInputType.name ,
                      prefixIcon:const Icon(Icons.drive_file_rename_outline),
                      label: 'Name',
                      border:const  OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    child: defaultTextFromFiled(
                      enabled: model.editProfile,
                      controller: emailController,
                      validator: (String? value){
                        return 'Email Must Be Not Empty';
                      },
                      keyboardType:TextInputType.emailAddress ,
                      prefixIcon:const Icon(Icons.email_outlined),
                      label: 'Email Address',
                      border:const  OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    child: defaultTextFromFiled(
                      enabled: model.editProfile,
                      controller: phoneController,
                      validator: (String? value){
                        return 'Phone Must Be Not Empty';
                      },
                      keyboardType:TextInputType.phone ,
                      prefixIcon:const Icon(Icons.phone_android),
                      label: 'Phone Number',
                      border:const  OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  defaultButton(
                      onPressed:()
                  {
                    model.updateProfile(
                        email: emailController!.text,
                        phone: phoneController!.text,
                        name: nameController!.text,
                        );
                  },
                      text:'Update'),
                  const SizedBox(height: 10,),
                  defaultButton(
                      onPressed:()
                      {
                        signOut(context);
                        model.currentIndex=0;
                      },
                      text:'Login Out')
                ],
              ),
            ),
          );
        },

    );
  }
}
