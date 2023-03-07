import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cronometro extends StatefulWidget {
  const Cronometro({super.key});

  @override
  State<Cronometro> createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {
  int milisegundos = 0;
  bool estaCorriendo = false;
  late Timer timer;
  List vueltas = [];
  

  void iniciarCronometro() {
    if (!estaCorriendo) {
      timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        this.milisegundos += 10;
        setState(() {});
      });
      estaCorriendo = true;
    }
  }

  void detenerCronometro() {
    timer.cancel();
    estaCorriendo = false;
  }

  String formatearTiempo(Duration duracion) {
    

    String dosValores(int valor) {
      return valor >= 10 ? "$valor" : "0$valor";
    }

    String tresValores(int valor) {
      return valor >= 10 ? "$valor" : "0$valor";
    }

    String horas = dosValores(duracion.inHours);
    String minutos = dosValores(duracion.inMinutes.remainder(60));
    String segundos = dosValores(duracion.inSeconds.remainder(60));
    String milisegundos = dosValores(duracion.inMilliseconds.remainder(1000));

    String borrar = milisegundos.substring(0, 2);

    return ("$horas:$minutos:$segundos:$borrar");
  }
  Duration get duracion => Duration(milliseconds: milisegundos);



  @override
  void dispose() {
    print('eliminando el callback');
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formatearTiempo(duracion),
          style: const TextStyle(fontSize: 60, color: Colors.red),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoButton(
                child: Icon(
                  Icons.not_started,
                  color: Colors.red,
                  size: 45,
                ),
                onPressed: iniciarCronometro),
            CupertinoButton(
                child: Icon(
                  Icons.stop,
                  color: Colors.red,
                  size: 50,
                ),
                onPressed: detenerCronometro),
                CupertinoButton(
              child: Icon(
                Icons.restart_alt_sharp,
                color: Colors.red,
                size: 50,
              ),
              onPressed: () {
                this.milisegundos = 0;
                setState(() {});
                vueltas = [];
              }),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          CupertinoButton(
                onPressed: estaCorriendo ? () {vueltas.add(duracion);} : null,
              child: Icon(
                Icons.flag_rounded,
                color: Colors.red,
                size: 50,
              ),
              ),
        ]),
        Container(
          
          height: 400,
          decoration: BoxDecoration(
              
              color: Colors.amber[300],
              borderRadius: BorderRadius.circular(40)), 
          child: ListView.builder(
            itemCount: vueltas.length,
            itemBuilder: (context, index) {
              final diff = index == 0 ? vueltas[index] : vueltas[index] - vueltas[index - 1];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lap n° ${index + 1}',
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                    Text(
                      '+${formatearTiempo(diff)}',
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                    Text(
                      formatearTiempo(vueltas[index]),
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Text(
          'McDonals StopWhatch',
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
      ],
    );
  }
}
