
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{

  static Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError:true,
      )
    );
  }

  static Future<Response<dynamic>> getData({
    @required String?url,
    Map<String, dynamic>?query,
    String language='en',
    String? token,
  })async
  {
    dio!.options.headers={
      'lang':language,
      'Authorization':token,

    };
    return dio!.get(
      url!,
      queryParameters: query,
    );

  }


  static Future<Response<dynamic>?> postData(
  {
    required String url,
    Map<String, dynamic>?query,
    @required Map<String, dynamic>?data,
    String language='en',
    String? token,

  })async
  {
    dio!.options.headers={
      'Content-Type': 'application/json',
      'lang':language,
      'Authorization':token,
    };
    return await dio!.post(
        url,
        queryParameters: query,
        data:data
    );

  }

  static Future<Response<dynamic>>? putData({
    required String url,
    Map<String, dynamic>?query,
    @required Map<String, dynamic>?data,
    String language='en',
    String? token,

})async
  {
    dio!.options.headers={
      'Content-Type': 'application/json',
      'lang':language,
      'Authorization':token,
    };

    return await dio!.put(
        url,
        queryParameters: query,
        data:data
    );
  }
}