import 'package:geolocator/geolocator.dart';
import 'package:lion_project_09/app/data/models/weather/weather_model.dart';
import 'package:lion_project_09/common/contants/texts/app_texts.dart';
import 'package:lion_project_09/core/services/http_services/http_services.dart';

class ApiSources {
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    String url = '${AppTexts.apiUrl}?q=$cityName&appid=${AppTexts.apiKey}&units=metric';

    final response = await HttpServices.get(url);

    return WeatherModel.fromMap(response);
  }

  Future<WeatherModel> getWeatherByLocation(Position position) async {
    String url =
        '${AppTexts.apiUrl}?lat=${position.latitude}&lon=${position.longitude}&appid=${AppTexts.apiKey}&units=metric';

    final response = await HttpServices.get(url);
    return WeatherModel.fromMap(response);
  }
}
