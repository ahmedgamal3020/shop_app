
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/modules/register_screen/cubit/cubit.dart';
import 'package:shop/modules/register_screen/cubit/states.dart';
import 'package:shop/network/local/cache_helper.dart';

class RegisterScreen extends StatefulWidget {
  const  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController =TextEditingController();

  var emailController =TextEditingController();

  var phoneController =TextEditingController();

  var passwordController =TextEditingController();

  var formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener:(context,state)async{

            if(state is ShopRegisterSuccessState) {
              if(state.registerModel.status!){

                 token= state.registerModel.data!.token;
                print('token = $token');
                await CacheHelper.saveData(
                    key: 'token',
                    value: state.registerModel.data!.token).then((value) {
                  defaultToast(
                      state: ToastState.success,
                      message: state.registerModel.message!);

                });
                navigateAndFinish(context,const HomeScreen());

              }else{
                defaultToast(
                    state: ToastState.error,
                    message: state.registerModel.message!);
              }
            }
          },
          builder:(context,state){


            return Form(
              key: formKey,
              child: Scaffold(
                body:Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                        [
                          const Text('Register',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: nameController,
                                border:const OutlineInputBorder(),
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.name,
                                prefixIcon:const Icon(Icons.drive_file_rename_outline),
                                label:'NAME'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: emailController,
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.emailAddress,
                                prefixIcon:const Icon(Icons.email_outlined),
                                label:'EMAIL ADDRESS',
                                border:const OutlineInputBorder()
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: phoneController,
                                border:const OutlineInputBorder(),
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.phone,
                                prefixIcon:const Icon(Icons.phone),
                                label:'PHONE'
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFromFiled(
                                controller: passwordController,
                                border:const OutlineInputBorder(),
                                validator: (String?value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return'con not be empty';
                                  }
                                  return null;
                                },
                                keyboardType:TextInputType.visiblePassword,
                                prefixIcon:const Icon(Icons.password),
                                label:'PASSWORD',
                                obscureText: ShopRegisterCubit.get(context).isPassword,
                                suffixIcon: IconButton(
                                  onPressed:()
                                  {
                                    ShopRegisterCubit.get(context).showPassword();
                                  },
                                  icon:Icon(ShopRegisterCubit.get(context).isPassword?Icons.remove_moderator
                                      :Icons.remove_red_eye_outlined

                                  )
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is!ShopRegisterLoadingState,
                            fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            builder:(context)=> defaultButton(
                              onPressed:()
                              {
                                if( formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text
                                  );


                                }
                              },
                              text:'OK',
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
