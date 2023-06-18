import 'package:flutter/material.dart';
import 'package:dba_3301456_223301137/ogretmen.dart';
import 'package:dba_3301456_223301137/ogrenciler.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ümitköy Türk Telekom MTAL-Bilişim Teknolojileri Alanı',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),


      home: const MyHomePage(title: 'Türk Telekom MTAL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String ogrAdiSoyadi = '';

  void bilgiyiOgretmenSayfasinaGonder() {
    var veri = [];
    veri.add(ogrAdiSoyadi);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Ogretmen(),
        settings: RouteSettings(
            arguments: veri))
    );
  }

  void bilgiyiOgrenciSayfasinaGonder() {
    var veri = [];
    veri.add(ogrAdiSoyadi);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Ogrenciler(),
        settings: RouteSettings(
            arguments: veri))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Türk Telekom Mesleki ve Teknik Anadolu Lisesi',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 8,
                  wordSpacing: 15,
                  backgroundColor: Colors.white,
                  shadows: [
                    Shadow(color: Colors.blueAccent,
                        offset: Offset(2, 1),
                        blurRadius: 10)
                  ]
              ),
            ),

            Image.asset('assets/ttatl1.png',
              width: 500,
              height: 400,

            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: ElevatedButton(
                onPressed: () {
                  bilgiyiOgretmenSayfasinaGonder();
                },
                child: Text('Öğretmenlerimiz'),
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: ElevatedButton(
                onPressed: () {
                  bilgiyiOgrenciSayfasinaGonder();
                },
                child: Text('Öğrencilerimiz'),
              ),

            ),


          ],
        ),
      ),

    );
  }
}

/**/
class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.isim),
        )
    );
  }
}


class User {
  final int index;

  final String isim;


  User(this.index, this.isim);

}


