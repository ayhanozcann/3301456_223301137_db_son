import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dba_3301456_223301137/ogretmen.dart';
import 'package:dba_3301456_223301137/ogrdetay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ogrdetay.dart';

class Ogrenciler extends StatefulWidget {

  @override
  State<Ogrenciler> createState() => _OgrencilerState();
}

class _OgrencilerState extends State<Ogrenciler> {
  @override
  Widget build(BuildContext context) {


    TextEditingController ct_Kuladi=new TextEditingController();
    TextEditingController ct_Sifre=new TextEditingController();

    void kontrol(){
       if ((ct_Kuladi.text=="ayhan") && (ct_Sifre.text=="123")) {
        var data =[];
        data.add(ct_Kuladi.text);
        data.add(ct_Sifre.text);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    Ogrdetay(), settings: RouteSettings(arguments: data)));


      }else {
        ct_Sifre.text="bi hata var";
      }
    }

    bool butonPasif=false;


    return Scaffold(
      appBar: AppBar(title: Text('Öğrenci Sayfası'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sayfamıza Hoşgeldiniz!'),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.lime,
              backgroundImage: AssetImage('assets/ttatl1.png'),
            ),
            Text(
              'Öğrenci Giriş Sayfası',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 45,
                color: Colors.brown[900],
              ),
            ),
            const Text(
              'Kullanıcı Adınız:',
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Kullanıcı Adınızı Giriniz'),
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
              controller:ct_Kuladi ,
               ),
            const Text(
              'Şifreniz:',
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Şifrenizi Giriniz'),
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
              controller: ct_Sifre,
            ),

        ElevatedButton(  onPressed: ( butonPasif ? null : kontrol ) ,  child: Text('Giriş Yap')),
          ],
          ),
      ),
    );
  }
}

