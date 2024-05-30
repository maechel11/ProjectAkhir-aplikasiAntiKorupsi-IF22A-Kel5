import 'dart:convert';
import 'package:snow_login/config/api.dart';
import 'package:snow_login/model/faq.dart';
import 'package:http/http.dart' as http;

class EventDb {
static Future<List<Faq>> getFaq() async {
    List<Faq> listFaq = [];

    try {
      var response = await http.get(Uri.parse(Api.getFaq));
      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var faq = responBody['faq'];

          faq.forEach((faq) {
            listFaq.add(Faq.fromJson(faq));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return  listFaq;
  } 

}