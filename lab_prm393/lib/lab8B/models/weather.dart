class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String weatherCode;
  final String weatherDescription;
  final String weatherIcon;
  final DateTime time;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.time,
  });

  factory Weather.fromJson(Map<String, dynamic> json, String cityName) {
    final current = json['current'];
    final currentUnits = json['current_units'];

    return Weather(
      cityName: cityName,
      temperature: current['temperature_2m'].toDouble(),
      feelsLike: current['apparent_temperature'].toDouble(),
      humidity: current['relative_humidity_2m'].toInt(),
      windSpeed: current['wind_speed_10m'].toDouble(),
      weatherCode: current['weather_code'].toString(),
      weatherDescription: _getWeatherDescription(current['weather_code']),
      weatherIcon: _getWeatherIcon(current['weather_code']),
      time: DateTime.parse(current['time']),
    );
  }

  static String _getWeatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Partly cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 56:
      case 57:
        return 'Freezing drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 66:
      case 67:
        return 'Freezing rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 77:
        return 'Snow grains';
      case 80:
      case 81:
      case 82:
        return 'Rain showers';
      case 85:
      case 86:
        return 'Snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with hail';
      default:
        return 'Unknown';
    }
  }

  static String _getWeatherIcon(int code) {
    if (code == 0) return '☀️';
    if (code >= 1 && code <= 3) return '⛅';
    if (code >= 45 && code <= 48) return '🌫️';
    if (code >= 51 && code <= 57) return '🌧️';
    if (code >= 61 && code <= 67) return '🌧️';
    if (code >= 71 && code <= 77) return '❄️';
    if (code >= 80 && code <= 82) return '🌧️';
    if (code >= 85 && code <= 86) return '❄️';
    if (code >= 95 && code <= 99) return '⛈️';
    return '🌡️';
  }

  // Helper methods for recommendations
  bool get needsUmbrella {
    return weatherDescription.contains('Rain') ||
        weatherDescription.contains('Drizzle') ||
        weatherDescription.contains('Showers');
  }

  bool get needsJacket {
    return temperature < 15;
  }

  bool get needsWarmClothes {
    return temperature < 10;
  }

  bool get isGoodForOutdoor {
    return !needsUmbrella && temperature > 10 && temperature < 30 && windSpeed < 15;
  }

  String get activityRecommendation {
    if (isGoodForOutdoor) {
      if (temperature > 25) {
        return '🏃 Great day for outdoor sports! Stay hydrated.';
      } else if (temperature > 15) {
        return '🚶 Perfect for a walk in the park!';
      } else {
        return '🏔️ Good for hiking, but dress warmly!';
      }
    } else if (needsUmbrella) {
      return '☔ Best to stay indoors. Great day for movies or reading!';
    } else if (temperature > 30) {
      return '🥵 Too hot for outdoor activities. Stay cool indoors!';
    } else if (temperature < 0) {
      return '🥶 Very cold! Perfect for hot chocolate and cozy activities.';
    } else {
      return '🏠 Consider indoor activities today.';
    }
  }

  String get clothingRecommendation {
    List<String> recommendations = [];

    if (temperature > 30) {
      recommendations.add('Light clothing, shorts, t-shirt');
      recommendations.add('Wear sunscreen and a hat');
    } else if (temperature > 20) {
      recommendations.add('T-shirt and light pants');
    } else if (temperature > 10) {
      recommendations.add('Light jacket or sweater');
      if (needsUmbrella) recommendations.add('Don\'t forget your umbrella!');
    } else if (temperature > 0) {
      recommendations.add('Warm jacket, scarf');
      recommendations.add('Wear layers');
      if (needsUmbrella) recommendations.add('Waterproof jacket recommended');
    } else {
      recommendations.add('Heavy winter coat');
      recommendations.add('Gloves, scarf, and warm hat');
      recommendations.add('Stay warm!');
    }

    if (windSpeed > 15) {
      recommendations.add('Windy! Bring a windbreaker');
    }

    return recommendations.join('\n');
  }
}