import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../global.dart';

class ImagenesUsuarios extends StatefulWidget{
  @override
  ImagenUsuario createState() {
    // TODO: implement createState
    return ImagenUsuario();
  }

}
class ImagenUsuario extends State<ImagenesUsuarios>{
  static File galleryFile;
  static Future<File> imageFile;

  @override
  void initState() {
    imageFile = null; //toda la informacion sera eliminada al entrar para poder asignar otras imágenes.
    super.initState(); //Invocar metodo
  }

  pickImageFromGallery(ImageSource source){
    setState(() async  {

      // ignore: deprecated_member_use
      imageFile = ImagePicker.pickImage(source: source);

    });
  }
  Widget mostrarImagen() {
    if(imageFile == null){
      if(Global.doc != null){
        setState(() {});
        return Image.network(Global.doc.image);
      }else{
        return image();
      }
    }else{
      return image();
    }
  }


    FutureBuilder<File>image(){
      return FutureBuilder<File>(
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null){
          galleryFile = snapshot.data;
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );

        }else if (snapshot.error != null){
          return const Text(
            'Error al seleccionar la imagen',
            textAlign: TextAlign.center,
          );
        }else {
          return new Image.asset("assets/images/t_800.jpg");
        }
      }
      );
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 5.0,
      borderRadius: new BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () =>pickImageFromGallery(ImageSource.gallery) ,
        child: Container(
          height: 200,
          width: 200,
          child: mostrarImagen(),
        ),
      ),
    );
  }

}

