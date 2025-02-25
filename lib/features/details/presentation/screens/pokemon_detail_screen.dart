import 'package:flutter/material.dart';
import 'package:pokemon/features/details/presentation/widgets/detail_card_widget.dart';
import 'package:pokemon/widgets/custom_appBar_widget.dart';
import 'package:pokemon/services/api_service.dart';
import 'package:pokemon/models/pokemon_detail.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/text_theme.dart';
import '../../../../helper/responsive_helper.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String pokemonId;

  const PokemonDetailScreen({Key? key, required this.pokemonId})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: AppColors.colorBlue,
      appBar: CustomAppBar(text: 'Pokemon Detail',
     
      ),
      body: FutureBuilder<PokemonDetail>(
        future: ApiService().fetchPokemonDetails(pokemonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingIndicator(responsive);
          }

          if (snapshot.hasError) {
            return _buildErrorMessage(snapshot.error.toString(), responsive);
          }

          if (!snapshot.hasData) {
            return _buildEmptyMessage(responsive);
          }

          final data = snapshot.data!;
          return _buildDetailContent(context, data, responsive);
        },
      ),
    );
  }

  // Loading Indicator
  Widget _buildLoadingIndicator(ResponsiveHelper responsive) {
    return Center(
      child: SizedBox(
        height: responsive.height(0.06),
        width: responsive.height(0.06),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  // Error Message Display
  Widget _buildErrorMessage(String error, ResponsiveHelper responsive) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(responsive.width(0.05)),
        child: Text(
          'Error: $error',
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.width(0.045),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// No Data Found Message
  Widget _buildEmptyMessage(ResponsiveHelper responsive) {
    return Center(
      child: Text(
        'No data found.',
        style: TextStyle(
          color: Colors.white,
          fontSize: responsive.width(0.045),
        ),
      ),
    );
  }

  // Content for Pokémon Details
  Widget _buildDetailContent(
    BuildContext context,
    PokemonDetail data,
    ResponsiveHelper responsive,
  ) {
    final name = data.name.capitalize();
    final imageUrl = data.imageUrl;
    final types = data.abilities.map((e) => e.name).join(', ');
    final baseExperience = data.baseExperience.toString();
    final stats = data.stats
        .map((stat) => "${stat.name.capitalize()}: ${stat.baseStat}")
        .join("\n");

    return Stack(
      children: [
        _buildBackgroundGradient(),

        SafeArea(
          child: Column(
            children: [
              _buildPokemonImage(imageUrl, responsive),
              SizedBox(height: responsive.height(0.02)),
              _buildPokemonInfo(name, types, responsive),
              SizedBox(height: responsive.height(0.03)),
              _buildStatsSection(baseExperience, stats, responsive),
            ],
          ),
        ),
      ],
    );
  }

  /// Background Gradient
  Widget _buildBackgroundGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.colorBlue, Colors.lightBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  /// Pokémon Image with Shadow
  Widget _buildPokemonImage(String imageUrl, ResponsiveHelper responsive) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: responsive.height(0.02)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: responsive.width(0.05),
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: responsive.width(0.25),
          backgroundColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(responsive.width(0.25)),
            child: Image.network(
              imageUrl,
              width: responsive.width(0.35),
              height: responsive.width(0.35),
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Image.asset(
                    'assets/images/placeholder.png',
                    width: responsive.width(0.35),
                    height: responsive.width(0.35),
                    fit: BoxFit.cover,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  /// Pokémon Name & Type
  Widget _buildPokemonInfo(
    String name,
    String types,
    ResponsiveHelper responsive,
  ) {
    return Column(
      children: [
        Text(
          name,
          style: TextThemes.nameTitle.copyWith(
            fontSize: responsive.width(0.055),
          ),
        ),
        SizedBox(height: responsive.height(0.005)),
        Text(
          types,
          style: TextThemes.subTitle.copyWith(fontSize: responsive.width(0.04)),
        ),
      ],
    );
  }

  /// Pokémon Stats & Details Section
  Widget _buildStatsSection(
    String baseExperience,
    String stats,
    ResponsiveHelper responsive,
  ) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(responsive.width(0.05)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(responsive.width(0.08)),
            topRight: Radius.circular(responsive.width(0.08)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: responsive.width(0.05),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: responsive.height(0.02)),
            DetailCard(title: "Base Experience", value: baseExperience),
            DetailCard(title: "Stats", value: stats),
          ],
        ),
      ),
    );
  }
}

// Capitalizing String
extension StringCasingExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
