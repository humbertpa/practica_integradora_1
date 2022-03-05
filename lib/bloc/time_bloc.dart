import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeInitial()) {
    on<TimeEvent>(_request);
  }

  static final tiempoPaises = [
    "Europe/Andorra",
    "America/Mexico_City",
    "America/Lima",
    "America/Argentina/Buenos_Aires",
    "America/Vancouver",
  ];

  int ciudad = 0;

  void _request(TimeEvent event, Emitter emisor) async {
    var mapInfo = await _importarJson();
    mapInfo != null
        ? emisor(TimeSuccess(successMsg: mapInfo))
        : emisor(TimeError(errorMsg: "No hay datos disponibles"));
  }

  Future _importarJson() async {
    var ciudadUrl = "http://worldtimeapi.org/api/timezone/";
    ciudadUrl += tiempoPaises[ciudad];
    try {
      Response res = await get(Uri.parse(ciudadUrl));
      if (res.statusCode == HttpStatus.ok) {
        //print("se regresa json de time");
        //print(jsonDecode(res.body));
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
