import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layar_cerita_app/presentation/module/story_detail/map_controller_mixin.dart';

class PickLocationProvider extends ChangeNotifier with MapControllerMixin {
  LatLng? _selectedLatlng;
  LatLng? get selectedLatlng => _selectedLatlng;
  
  @override
  triggerNotifyListener() {
    notifyListeners();
  }
}
