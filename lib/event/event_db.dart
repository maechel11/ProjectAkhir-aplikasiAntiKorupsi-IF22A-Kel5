import 'dart:convert';
import 'package:get/get.dart';
import 'package:snow_login/config/api.dart';
import 'package:snow_login/event/event_pref.dart';
import 'package:snow_login/model/faq.dart';
import 'package:http/http.dart' as http;
import 'package:snow_login/model/tentangkami.dart';
import 'package:snow_login/model/user.dart';
import 'package:snow_login/screens/dashboard.dart';
import 'package:snow_login/widget/info.dart';

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


  static Future<List<Tentang>> getTentang() async {
    List<Tentang> tentangKami = [];

    try {
      var response = await http.get(Uri.parse(Api.getTentang));
      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var tentangkami = responBody['tentangkami'];

          tentangkami.forEach((tentangkami) {
            tentangKami.add(Tentang.fromJson(tentangkami));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return  tentangKami;
  } 


  
  static Future<String> adduser(
      String username, String email, String pass,) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.adduser), body: {
        'text_username': username,
        'text_email': email,
        'text_pass': pass,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Registrasi Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }

    return reason;
  }


   static Future<User?> login(String username, String pass) async {
    User? user;

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'text_username': username,
        'text_pass': pass,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);

        if (responBody['success']) {
          user = User.fromJson(responBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
        } else {
          Info.snackbar('Login Gagal');
        }
      } else {
        Info.snackbar('Request Login Gagal');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}