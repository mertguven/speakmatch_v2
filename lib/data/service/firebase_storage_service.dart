import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:speakmatch_v2/shared-prefs.dart';

class FirebaseStorageService {
  /*firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;*/

  Future<String> uploadImage(Uint8List photo) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref("${SharedPrefs.getUid}/profile_photo.png");
      await ref.putData(photo);
      return await ref.getDownloadURL();
      /*firebase_storage.UploadTask uploadTask = _storage.ref().putData(photo);
      var url = await uploadTask.snapshot.ref.getDownloadURL();*/
    } on firebase_storage.FirebaseException catch (e) {
      print("firebase storage error: " + e.toString());
      return null;
    }
  }
}
