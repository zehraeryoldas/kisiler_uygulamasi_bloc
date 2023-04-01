//repo da amacım veri tabanında kayıt yapmak
// ignore_for_file: prefer_collection_literals

import 'package:kisiler_uygulamasi_bloc/model/kisiler.dart';
import 'package:kisiler_uygulamasi_bloc/sqlite/veritabaniYardimcisi.dart';

class KisilerRepository {
  // Future<void> kisiKayit(String ad, int kisiTel) async {
  //   print("Kişi kayıt : ${ad} - ${kisiTel}");
  // }

  Future<void> kisiKayit(String ad, int kisiTel) async {
    var db = await veriTabaniYardimcisi.veritabaniErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler['kisi_ad']=ad;
    bilgiler['kisi_tel']=kisiTel;
     await db.insert("kisiler", bilgiler);

  }

  Future<void> kisiGuncelle(int kisi_id,String kisi_ad, String kisiTel) async {
    var db = await veriTabaniYardimcisi.veritabaniErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler['kisi_ad']=kisi_ad;
    bilgiler['kisi_tel']=kisiTel;
     await db.update("kisiler",bilgiler,where: 'kisi_id=?',whereArgs: [kisi_id]);

  }

  // Future<void> guncelle(int kisiId, String kisiAd, String kisiTel) async {
  //   print("Kişi kayıt : ${kisiAd} - ${kisiTel}");
  // }

  // Future<List<Kisiler>> tumKisileriAl() async {
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

  Future<List<Kisiler>> tumKisileriAl() async {
    var db = await veriTabaniYardimcisi.veritabaniErisim();
    //ilk önce veritabanı üzerinde sorgulama yapacağız.
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT *FROM kisiler"); //bu yapı veritabanındaki bilgileri bana satır satır getirecektir.
    return List.generate(maps.length, (i) {
      var satir = maps[i]; //buradan satır satır alacağız
      return Kisiler(satir['kisi_id'], satir['kisi_ad'], satir['kisi_tel']);
    });
  }

  // Future<List<Kisiler>> kisiAra(String aramaKelimesi) async{
  //   var kisilerListesi=<Kisiler>[];
  //   var k1=Kisiler(1, "Zehra", "09111");
  //   kisilerListesi.add(k1);
  //   return kisilerListesi;
  // }

  Future<List<Kisiler>> kisiAra(String aramaKelimesi) async {
    var db = await veriTabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT *FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kisiler(satir['kisi_id'], satir['kisi_ad'], satir['kisi_tel']);
    });
  }

  // Future<void> kisiSil(int kisiId) async {
  //   print("Kişi Sil : ${kisiId}");
  // }

  Future<void> kisiSil(int kisi_id) async{
    var db=await veriTabaniYardimcisi.veritabaniErisim();
    await db.delete("kisiler",where: 'kisi_id=?',whereArgs: [kisi_id]);
  }
}
