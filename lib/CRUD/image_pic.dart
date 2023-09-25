import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

Future GetImage()async{
  File?file;
  final picker=ImagePicker();
    final pickfile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 70);
    if(pickfile!=null){
      file=File(pickfile.path);
    }else{
      debugPrint("No Image Selected");
    }
}