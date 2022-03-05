import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'frase_event.dart';
part 'frase_state.dart';

class FraseBloc extends Bloc<FraseEvent, FraseState> {
  FraseBloc() : super(FraseInitial()) {
    on<FraseEvent>(_request);
  }

  final String url = 'https://zenquotes.io/api/random';

  void _request(FraseEvent event, Emitter emisor) async {
    var mapInfo = await _importarJson();
    mapInfo != null
        ? emisor(FraseSuccess(successMsg: mapInfo))
        : emisor(FraseError(errorMsg: "No hay datos disponibles"));
  }

  Future _importarJson() async {
    try {
      Response res = await get(Uri.parse(url));
      if (res.statusCode == HttpStatus.ok) {
        //print("se regresa json");
        // print(jsonDecode(res.body));
        return jsonDecode(res.body)[0];
      }
    } catch (e) {
      print(e);
    }
  }
}
