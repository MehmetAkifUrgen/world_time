import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{

  String location;//Lokasyon adı
  String time; // Lokasyonun zamanı
  String flag; // bayrak url si
  String url;   // lokasyon url si
  bool isDaytime;


  WorldTime({this.location,this.flag,this.url});

  Future<void>  getTime() async {

    try{

      //Json
      Response response= await get("http://worldtimeapi.org/api/timezone/$url");
      Map data=jsonDecode(response.body);
      //print(data["datetime"]);
      String datetime= data["datetime"];
      String offset = data["utc_offset"].substring(1,3);

      // DateTime

      DateTime now= DateTime.parse(datetime);
      now=now.add(Duration(hours:int.parse(offset) ));


      isDaytime = now.hour > 6 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now);

    }
    catch (e){
      print("Error : $e");
      time="zaman bulunamadı.";
    }



  }

}


