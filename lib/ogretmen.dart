import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dba_3301456_223301137/OgretmenKisiselBilgileri.dart';
import 'package:flutter/services.dart' as rootBundle;

class DetaySayfasi extends StatelessWidget {
  TextEditingController Mesaj = new TextEditingController();
  final OgretmenKisiselBilgileri ogretmen;

  DetaySayfasi(this.ogretmen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Öğretmenin Bilgileri"),
        ),
        body: Column(children: <Widget>[
          Center(
              child: CircleAvatar(
            radius: 100,
            child: ClipOval(
              child: Image.network(
                ogretmen.minikResim.toString(),
                fit: BoxFit.cover,
              ),
            ),
          )),
          Center(
              child: Text(
            ogretmen.kuladi.toString() +
                " Eposta adresi: " +
                ogretmen.eposta.toString(),
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.5),
          )),
          SizedBox(
              width: 550, // <-- TextField width
              height: 120, // <-- TextField height
              child: TextFormField(
                  controller: Mesaj,
                  minLines: 6,
                  // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Göndermek istediğiniz mesajı giriniz.'))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: ElevatedButton(
              onPressed: () {
                final url = Uri.encodeFull('mailto:' +
                    ogretmen.eposta.toString() +
                    '?subject=TTMTAL E-Posta Gönderimi&body=' +
                    Mesaj.text);
                launch(url);
              },
              child: Text('Mail Gönder'),
            ),
          ),
        ]));
  }
}

class Ogretmen extends StatefulWidget {
  const Ogretmen({Key? key}) : super(key: key);

  @override
  State<Ogretmen> createState() => _OgretmenState();
}

class _OgretmenState extends State<Ogretmen> {
  @override
  Widget build(BuildContext context) {
    var personellistesi = [];


    return Scaffold(
        appBar: AppBar(title: Text('Öğretmenler Hakkımda')),
        body: FutureBuilder(
          future: JsonOgretmenVerileriOku(),
          builder: (context, jsonVerisi) {
            if (jsonVerisi.hasError) {
              return Center(child: Text("${jsonVerisi.error}"));
            } else if (jsonVerisi.hasData) {
              var items = jsonVerisi.data as List<OgretmenKisiselBilgileri>;
              return ListView.builder(
                  itemCount: items == null ? 0 : items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(items[index].minikResim.toString()),
                      ),
                      title: Text(items[index].kuladi.toString()),
                      subtitle: Text(items[index].eposta.toString()),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    DetaySayfasi(items[index])));
                      },
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<List<OgretmenKisiselBilgileri>> JsonOgretmenVerileriOku() async {
    final jsonVerisi = await rootBundle.rootBundle
        .loadString('assets/ogretmen_bilgileri.json');
    final list = json.decode(jsonVerisi) as List<dynamic>;

    return list.map((e) => OgretmenKisiselBilgileri.fromJson(e)).toList();
  }
}
