import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:layar_cerita_app/presentation/module/pick_location_map/pick_location_provider.dart';
import 'package:provider/provider.dart';

class PickLocationPage extends StatelessWidget {
  const PickLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PickLocationProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Pilih Lokasi"),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: provider.defaultLatLng,
          ),
          onMapCreated: (controller) {
            provider.onMapCreated(controller);
          },
        ),
        bottomNavigationBar: Container(
          child: FilledButton(
            onPressed: provider.selectedLatlng == null ? null : () {},
            child: Text("Konfirmasi Lokasi"),
          ),
        ),
      );
    });
  }
}
