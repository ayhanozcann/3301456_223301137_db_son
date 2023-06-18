import 'package:flutter/material.dart';
import 'package:dba_3301456_223301137/anasayfa.dart';
import 'package:dba_3301456_223301137/ayarlar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dba_3301456_223301137/model/note_model.dart';
import 'package:dba_3301456_223301137/dbHelper.dart';
import 'package:dba_3301456_223301137/screens/notes_screen.dart';

class Ogrdetay extends StatefulWidget {
  final  Note? note;
  const Ogrdetay({Key? key,this.note}) : super(key: key);

  @override
  State<Ogrdetay> createState() => _OgrdetayState();
}

class _OgrdetayState extends State<Ogrdetay> {
  @override
  final List<Widget> _tabItems = [AnaSayfa(), Ayarlar()];

  int _activePage = 0;

  get note => null;

  Widget build(BuildContext context) {
    List<dynamic>? data = [];
    String ogrAdi,ogrSifre;


    final tittleController = TextEditingController();
    final descriptionConttolller = TextEditingController();
    if (note != null) {
      tittleController.text = note!.title;
      tittleController.text = note!.description;
    }

    data = ModalRoute.of(context)?.settings.arguments as List?;
    ogrAdi = data![0];
    ogrSifre= data[1];

    return Scaffold(
        appBar: AppBar(title: Text('Hoşgeldin '+ogrAdi+"!")),
        //body: Center(child: Image.asset('../assets/ogr_orn.png',width: 350,height: 250,)),
        body:Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Column (
              children: [
                Padding(padding: EdgeInsets.only(bottom: 40),
                  child: Center(child: Text("İlgili derslerden aldığım sınav  notlarım..?",
                    style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),),),
                Padding(padding: EdgeInsets.only(bottom: 40),
                    child: TextFormField(
                      controller: tittleController,
                      maxLines:1,
                      decoration: const InputDecoration(
                          hintText:  'İlgili Ders Adı',
                          labelText: 'Ders Adı',
                          border:OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:Colors.white,
                                  width: 0.75
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          )
                      ),
                    )
                ),
                TextFormField(
                  onChanged: (str){},
                  controller: descriptionConttolller,
                  maxLines:1,
                  decoration: const InputDecoration(
                      hintText:  'Ders Notu',
                      labelText: 'Ders Notunu Giriniz',
                      border:OutlineInputBorder(
                          borderSide: BorderSide(
                              color:Colors.white,
                              width: 0.75
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)
                          )
                      )
                  ),
                ),
                Spacer(),
                Padding(padding: const EdgeInsets.only(bottom:20.0),
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(onPressed: () async {
                      final title = tittleController.value.text;
                      final description = descriptionConttolller.value.text;
                      if (title.isEmpty || description.isEmpty) {
                        return;
                      }
                      final Note model = Note(
                          title: title, description: description,
                          id:note?.id
                      );
                      if (note == null) {
                        await DatabaseHelper.addNote(model);
                      }
                      else {
                        DatabaseHelper.updateNote(model);
                      }
//                    Navigator.pop(context);

                      //var data =[];
                      // ignore: use_build_context_synchronously
                      //data.add(ct_Kuladi.text);
                      //data.add(ct_Sifre.text);

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  NotesScreen(), settings: RouteSettings(arguments: note)));

                    },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    side:BorderSide(
                                        color:Colors.white,
                                        width: 0.75
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                )
                            )
                        ),
                        child:Text(note == null ? "Kaydet" : "Güncelle",
                          style: TextStyle(fontSize: 20),
                        )
                    ),),
                ),

              ],
            )
        )

    );
  }
}

