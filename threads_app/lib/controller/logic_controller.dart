import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LogicController extends GetxController {
  XFile? _imageFile;

  Future<void> pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      _imageFile = pickedFile;
      update();
    }
  }

  XFile? get imageFile => _imageFile;
}

