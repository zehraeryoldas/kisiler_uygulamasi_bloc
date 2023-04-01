import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/kisi_kayit_cubit.dart';

class KisiKayit extends StatefulWidget {
  const KisiKayit({super.key});

  @override
  State<KisiKayit> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiKayit> {
  var kisiAd = TextEditingController();
  var kisiTel = TextEditingController();
  // void kaydet(String ad, int kisiTel) async {

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi kayıt"),
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
                  // kaydet(kisiAd.text, int.parse(kisiTel.text));
                  context
                      .read<KisiKayitCubit>()
                      .Kayit(kisiAd.text, int.parse(kisiTel.text));
                },
                child: Text("Kaydet"))
          ],
        ),
      ),
    );
  }
}
