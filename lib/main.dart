import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/anaSayfa_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/kisi_detay_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/kisi_kayit_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => KisiKayitCubit())),
        BlocProvider(create: ((context) => KisiDetayCubit())),
        BlocProvider(create: ((context) => AnaSayfaCubit())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: anaSayfa(),
      ),
    );
  }
}
