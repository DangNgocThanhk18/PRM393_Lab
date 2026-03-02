import 'package:flutter/material.dart';

class Exercise4Page extends StatefulWidget {
  const Exercise4Page({super.key});

  @override
  State<Exercise4Page> createState() => _Exercise4PageState();
}

class _Exercise4PageState extends State<Exercise4Page> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Exercise 4 – App Structure with Theme Toggle"),
          backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.grey,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
              tooltip: 'Toggle Theme',
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Theme icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.amber[700] : Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    size: 60,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  _isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  'This is a simple screen with theme toggle.',
                  style: TextStyle(
                    fontSize: 16,
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Toggle button
                ElevatedButton.icon(
                  onPressed: _toggleTheme,
                  icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  label: Text(
                    _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDarkMode ? Colors.amber : Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Info card
                Card(
                  elevation: 4,
                  color: _isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.info,
                            color: _isDarkMode ? Colors.amber : Colors.blue,
                          ),
                          title: Text(
                            'Theme Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            _isDarkMode
                                ? 'Dark theme is active. Better for low-light environments.'
                                : 'Light theme is active. Better for bright environments.',
                            style: TextStyle(
                              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildThemeFeature(
                              icon: Icons.remove_red_eye,
                              label: 'Eye Comfort',
                              isDarkMode: _isDarkMode,
                            ),
                            _buildThemeFeature(
                              icon: Icons.battery_saver,
                              label: 'Battery Saver',
                              isDarkMode: _isDarkMode,
                            ),
                            _buildThemeFeature(
                              icon: Icons.contrast,
                              label: 'High Contrast',
                              isDarkMode: _isDarkMode,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeFeature({
    required IconData icon,
    required String label,
    required bool isDarkMode,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isDarkMode ? Colors.amber : Colors.blue,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}