import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final Map<String, Map<String, double>> _cities = WeatherService.getCities();
  List<String> _filteredCities = [];

  // Tách riêng các thành phố Việt Nam
  List<String> get _vietnameseCities {
    return _cities.keys.where((city) =>
    city == 'Hanoi' ||
        city == 'Ho Chi Minh City' ||
        city == 'Da Nang' ||
        city == 'Hai Phong' ||
        city == 'Can Tho' ||
        city == 'Nha Trang' ||
        city == 'Da Lat' ||
        city == 'Hue'
    ).toList();
  }

  List<String> get _internationalCities {
    return _cities.keys.where((city) =>
    city != 'Hanoi' &&
        city != 'Ho Chi Minh City' &&
        city != 'Da Nang' &&
        city != 'Hai Phong' &&
        city != 'Can Tho' &&
        city != 'Nha Trang' &&
        city != 'Da Lat' &&
        city != 'Hue'
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    _filteredCities = _cities.keys.toList();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filteredCities = _cities.keys
          .where((city) => city.toLowerCase().contains(_searchQuery))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn Thành Phố'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm thành phố...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _searchQuery.isEmpty
                ? _buildCityListWithSections()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildCityListWithSections() {
    return ListView(
      children: [
        // Vietnamese cities section
        if (_vietnameseCities.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '🇻🇳 Thành phố Việt Nam',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              ..._vietnameseCities.map((city) => _buildCityTile(city)),
              const Divider(),
            ],
          ),

        // International cities section
        if (_internationalCities.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '🌍 Thành phố quốc tế',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ..._internationalCities.map((city) => _buildCityTile(city)),
            ],
          ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_filteredCities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Không tìm thấy thành phố',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Thử tìm kiếm với tên khác',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredCities.length,
      itemBuilder: (context, index) {
        final city = _filteredCities[index];
        return _buildCityTile(city);
      },
    );
  }

  Widget _buildCityTile(String city) {
    // Kiểm tra xem có phải thành phố Việt Nam không
    final isVietnamese = _vietnameseCities.contains(city);

    return ListTile(
      leading: Icon(
        isVietnamese ? Icons.flag : Icons.location_city,
        color: isVietnamese ? Colors.red : null,
      ),
      title: Text(
        city,
        style: TextStyle(
          fontWeight: isVietnamese ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context, city);
      },
    );
  }
}