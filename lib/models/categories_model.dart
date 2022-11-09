class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic>json,){

    status=json['status'];

    data=json['data']!=null? CategoriesDataModel.fromJson(json['data']):null;

  }

}


class CategoriesDataModel{

  int? currentPage;
  List<CategoriesData>?categories;
  CategoriesDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    if (json['data'] != null) {
      categories = [];
    json['data'].forEach((element)
    {
      categories!.add(CategoriesData.fromJson(element));
    });

  }}

Map<String,dynamic> toJson(){
    final Map<String,dynamic>data= Map<String,dynamic>();
    if(categories!=null){
      
      data['data'] =categories!.map((e) =>e.toJson).toList();
    }
    
    
    
    return data;
    
}

}

class CategoriesData{
  int? id;
  String? name;
  String? image;

  CategoriesData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];

  }
  Map<String,dynamic> toJson(){
    final Map<String,dynamic>data =Map<String,dynamic>();
    data['id']=id;
    data['name']=name;
    data['image']=image;

    return data;
  }
}