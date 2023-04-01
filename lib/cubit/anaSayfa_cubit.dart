import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/model/kisiler.dart';
import 'package:kisiler_uygulamasi_bloc/repo/kisilerDaoRepository.dart';

//amacımız listeyi sürekli arayüze göndermek tabi bunu göndermek için emit dediğmiz yapıyı kullancağız
class AnaSayfaCubit extends Cubit<List<Kisiler>>{
  AnaSayfaCubit() : super(<Kisiler>[]);
  //repoya erişmek için öncelikle bu nesneye ihtiyacımız var
  var kRepo=KisilerRepository();
  Future<void> kisileriYukle() async{
    var liste=await kRepo.tumKisileriAl();
    emit(liste);
  }

  Future<void> kisileriSil(int kisi_id) async{
    await kRepo.kisiSil(kisi_id);
    //kişileri yükle dememizin sebebi veri silindikten sonra arayüzde silinmiş halini görebilmemiz
    await kisileriYukle();
  }

  Future<void> kisiAra(String kisiAra) async{
   var liste= await kRepo.kisiAra(kisiAra);
    emit(liste);
  }

}