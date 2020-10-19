

import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> saveImageFileLocally({Uint8List bytes,String filename}) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    File file = new File(join(directory.path,filename));
    await file.writeAsBytes(bytes);
    //File _savedFile = print("saved file $_savedFile");
    return true;
  } catch (e) {
    return false;
  }
}

Future<Uint8List> readImageFileLocally({String filename}) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    File filePath = new File(join(directory.path,filename));
    final file = await filePath.readAsBytes();
    return file;
  } catch (e) {
    print("ERROR----- $e");
    return null;
  }
} 

Future<LocalFileModel> loadLocalfiles({flag,photo}) async {
   LocalFileModel files = LocalFileModel();
   
  files.flag = flag !='empty'? await readImageFileLocally(filename: flag):null; //cascade operator
  files.photo = photo !='empty'? await readImageFileLocally(filename: photo):null;
  return files;
}

class LocalFileModel {
  dynamic flag;
  dynamic photo;
  LocalFileModel({this.flag,this.photo});

  @override
  String toString() {
    return 'LocalFileModel(flag: $flag, photo : $photo)';
  }
}

