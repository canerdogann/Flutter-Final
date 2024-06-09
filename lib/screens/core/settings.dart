import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String camResult = "";
  String locationResult = "";
  String locationAllwaysResult = "";
  String locationInfo = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    controlPermission();
  }

  controlPermission() async {
    var status = await Permission.camera.status;

    switch (status) {
      case (PermissionStatus.granted):
        setState(() {
          camResult = "Yetki Alınmış.";
        });
        break;
      case (PermissionStatus.denied):
        setState(() {
          camResult = "Yetki Rededilmiş.";
        });
        break;
      case PermissionStatus.restricted:
        setState(() {
          camResult = "Kısıtlanmış Yetki, hiç türlü alamayız.";
        });
        break;
      case PermissionStatus.limited:
        setState(() {
          camResult = "Kısıtlanmış Yetki, Kullanıcı kısıtlı yetki seçmiş.";
        });
        break;
      case PermissionStatus.permanentlyDenied:
        setState(() {
          camResult = "Kullanıcı, Yetki Vermesini Engelledi";
        });
        break;
      case PermissionStatus.provisional:
        setState(() {
          camResult = "Geçici Yetki";
        });
        break;
    }

    await Permission.locationAlways.request().then((value) {
      if (value.isGranted) {
        setState(() {
          locationResult = "Yetki Verildi";
        });

        Permission.camera.request().then((value) {
          setState(() {
            locationAllwaysResult =
                "HER ZAMAN KONUM ERİŞİMİ " + value.toString();
          });
        });
      } else {
        setState(() {
          locationResult = "Yetki Reddedildi";
        });
      }
    });
  }

  getLocation() async {
    setState(() {
      loading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationInfo = "Konum Hizmetleri Ayarlardan Kapalı";
      });

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationInfo = "Kullanıcı, Yetki Vermeyi İnat Etti";
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationInfo = "Kullanıcı, Bilgi Vermek İstemiyor, Tamamen Kapalı";
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final pos = await Geolocator.getCurrentPosition();

    setState(() {
      locationInfo = '''
        Accuracy: ${pos.accuracy}
        Longitude: ${pos.longitude}
        Latitude: ${pos.latitude}
        Speed: ${pos.speed}
        Speed Accuracy: ${pos.speedAccuracy}
        Data Time: ${pos.timestamp}
        ''';
    });

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 40, 70),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox.expand(
        child: ListView(
          children: [
            _buildExpansionTile(
              title: "Camera Permission",
              result: camResult,
              onPressed: () async {
                final status = await Permission.camera.request();
                print(status);
              },
            ),
            _buildExpansionTile(
              title: "Location Permission",
              result: locationResult,
              subtitle: "Allways Status: $locationAllwaysResult",
            ),
            _buildExpansionTile(
              title: "Location Info",
              onPressed: getLocation,
              icon: Icons.location_on,
              result: locationInfo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required String result,
    VoidCallback? onPressed,
    IconData? icon,
    String? subtitle,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Title text color
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result,
                style: TextStyle(
                  color: Colors.green, // Result text color
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey, // Subtitle text color
                  ),
                ),
              ],
              if (onPressed != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text("Yetki İste"),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
