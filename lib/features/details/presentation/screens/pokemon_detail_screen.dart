import 'package:flutter/material.dart';
import 'package:pokemon/features/details/presentation/widgets/detail_card_widget.dart' show DetailCard;
import 'package:pokemon/widgets/custom_appBar_widget.dart';

class PokemonDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Static Pokémon data
    final String name = "Pikachu";
    final String imageUrl =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png";
    final List<String> types = ["Electric"];
    final int baseExperience = 112;
    final Map<String, int> stats = {
      "HP": 35,
      "Attack": 55,
      "Defense": 40,
      "Speed": 90,
    };

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: CustomAppBar(text: 
        'Pokemon Detail',
      ),
      body: Stack(
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
                // Pokémon Image with a Floating Effect
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
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  Image.asset('assets/images/placeholder.png'),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Pokémon Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 5),

                // Pokémon Type
                Text(
                  types.join(', '),
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
                          value: stats.entries
                              .map((e) => "${e.key}: ${e.value}")
                              .join("\n"),
                        ),

                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
