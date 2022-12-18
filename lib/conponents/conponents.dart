
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/style/color.dart';

Widget myDivider()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);

Future navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false);

Future navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>widget
  )

);

Widget defaultTextFromFiled({
  @required TextEditingController? controller,
  @required String? Function(String?)? validator,
  @required TextInputType? keyboardType,
  Function(String)? onChanged,
  Function()? onTap,
  void Function(String)? onFieldSubmitted,
  @required Icon? prefixIcon,
  @required String? label,
  InputBorder? border,
  int maxLines=1,
  TextStyle? style,
  IconButton? suffixIcon,
  bool obscureText=false,
  bool?enabled,
}
)=>TextFormField(
  controller:controller ,
  enabled:enabled ,
  validator:validator ,
  keyboardType:keyboardType ,
  onChanged:onChanged ,
  onTap:onTap ,
  onFieldSubmitted: onFieldSubmitted,
  maxLines:maxLines ,
  style: style,
  obscureText:obscureText,
  decoration:InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon:suffixIcon,
    label: Text(label!),
    border:border,

  ) ,

);


Widget defaultButton({
  @required void Function()? onPressed,
  @required String? text,
  MaterialStateProperty<Color?>?bgColor,
  MaterialStateProperty<double?>? elevation,
  double?width,
  double?height,
})=>SizedBox(
  width:width ,
  height:height,
  child:ElevatedButton(
    onPressed:onPressed ,
    style: ButtonStyle(
      backgroundColor: bgColor,
      elevation: elevation,
    ),
    child:Text(text!),
  ),
);


Widget defaultTextButton({
  @required void Function()? onPressed,
  @required String? text,
  double?fontSize
})=> TextButton(
    onPressed:onPressed,
    child:Text(text!,
      style: TextStyle(
        fontSize: fontSize,
      ),
    )
);


void defaultToast({
  required ToastState state,
  required String message,

})=>Fluttertoast.showToast(
   msg:message,
   backgroundColor: chooseColor(state),
   fontSize: 16,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 5,
   toastLength: Toast.LENGTH_LONG,
   textColor: Colors.white,
 );

enum ToastState {success,error,warning}

 Color chooseColor(ToastState state)
{
   Color color;

  switch(state)
  {
    case ToastState.success
       :color=Colors.green;
    break;

    case ToastState.error
       :color=Colors.red;
    break;

    case ToastState.warning
       :color=Colors.amber;
    break;

  }
  return color;
}


Widget buildListItemProducts( model,context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(model.image!),
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
                  fontSize: 16.0,
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
                        fontSize: 16.0
                    ),
                  ),
                  const SizedBox(width: 8,),
                  if(model.oldPrice !=model.price)
                    Text('${model.oldPrice}',
                      style: TextStyle(
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

                      icon:ShopCubit.get(context).favorites[model.id]!?
                       const  Icon(Icons.favorite):
                       const  Icon(Icons.favorite_outline),

                  ),

                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);