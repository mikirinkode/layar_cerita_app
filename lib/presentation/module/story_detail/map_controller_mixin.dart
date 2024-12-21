import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin MapControllerMixin {
  GoogleMapController? _googleMapController;

  // Indonesia Center
  LatLng defaultLatLng = const LatLng(3.1049765, 119.854142);

  final Set<Marker> markers = {};

  LatLng? _selectedLatlng;
  LatLng? get selectedLatlng => _selectedLatlng;

  triggerNotifyListener();

  void onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    debugPrint("onMapCreated");
  }

  void moveWithAnimation({required double lat, required double lng}) async {
    debugPrint("moveWithAnimation");

    await _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 16,
        ),
      ),
    );
  }

  void addMarker({required double lat, required double lng}) async {
    markers.clear();
    debugPrint("addMarker");
    final result = markers.add(
      Marker(
        markerId: const MarkerId("marker"),
        position: LatLng(
          lat,
          lng,
        ),
        onTap: () {
          moveWithAnimation(lat: lat, lng: lng);
        },
      ),
    );
    debugPrint("is add marker succes: $result");
    triggerNotifyListener();
  }

  void initStoryLocation({required double lat, required double lng}) async {
    addMarker(lat: lat, lng: lng);
    moveWithAnimation(lat: lat, lng: lng);
  }

  void onTapMap(LatLng latLng) async {
    _selectedLatlng = latLng;
    addMarker(lat: latLng.latitude, lng: latLng.longitude);
    moveWithAnimation(lat: latLng.latitude, lng: latLng.longitude);
  }
}
