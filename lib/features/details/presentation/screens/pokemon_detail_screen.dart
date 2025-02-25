import 'package:flutter/material.dart';
import 'package:pokemon/features/details/presentation/widgets/detail_card_widget.dart';
import 'package:pokemon/widgets/custom_appBar_widget.dart';
import 'package:pokemon/services/api_service.dart';
import 'package:pokemon/models/pokemon_detail.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String pokemonId;

  const PokemonDetailScreen({Key? key, required this.pokemonId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: CustomAppBar(text: 'Pokemon Detail'),
      body: FutureBuilder<PokemonDetail>(
        future: ApiService().fetchPokemonDetails(pokemonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No data found.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          final data = snapshot.data!;
          final name = data.name;
          final imageUrl = data.imageUrl;
          final types = data.abilities.map((e) => e.name).join(', ');
          final baseExperience = data.baseExperience;
          final stats = data.stats
              .map((stat) => "${stat.name.capitalize()}: ${stat.baseStat}")
              .join("\n");

          return Stack(
            children: [
              // Background Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              imageUrl,
                              width: 180,
                              height: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                      'assets/images/placeholder.png'),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Pokémon Name
                    Text(
                      name.capitalize(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Pokémon Type
                    Text(
                      types,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Pokémon Stats & Details
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            DetailCard(
                              title: "Base Experience",
                              value: "$baseExperience",
                            ),
                            DetailCard(
                              title: "Stats",
                              value: stats,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
