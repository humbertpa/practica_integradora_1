import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:practica_1/bloc/time_bloc.dart';
import 'package:practica_1/homepage.dart';
import 'bloc/banderas_bloc.dart';
import 'bloc/frase_bloc.dart';
import 'bloc/imagen_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      title: 'Material App',
      home: FeatureDiscovery.withProvider(
        persistenceProvider: NoPersistenceProvider(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => BanderasBloc()..add(BanderasJsonEvent())),
            BlocProvider(
                create: (context) => FraseBloc()..add(FraseJsonEvent())),
            BlocProvider(create: (context) => TimeBloc()..add(TimeJsonEvent())),
            BlocProvider(
                create: (context) => ImagenBloc()..add(ImagenJsonEvent())),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}

class ImagenesBloc {}
