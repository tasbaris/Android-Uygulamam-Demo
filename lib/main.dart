import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sondakika_app/constants/constants.dart';
import 'package:sondakika_app/pages/havaDurumu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'haber.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> linkler = [
    'https://www.sozcu.com.tr/rss/son-dakika.xml',
    'https://www.sozcu.com.tr/rss/spor.xml',
    'https://www.sozcu.com.tr/rss/saglik.xml',
    'https://www.sozcu.com.tr/rss/bilim-teknoloji.xml',
    'https://www.sozcu.com.tr/rss/egitim.xml',
    'https://www.sozcu.com.tr/rss/ekonomi.xml',
  ];

  bool isloading = true;
  List<Haber> gelenHaber = [];

  Future getData(String link) async {
    gelenHaber.clear();
    Uri url = Uri.parse(link);
    var res = await http.get(url);
    String xmlString = res.body;
    var document = XmlDocument.parse(xmlString);
    var haberler = document.findAllElements('item');
    haberler.forEach((element) {
      //print();        Başlık
      //print(element.children[9].text);        icerik
      //print(element.children[7].getAttribute("href"));     Link
      //print(element.children[15].getAttribute("url"));     img
      setState(() {
        gelenHaber.add(Haber(
            img: element.children[15].getAttribute("url").toString(),
            baslik: element.children[1].text,
            icerik: element.children[9].text,
            link: element.children[7].getAttribute("href").toString()));
      });
      setState(() {
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData(linkler[0]);
  }

  String appBartitle = 'Son Dakika';
  Color appBarColor = Colors.red;
  int anlikIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haberler',
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              appBartitle,
              style: Constants.appBarTextStyle,
            ),
            centerTitle: true,
            backgroundColor: appBarColor,
          ),
          drawer: Drawer(
            width: 220,
            child: Builder(builder: (context) {
              return ListView(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        getData(linkler[0]);
                        anlikIndex = 0;
                        appBartitle = 'Son Dakika';
                        appBarColor = Colors.red;
                        Navigator.of(context).pop();
                      });
                    },
                    title: const Text(
                      'Son Dakika',
                      style: TextStyle(
                        color: Colors.red,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.red,
                    ),
                    leading: const Icon(
                      Icons.warning_amber,
                      color: Colors.red,
                      shadows: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      setState(() {
                        getData(linkler[1]);
                        anlikIndex = 1;
                        appBartitle = 'Spor';
                        appBarColor = Colors.orange;
                        Navigator.of(context).pop();
                      });
                    },
                    title: const Text(
                      'Spor',
                      style: TextStyle(
                        color: Colors.orange,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.orange,
                    ),
                    leading: const Icon(
                      Icons.sports_basketball_sharp,
                      color: Colors.orange,
                      shadows: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      setState(() {
                        getData(linkler[2]);
                        anlikIndex = 2;
                        appBartitle = 'Sağlık';
                        appBarColor = Colors.red;
                        Navigator.of(context).pop();
                      });
                    },
                    title: const Text(
                      'Sağlık',
                      style: TextStyle(
                        color: Colors.red,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.red,
                    ),
                    leading: const Icon(
                      Icons.medical_services_sharp,
                      color: Colors.red,
                      shadows: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      getData(linkler[3]);
                      anlikIndex = 3;
                      appBartitle = 'Bilim ve Teknoloji';
                      appBarColor = Colors.grey;
                      Navigator.of(context).pop();
                    },
                    title: const Text(
                      'Bilim ve Teknoloji',
                      style: TextStyle(
                        color: Colors.grey,
                        shadows: [
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 1),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right_outlined),
                    leading: const Icon(
                      Icons.computer_sharp,
                      shadows: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      anlikIndex = 4;
                      getData(linkler[4]);
                      appBartitle = 'Eğitim';
                      appBarColor = Colors.brown;
                      Navigator.of(context).pop();
                    },
                    title: const Text(
                      'Eğitim',
                      style: TextStyle(
                        color: Colors.brown,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.brown,
                    ),
                    leading: const Icon(
                      Icons.book,
                      color: Colors.brown,
                      shadows: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      getData(linkler[5]);
                      anlikIndex = 5;
                      appBartitle = 'Ekonomi';
                      appBarColor = Colors.blue;
                      Navigator.of(context).pop();
                    },
                    title: const Text(
                      'Ekonomi',
                      style: TextStyle(
                        color: Colors.blue,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 3)
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.blue,
                    ),
                    leading: const Icon(
                      Icons.moving_rounded,
                      color: Colors.blue,
                      shadows: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ],
                    ),
                  ),
                  const Divider(),
                  Builder(builder: (context) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HavaDurumuPage(),
                            ));
                        anlikIndex = 5;
                        appBartitle = 'Hava Durumu';
                      },
                      title: const Text(
                        'Hava Durumu',
                        style: TextStyle(
                          color: Colors.black,
                          shadows: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 1),
                                blurRadius: 3)
                          ],
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_outlined,
                        color: Colors.grey,
                      ),
                      leading: const Icon(
                        Icons.cloud,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 5)
                        ],
                      ),
                    );
                  }),
                  const Divider()
                ],
              );
            }),
          ),
          body: RefreshIndicator(
              onRefresh: () {
                return getData(linkler[anlikIndex]);
              },
              child: isloading == true
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: gelenHaber.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              habereGit(gelenHaber[index].link);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 6,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        child: Image.network(
                                          gelenHaber[index].img,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(gelenHaber[index].baslik,
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                        fontSize: 24)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(gelenHaber[index].icerik)
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          )))),
    );
  }
}

habereGit(String link) async {
  try {
    if (await canLaunchUrlString(link)) {
      await launchUrlString(link, mode: LaunchMode.inAppWebView);
    }
  } catch (e) {}
}
