

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layar_cerita_app/presentation/module/pick_location_map/pick_location_provider.dart';
import 'package:layar_cerita_app/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../route/page_manager.dart';
import '../../route/route_argument.dart';
import '../../theme/app_button_style.dart';

class PickLocationPage extends StatelessWidget {
  final Function() onNavigateBack;

  const PickLocationPage({super.key, required this.onNavigateBack});

  @override
  Widget build(BuildContext context) {
    return Consumer<PickLocationProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Pilih Lokasi"),
        ),
        body: GoogleMap(
          markers: provider.markers,
          initialCameraPosition: CameraPosition(
            target: provider.defaultLatLng,
          ),
          onMapCreated: (controller) {
            provider.onMapCreated(controller);
          },
          onTap: (latLng) {
            provider.onTapMap(latLng);
          },
        ),
        bottomNavigationBar: Container(
          padding: UIUtils.paddingAll(16),
          child: FilledButton(
            onPressed: provider.selectedLatlng == null
                ? null
                : () {
                    context.read<PageManager>().returnData(
                          AddStoryArgs.resultFromPickLocation,
                      {
                        AddStoryArgs.lat: provider.selectedLatlng!.latitude,
                        AddStoryArgs.lng: provider.selectedLatlng!.longitude,
                      },
                    );
                    onNavigateBack.call();
                  },
            style: AppButtonStyle.filledPrimary,
            child: const Text("Konfirmasi Lokasi"),
          ),
        ),
      );
    });
  }
}
