import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:ops_normal/widgets/dms_dd_toggle.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final Location location = Location();
  late final locationStream;
  dynamic heading = '-',
      longitude = '-',
      latitude = '-',
      speed = '-',
      altitude = '-';
  @override
  void initState() {
    getLocationInfo();
    locationStream = LazyStreamLocation().stream.listen((event) {
      updateLocationFromStream(event as LocationData);
    });

    super.initState();
    // locationStream.listen((currentLocation) {
    //   // Use current location
    // });
  }

  void updateLocationFromStream(currentLocation) async {
    if (mounted) {
      setState(() {
        heading = currentLocation.heading;
        longitude = currentLocation.latitude;
        latitude = currentLocation.longitude;
        altitude = currentLocation.altitude;
        speed = currentLocation.speed;
      });
      debugPrint(currentLocation.toString());
      // debugPrint("new location -updated");
    }
  }

  @override
  void dispose() {
    super.dispose();
    locationStream.cancel();
  }

  getLocationInfo() async {
    if (!mounted) {
      return;
    }
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // debugPrint("location is not enabled");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        debugPrint("please enable location");
      }
    }
  

    locationData = await location.getLocation();
    if (mounted) {
      setState(() {
        heading = locationData.heading;
        longitude = locationData.longitude;
        latitude = locationData.latitude;
        altitude = locationData.altitude;
        speed = locationData.speed;
      });
    }

    debugPrint("location is ${locationData.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          children: [
            DmsDdToggle(
                longitude: longitude.toString(),
                latitude: latitude.toString(),
                altitude: altitude.toString()),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () {
                  final coordinates = "<$longitude,$latitude>";
                  Clipboard.setData(ClipboardData(text: coordinates.toString()))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin:
                            EdgeInsets.only(bottom: 63, left: 10, right: 10),
                        padding: EdgeInsets.all(15),
                        elevation: 20,
                        content:
                            Text("<longitude,latitude> copied to clipboard")));
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.copy_all_outlined),
                  title: Text("Copy coordinates"),
                )),
            const Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 139, 109, 64))),
                onPressed: () {},
                child: ListTile(
                  title: const Text("Launch Avenza"),
                  onTap: () => launchAvanza(),
                ))
          ],
        ),
      ),
    );
  }
}

void launchAvanza() async {
  await LaunchApp.openApp(
      openStore: true,
      androidPackageName: "com.Avenza",
      iosUrlScheme: "avenza://",
      appStoreLink:
          "itms-apps://itunes.apple.com/us/app/avenza-maps-offline-mapping/id388424049");
}

class LazyStreamLocation {
  bool initial = true;
  Location location = Location();
  LazyStreamLocation() {
    _controler.onCancel = () => _controler.done;
    Timer.periodic(const Duration(seconds: 2), (t) async {
      if (!_controler.hasListener) {
        _controler.sink.done;
        _controler.close();
        return;
      }

      final LocationData data = await location.getLocation();
      _controler.sink.add(data);
      timer++;
    });
  }
  var timer = 1;
  final _controler = StreamController(onCancel: () {});
  void closeStream() {}

  Stream get stream => _controler.stream;
}

/// svg-icons
final Widget latitudeIcon = SvgPicture.string(
    ''' <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-world-latitude" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <circle cx="12" cy="12" r="9"></circle>
   <line x1="4.6" y1="7" x2="19.4" y2="7"></line>
   <line x1="3" y1="12" x2="21" y2="12"></line>
   <line x1="4.6" y1="17" x2="19.4" y2="17"></line>
</svg>''');

final Widget longitudeIcon = SvgPicture.string(
    '''<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-world-longitude" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <circle cx="12" cy="12" r="9"></circle>
   <path d="M11.5 3a11.2 11.2 0 0 0 0 18"></path>
   <path d="M12.5 3a11.2 11.2 0 0 1 0 18"></path>
   <line x1="12" y1="3" x2="12" y2="21"></line>
</svg>''');

final Widget speedIcon = SvgPicture.string(
    ''' <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-gauge" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <circle cx="12" cy="12" r="9"></circle>
   <circle cx="12" cy="12" r="1"></circle>
   <line x1="13.41" y1="10.59" x2="16" y2="8"></line>
   <path d="M7 12a5 5 0 0 1 5 -5"></path>
</svg>''');

final Widget altitudeIcon = SvgPicture.string(
    '''<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-mountain" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <path d="M3 20h18l-6.921 -14.612a2.3 2.3 0 0 0 -4.158 0l-6.921 14.612z"></path>
   <path d="M7.5 11l2 2.5l2.5 -2.5l2 3l2.5 -2"></path>
</svg>''');
