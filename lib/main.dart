import 'package:flutter/material.dart';

enum Season { winter, spring, summer, autumn }

extension SeasonAssets on Season {
  static const _assetPaths = {
    Season.winter: '../assets/Winter.png',
    Season.spring: '../assets/Spring.png',
    Season.summer: '../assets/Summer.png',
    Season.autumn: '../assets/fall.png',
  };

  static const _displayNames = {
    Season.winter: 'Winter',
    Season.spring: 'Spring',
    Season.summer: 'Summer',
    Season.autumn: 'Autumn',
  };

  Season get next => Season.values[(index + 1) % Season.values.length];
  String get assetPath => _assetPaths[this]!;
  String get displayName => _displayNames[this]!;
}

final ValueNotifier<Season> _franceSeason = ValueNotifier(Season.winter);
final ValueNotifier<Season> _cambodiaSeason = ValueNotifier(Season.summer);

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SeasonsScreen(),
    );
  }
}

class SeasonsScreen extends StatelessWidget {
  const SeasonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: const Text('Weather Challenge'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tap on a card to change the season',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(height: 24),
              Card(
                color: Colors.yellow[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SEASON',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SeasonCard(
                            country: 'FRANCE',
                            notifier: _franceSeason,
                          ),
                          const SizedBox(width: 24),
                          SeasonCard(
                            country: 'CAMBODIA',
                            notifier: _cambodiaSeason,
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
    );
  }
}

class SeasonCard extends StatelessWidget {
  const SeasonCard({required this.country, required this.notifier, super.key});

  final String country;
  final ValueNotifier<Season> notifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Season>(
      valueListenable: notifier,
      builder: (context, season, _) {
        return GestureDetector(
          onTap: () => notifier.value = season.next,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: 380,
              height: 460,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.asset(season.assetPath, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        Text(
                          country,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          season.displayName,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
