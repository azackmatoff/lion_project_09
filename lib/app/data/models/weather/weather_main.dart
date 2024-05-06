class WeatherMain {
  final double temp;
  final int pressure;
  final int humidity;
  final double tempMin;
  final double tempMax;

  WeatherMain({
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherMain.fromMap(Map<String, dynamic> json) => WeatherMain(
        temp: json["temp"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "pressure": pressure,
        "humidity": humidity,
        "temp_min": tempMin,
        "temp_max": tempMax,
      };
}
