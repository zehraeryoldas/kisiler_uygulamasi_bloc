import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/anaSayfa_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/views/kisiDetay.dart';
import 'package:kisiler_uygulamasi_bloc/views/kisiKayit.dart';
import 'package:kisiler_uygulamasi_bloc/model/kisiler.dart';

class anaSayfa extends StatefulWidget {
  const anaSayfa({super.key});

  @override
  State<anaSayfa> createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {
  bool aramaYapiliyorMu = false;
  // Future<List<Kisiler>> tumKisileriGoster() async {
  //   var kisilerListesi = <Kisiler>[];
  //   var k1 = Kisiler(1, "zehra", "09111");
  //   var k2 = Kisiler(2, "gokhan", "01118");
  //   var k3 = Kisiler(3, "ayse", "11110");
  //   var k4 = Kisiler(4, "mehmet", "11111");

  //   kisilerListesi.add(k1);
  //   kisilerListesi.add(k2);
  //   kisilerListesi.add(k3);

  //   kisilerListesi.add(k4);

  //   return kisilerListesi;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnaSayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: InputDecoration(hintText: "Ara"),
                onChanged: (aramaSonucu) {
                  context.read<AnaSayfaCubit>().kisiAra(aramaSonucu);
                },
              )
            : Text("Kişiler"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      context.read<AnaSayfaCubit>().kisileriYukle();
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      // body: FutureBuilder<List<Kisiler>>(
      //   future: tumKisileriGoster(),
      //   builder: ((context, snapshot) {
      //     if (snapshot.hasData) {
      //       var kisilerListesi = snapshot.data;
      //       return ListView.builder(
      //           itemCount: kisilerListesi!.length,
      //           itemBuilder: ((context, index) {
      //             var kisi = kisilerListesi[index];
      //             return GestureDetector(
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => KisiDetay(kisiler: kisi)));
      //               },
      //               child: Card(
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Row(
      //                     children: [
      //                       Text("${kisi.kisi_ad} -${kisi.kisi_tel}"),
      //                       Spacer(),
      //                       IconButton(
      //                           onPressed: () {
      //                             ScaffoldMessenger.of(context)
      //                                 .showSnackBar(SnackBar(
      //                               content:
      //                                   Text("${kisi.kisi_ad} silinsin mi?"),
      //                               action: SnackBarAction(
      //                                   label: "EVET",
      //                                   onPressed: () {
      //                                     print("Kişi Sil : ${kisi.kisi_id}");
      //                                   }),
      //                             ));
      //                           },
      //                           icon: Icon(Icons.delete_outline))
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           }));
      //     } else {
      //       return Center();
      //     }
      //   }),
      // ),
      body: BlocBuilder<AnaSayfaCubit, List<Kisiler>>(
        builder: ((context, kisilerListesi) {
          if (kisilerListesi.isNotEmpty) {
            return ListView.builder(
                itemCount: kisilerListesi.length,
                itemBuilder: ((context, index) {
                  var kisi = kisilerListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KisiDetay(kisiler: kisi))).then((value){
                                context.read<AnaSayfaCubit>().kisileriYukle();
                              });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("${kisi.kisi_ad} -${kisi.kisi_tel}"),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("${kisi.kisi_ad} silinsin mi?"),
                                    action: SnackBarAction(
                                        label: "EVET",
                                        onPressed: () {
                                          print("Kişi Sil : ${kisi.kisi_id}");
                                          context.read<AnaSayfaCubit>().kisileriSil(kisi.kisi_id);
                                        }),
                                  ));
                                },
                                icon: Icon(Icons.delete_outline))
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          } else {
            return Center();
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => KisiKayit()))
              .then((value) {context.read<AnaSayfaCubit>().kisileriYukle();});
          //  var kisi= Kisiler(1, "zehra", "099");
          //        Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => KisiDetay(kisiler: kisi,)))
          //       .then((value) => print("anasayfaya dönüldü"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
