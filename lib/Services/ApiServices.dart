import 'dart:convert';

import 'package:flutter_application_20/Model/WorldModel.dart';
import 'package:http/http.dart'as http;

class ApiServices{
static  Future<WorldModel> getworldstat()async{
    final response=await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      return WorldModel.fromJson(data);
    }
    else{
      throw Exception("Error");
    }
  }
  static  Future<List<dynamic>> getworldlist()async{
    var data;
    final response=await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
    if(response.statusCode==200){
       data=jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception("Error");
    }
  }
}