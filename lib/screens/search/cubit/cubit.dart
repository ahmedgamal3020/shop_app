
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/conponents/constants.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/network/end_point/end_point.dart';
import 'package:shop/network/remote/die_helper.dart';
import 'package:shop/screens/search/cubit/states.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  

}