import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lion_project_09/city_view.dart';
import 'package:lion_project_09/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  /// Null safety,
  /// non nullable
  /// String temperature = '';
  /// String description = '';
  /// nullable
  String? temperature;
  String? description;

  @override
  void initState() {
    getWeatherByLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: temperature == null && description == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.near_me,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return CityView();
                              },
                            ));
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${temperature!}°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            '☀️',
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        description!,
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> getWeatherByLocation() async {
    Position position = await _determinePosition();

    http.Client client = http.Client();

    /// https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    String url = '$apiUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';

    Uri uri = Uri.parse(url);

    http.Response response = await client.get(uri);

    log('response: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);

      temperature = (result['main']['temp']).toString();

      description = result['weather'][0]['description'];

      setState(() {});
    }

    ///
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final result = await Geolocator.getCurrentPosition();

    log('result: ${result.latitude} and ${result.longitude}');

    return result;
  }
}