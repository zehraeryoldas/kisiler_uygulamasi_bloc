import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/kisi_detay_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/model/kisiler.dart';

class KisiDetay extends StatefulWidget {
   KisiDetay({super.key,required this.kisiler});
  Kisiler kisiler;

  @override
  State<KisiDetay> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiDetay> {
  var kisiAd = TextEditingController();
  var kisiTel = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var kisiler=widget.kisiler;
    kisiAd.text=kisiler.kisi_ad;

    kisiTel.text=kisiler.kisi_tel;
    
  }

  // void guncelle(int kisi_id,String kisi_ad,String kisi_tel) async{
    
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Güncelle"),
      ),
      body: Center(
        child: ListView(
          children: [
            TextField(
              controller: kisiAd,
              decoration: InputDecoration(labelText: "Kişi Ad"),
            ),
            TextField(
              controller: kisiTel,
              decoration: InputDecoration(labelText: "Kişi Tel"),
            ),
            ElevatedButton(
                onPressed: () {
                //  guncelle(widget.kisiler.kisi_id, kisiAd.text, kisiTel.text);
                context.read<KisiDetayCubit>().guncelle(widget.kisiler.kisi_id, kisiAd.text, kisiTel.text);
                },
                child: Text("Güncelle"))
          ],
        ),
      ),
    );
  }
}
