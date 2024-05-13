import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try{
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xFile!=null){
      return File(xFile.path);
    }
    return null;
  }catch(e){
    return null; //This means that the user has not given the permission for accessing the gallery
  }
}