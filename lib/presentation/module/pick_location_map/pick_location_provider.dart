import 'package:flutter/cupertino.dart';
import 'package:layar_cerita_app/presentation/module/story_detail/map_controller_mixin.dart';

class PickLocationProvider extends ChangeNotifier with MapControllerMixin {
  
  @override
  triggerNotifyListener() {
    notifyListeners();
  }
}
