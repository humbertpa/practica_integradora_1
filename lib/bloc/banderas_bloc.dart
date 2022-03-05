import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banderas_event.dart';
part 'banderas_state.dart';

class BanderasBloc extends Bloc<BanderasEvent, BanderasState> {
  BanderasBloc() : super(BanderasInitial()) {
    on<BanderasEvent>(_request);
  }

  final String url = 'https://flagcdn.com/en/codes.json';

  void _request(BanderasEvent event, Emitter emisor) async {
    var mapInfo = await _importarJson();
    mapInfo != null
        ? emisor(BanderasSuccess(successMsg: mapInfo))
        : emisor(BanderasError(errorMsg: "No hay datos disponibles"));
  }

  Future _importarJson() async {
    try {
      Response res = await get(Uri.parse(url));
      if (res.statusCode == HttpStatus.ok) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
