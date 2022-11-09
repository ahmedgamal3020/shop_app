import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/login_Screen/cubit/cubit.dart';
import 'package:shop/login_Screen/cubit/states.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/register_screen/register.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);


  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state)async{
            if(state is ShopLoginSuccessState) {
              if(state.model.status!) {

                await CacheHelper.saveData(
                    key: 'token',
                    value: state.model.data!.token).then((value) {
                   token= state.model.data!.token;

                  defaultToast(
                      state: ToastState.success,
                      message: state.model.message!);

                });
                 navigateAndFinish(context,  HomeScreen());

              }else{
                defaultToast(
                    state: ToastState.error,
                    message: state.model.message!);
              }
            }
          },
          builder: (context,state){
            var cubit =ShopLoginCubit.get(context);
            return Form(
              key: formKey,
              child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'LOGIN',
                              style:TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          defaultSizedBox(),
                          const Text(
                            'login new to browse our hot offers',
                            style: TextStyle(
                                fontSize: 19
                            ),
                          ),
                          defaultSizedBox(),
                          Container(
                            child: defaultTextFromFiled(
                                controller: emailController,
                                validator: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'Enter You Email';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon:const Icon(Icons.email_outlined),
                                label: 'Email Address',
                                border:const OutlineInputBorder()
                            ),
                          ),
                          defaultSizedBox(),
                          Container(
                            child: defaultTextFromFiled(
                                controller: passwordController,
                                obscureText: cubit.isPassword,
                                validator: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'must to be not empty';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon:const Icon(Icons.lock_outline),
                                label: 'Password',
                                suffixIcon:IconButton(
                                    onPressed:()
                                    {
                                      cubit.showPassword();
                                    },
                                    icon:Icon(cubit.isPassword?Icons.remove_red_eye_outlined
                                        :Icons.remove_moderator
                                    )
                                ),
                                border:const OutlineInputBorder()
                            ),
                          ),
                           defaultSizedBox(),
                          ConditionalBuilder(
                            condition: state is!ShopLoginLoadingState,
                            fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            builder:(context)=> defaultButton(
                              onPressed:()
                              {
                               if( formKey.currentState!.validate()) {
                                 cubit.userLogin(
                                     email: emailController.text,
                                     password: passwordController.text
                                 );

                               }
                              },
                              text:'LOGIN',
                              width: double.infinity,
                            ),
                          ),
                          defaultSizedBox(),
                          defaultTextButton(
                              onPressed:()
                          {
                            navigateTo(context, RegisterScreen());
                          },
                              text:'Register'
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
    }
      )
    );
  }
}

Widget defaultSizedBox()=> const SizedBox
  (
    height: 15,
);