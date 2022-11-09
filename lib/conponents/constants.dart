
import 'package:shop/conponents/conponents.dart';
import 'package:shop/login_Screen/login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';


//method Sign out from home to login screen
signOut(context) {
  CacheHelper.removeData(key: 'token')!.then((value) {
    if (value) {
      navigateAndFinish(context,  LoginScreen());
    }
  });
}

String? token;
bool? onBoarding;

var productImage;
var productTitle;
var productName;