import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_display.dart';
import 'city_search_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = true;
  String? _error;
  String _currentCity = 'Hanoi';  // ← Đổi thành Hà Nội

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final cities = WeatherService.getCities();
      final cityData = cities[_currentCity];

      if (cityData != null) {
        final weather = await _weatherService.fetchWeather(
          _currentCity,
          cityData['lat']!,
          cityData['lon']!,
        );
        setState(() {
          _weather = weather;
          _isLoading = false;
        });
      } else {
        throw Exception('City not found');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _changeCity(String cityName) async {
    setState(() {
      _currentCity = cityName;
    });
    await _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Companion - Việt Nam'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final selectedCity = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => const CitySearchScreen(),
                ),
              );
              if (selectedCity != null && selectedCity != _currentCity) {
                await _changeCity(selectedCity);
              }
            },
            tooltip: 'Change City',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchWeather,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchWeather,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return LoadingWidget(message: 'Getting weather info for $_currentCity...');
    }

    if (_error != null) {
      return ErrorDisplay(
        error: _error!,
        onRetry: _fetchWeather,
      );
    }

    if (_weather == null) {
      return const Center(
        child: Text('No weather data available'),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        WeatherCard(weather: _weather!),
        const SizedBox(height: 20),
        RecommendationCard(weather: _weather!),
      ],
    );
  }

  @override
  void dispose() {
    _weatherService.dispose();
    super.dispose();
  }
}