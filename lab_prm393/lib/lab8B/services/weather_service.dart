import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  final http.Client client;

  WeatherService({http.Client? client}) : client = client ?? http.Client();

  // Fetch weather for a city using coordinates
  Future<Weather> fetchWeather(String cityName, double latitude, double longitude) async {
    try {
      final response = await client
          .get(
        Uri.parse(
          '$baseUrl?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,weather_code',
        ),
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Weather.fromJson(jsonData, cityName);
      } else {
        throw Exception('Failed to load weather. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Common cities with coordinates (including Hanoi, Vietnam)
  static Map<String, Map<String, double>> getCities() {
    return {
      // Vietnam cities
      'Hanoi': {'lat': 21.0285, 'lon': 105.8542},
      'Ho Chi Minh City': {'lat': 10.8231, 'lon': 106.6297},
      'Da Nang': {'lat': 16.0544, 'lon': 108.2022},
      'Hai Phong': {'lat': 20.8449, 'lon': 106.6881},
      'Can Tho': {'lat': 10.0452, 'lon': 105.7469},
      'Nha Trang': {'lat': 12.2388, 'lon': 109.1967},
      'Da Lat': {'lat': 11.9465, 'lon': 108.4419},
      'Hue': {'lat': 16.4637, 'lon': 107.5909},

      // International cities
      'New York': {'lat': 40.7128, 'lon': -74.0060},
      'London': {'lat': 51.5074, 'lon': -0.1278},
      'Tokyo': {'lat': 35.6762, 'lon': 139.6503},
      'Paris': {'lat': 48.8566, 'lon': 2.3522},
      'Sydney': {'lat': -33.8688, 'lon': 151.2093},
      'Berlin': {'lat': 52.5200, 'lon': 13.4050},
      'Singapore': {'lat': 1.3521, 'lon': 103.8198},
      'Moscow': {'lat': 55.7558, 'lon': 37.6173},
      'Cairo': {'lat': 30.0444, 'lon': 31.2357},
      'Mumbai': {'lat': 19.0760, 'lon': 72.8777},
      'Beijing': {'lat': 39.9042, 'lon': 116.4074},
      'Los Angeles': {'lat': 34.0522, 'lon': -118.2437},
      'Chicago': {'lat': 41.8781, 'lon': -87.6298},
      'Toronto': {'lat': 43.6510, 'lon': -79.3470},
      'Mexico City': {'lat': 19.4326, 'lon': -99.1332},
      'São Paulo': {'lat': -23.5505, 'lon': -46.6333},
      'Lagos': {'lat': 6.5244, 'lon': 3.3792},
      'Delhi': {'lat': 28.7041, 'lon': 77.1025},
      'Jakarta': {'lat': -6.2088, 'lon': 106.8456},
      'Seoul': {'lat': 37.5665, 'lon': 126.9780},
    };
  }

  void dispose() {
    client.close();
  }
}