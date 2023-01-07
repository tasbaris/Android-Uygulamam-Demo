// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sondakika_app/constants/constants.dart';
import 'package:xml/xml.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';

class HavaDurumuPage extends StatefulWidget {
  const HavaDurumuPage({super.key});

  @override
  State<HavaDurumuPage> createState() => _HavaDurumuPageState();
}

class _HavaDurumuPageState extends State<HavaDurumuPage> {
  static String sehir = 'istanbul';
  List<Hava> havaDurum = [];
  bool isLoading = true;
  Future getData() async {
    String link =
        'https://api.openweathermap.org/data/2.5/weather?q=$sehir&lang=tr&units=metric&mode=xml&appid=${Datas.api}';
    havaDurum.clear();
    print(havaDurum.length);
    Uri url = Uri.parse(link);
    var res = await http.get(url);
    String xmlString = res.body;
    var document = XmlDocument.parse(xmlString);
    var havaDurumu = document.findAllElements('current');
    havaDurumu.forEach((element) {
      //print(element.children[1].getAttribute('value'));     Sıcaklık
      //print(element.children[2].getAttribute('value'));     Hissedilen Sıcaklık
      //print(element.children[3].getAttribute('value'));     Nem
      //print(element.children[9].getAttribute('value'));     Hava Durumu
      //print(element.children[9].getAttribute('icon'));      İkon
      //print(element.children[10].getAttribute('value'));    Son Güncelleme
      setState(() {
        havaDurum.add(Hava(
          sehirAdi: element.children[0].getAttribute('name').toString(),
          sicaklik: element.children[1].getAttribute('value').toString(),
          havaDurumu: element.children[9].getAttribute('value').toString(),
          nem: element.children[3].getAttribute('value').toString(),
          ikon: element.children[9].getAttribute('icon').toString(),
          sonGuncellenme: element.children[10].getAttribute('value').toString(),
          hsicaklik: element.children[2].getAttribute('value').toString(),
        ));
      });
      setState(() {
        print(element.children[0].getAttribute('name'));
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Hava Durumu'),
          centerTitle: true,
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            label: Text('Şehir Adı'),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(116))),
                            hintText: 'Şehir adını giriniz'),
                        onChanged: (value) {
                          setState(() {
                            sehir = value;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                              getData();
                            });
                          },
                          child: const Text('Göster')),
                      //******************************************************************* */
                      //                      Veriler
                      Expanded(
                        child: ListView(children: [
                          Text(
                            havaDurum.first.sehirAdi.toUpperCase(),
                            style: Constants.havaBaslik,
                          ),
                          Text(
                            'Last Update: ${havaDurum.first.sonGuncellenme.split('T')[1]}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Hava Durumu:${havaDurum.first.havaDurumu.toUpperCase()}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${havaDurum.first.sicaklik.split('.')[0]}°C',
                            style: Constants.sicaklik,
                          ),
                          Container(child: resimGoster(havaDurum.first.ikon)),
                        ]),
                      ),
                      const Text('Coder : Barış Taş  Designer: Barış Emir',
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Image resimGoster(String resim) {
    String a = resim.substring(0, 2);
    return Image.asset('assets/icons/${a}d.gif');
  }
}

class Hava {
  String sehirAdi;
  String sicaklik;
  String hsicaklik;
  String nem;
  String havaDurumu;
  String ikon;
  String sonGuncellenme;

  Hava(
      {required this.sehirAdi,
      required this.sicaklik,
      required this.hsicaklik,
      required this.nem,
      required this.havaDurumu,
      required this.ikon,
      required this.sonGuncellenme});
}
