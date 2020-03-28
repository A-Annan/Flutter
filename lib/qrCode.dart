import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

class qrCode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _qrCodeState();
}



class _qrCodeState extends State<qrCode> {

  String result;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Qr Code"),backgroundColor: Colors.blue,),
      body: Center(
        child: Text((result!=null)?result:'Scan QrCode',style: TextStyle(fontSize: 22),),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: scancode,
          label: Text('Scan QrCode'),
          icon: Icon(Icons.scanner),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Future scancode() async {

    try {
        String scan = await BarcodeScanner.scan();
        setState(() {
          result = scan;
        });
    } on PlatformException catch(e){
        if (e.code == BarcodeScanner.CameraAccessDenied){
          setState(() {
            result = 'Camera access denied';
          });
        }
    } on FormatException catch(e){
      setState(() {
        result = "rien n'est scanner";
      });
    }catch(e){
      setState(() {
        result = 'autre erreur';
      });
    }
  }
}