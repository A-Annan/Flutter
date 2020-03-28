
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';


class camera extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _cameraState();
}

class _cameraState extends State<camera> {

  File imageFile;
  VisionText visionTextOCR;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.amber),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: (){
                      openDialog(context);
                    },
                    child: Text('Pick Image',style: TextStyle(color: Colors.white,fontSize: 22),),
                  ),

                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Text('${(visionTextOCR==null)?'':visionTextOCR.text}'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange,width: 1),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (imageFile!=null)?FileImage(imageFile):AssetImage('images/clear.png')
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }


  Future<VisionText> textRecgnition( File imageFile){
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final Future <VisionText> visionText = textRecognizer.processImage(visionImage);

    return visionText;
  }
  Future<void> openDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return CupertinoAlertDialog(
        title: Text('title'),
        content: Text('Contenu'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Gallery'),
            onPressed: () async {
                Navigator.pop(context);
                var file = await ImagePicker.pickImage(source: ImageSource.gallery);
                File croped_image = await ImageCropper.cropImage(sourcePath: file.path);
                VisionText visionText = await textRecgnition(croped_image);
                setState(() {
                  imageFile = file;
                  visionTextOCR = visionText;
                });

            },
          ),
          CupertinoDialogAction(
              child: Text('Camera'),
              onPressed: () async {
                Navigator.pop(context);
                var file = await ImagePicker.pickImage(source: ImageSource.camera);
                File cropped_image = await ImageCropper.cropImage(sourcePath: file.path);
                VisionText visionText = await textRecgnition(cropped_image);
                setState(() {
                  imageFile = file;
                  visionTextOCR = visionText;
                });


            },
          ),
        ],
      );
    });
  }
}
