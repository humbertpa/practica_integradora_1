import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_1/bloc/banderas_bloc.dart';
import 'package:practica_1/bloc/frase_bloc.dart';
import 'package:practica_1/bloc/imagen_bloc.dart';
import 'package:practica_1/bloc/time_bloc.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      headerHeight: 300,
      appBar: AppBar(
        title: const Text("La frase diaria"),
        actions: const <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          )
        ],
      ),
      backLayer: BlocConsumer<BanderasBloc, BanderasState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BanderasSuccess) {
            var paises = ['ad', 'mx', 'pe', 'ar', 'ca'];
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: paises.length, // state.successMsg.length,
              itemBuilder: (BuildContext context, int index) {
                //String key = state.successMsg.keys.elementAt(index);
                String key = paises.elementAt(index);
                return TextButton(
                  onPressed: () {
                    BlocProvider.of<TimeBloc>(context).ciudad = index;
                    BlocProvider.of<TimeBloc>(context).add(TimeJsonEvent());
                    BlocProvider.of<FraseBloc>(context).add(FraseJsonEvent());
                    BlocProvider.of<ImagenBloc>(context).add(ImagenJsonEvent());
                  },
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.network(
                                "https://flagcdn.com/16x12/" + key + ".png")),
                        Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(state.successMsg[key],
                                style: TextStyle(color: Colors.white)))
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is BanderasError) {
            return Text(state.errorMsg);
          } else {
            return Text("");
          }
        },
      ),
      frontLayer: Stack(
        children: [
          BlocConsumer<ImagenBloc, ImagenState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ImagenSuccess) {
                print(state.successMsg);
                print(state.successMsg['url']);
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.7), BlendMode.srcOver),
                      image: NetworkImage(state.successMsg["download_url"]),
                      // image: NetworkImage("https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg"),
                    ),
                  ),
                );
              }
              if (state is ImagenError) {
                return Text(state.errorMsg);
              } else {
                return Text("");
              }
            },
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                BlocConsumer<TimeBloc, TimeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TimeSuccess) {
                      // print(state.successMsg['datetime']);
                      return Text(
                        state.successMsg['datetime'].substring(11, 19),
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      );
                    }
                    if (state is TimeError) {
                      return Text(
                        state.errorMsg,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      );
                    } else {
                      return Text('');
                    }
                  },
                ),
                BlocConsumer<FraseBloc, FraseState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is FraseSuccess) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 70),
                              Text(
                                state.successMsg['q'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "-" + state.successMsg['a'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      );
                    } else if (state is FraseError) {
                      return Text(state.errorMsg);
                    } else {
                      return Text("");
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



/* frontLayer: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(.7), BlendMode.srcOver),
              image: NetworkImage(
                  "https://i.pinimg.com/originals/2e/c6/b5/2ec6b5e14fe0cba0cb0aa5d2caeeccc6.jpg")),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              BlocConsumer<TimeBloc, TimeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is TimeSuccess) {
                    // print(state.successMsg['datetime']);
                    return Text(
                      state.successMsg['datetime'].substring(11, 19),
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    );
                  }
                  if (state is TimeError) {
                    return Text(
                      state.errorMsg,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
              BlocConsumer<FraseBloc, FraseState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FraseSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 70),
                            Text(
                              state.successMsg['q'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "-" + state.successMsg['a'],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    );
                  } else if (state is FraseError) {
                    return Text(state.errorMsg);
                  } else {
                    return Text("");
                  }
                },
              )
            ],
          ),
        ),
      ),
    
 */