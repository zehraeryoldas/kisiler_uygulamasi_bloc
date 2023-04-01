import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/repo/kisilerDaoRepository.dart';

class KisiDetayCubit extends Cubit<void>{
  KisiDetayCubit() : super(0);
  var kRepo=KisilerRepository();
  Future<void> guncelle(int kisi_id,String kisi_ad,String kisi_tel) async{
    await kRepo.kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
  }
}