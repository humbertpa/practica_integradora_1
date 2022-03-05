import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

part 'imagen_event.dart';
part 'imagen_state.dart';

class ImagenBloc extends Bloc<ImagenEvent, ImagenState> {
  ImagenBloc() : super(ImagenInitial()) {
    on<ImagenEvent>(_request);
  }

  final String url = 'https://picsum.photos/v2/list';

  void _request(ImagenEvent event, Emitter emisor) async {
    var mapInfo = await _importarJson();
    mapInfo != null
        ? emisor(ImagenSuccess(successMsg: mapInfo[Random().nextInt(30)]))
        : emisor(ImagenError(errorMsg: "No hay datos disponibles"));
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
