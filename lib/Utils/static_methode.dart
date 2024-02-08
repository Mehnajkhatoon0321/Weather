import 'package:flutter/material.dart';

class NWidgets {




  static noNetwork(context) => Center(
    child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset('assets/images/noInternet.png', height: 65.0, width: 65.0),
              const SizedBox(height: 5.0),
              Text("No Internet connection",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        )),
  );}