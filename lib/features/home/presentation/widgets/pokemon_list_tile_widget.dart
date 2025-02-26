import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/image_path.dart';
import '../../../../constants/text_theme.dart';
import '../../../../helper/responsive_helper.dart';

class PokemonListTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> types;
  final VoidCallback? onTap;

  const PokemonListTile({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.types,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: responsive.height(0.01),
        horizontal: responsive.width(0.04),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.width(0.03)),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(responsive.width(0.04)),
        leading: _buildPokemonImage(responsive),
        title: _buildPokemonName(responsive),
        subtitle: _buildPokemonTypes(responsive),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  // Pokémon image with error handling.
  Widget _buildPokemonImage(ResponsiveHelper responsive) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(responsive.width(0.02)),
      child: Image.network(
        imageUrl,
        width: responsive.width(0.15),
        height: responsive.width(0.15),
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Image.asset(
              ImagePaths.pokemon,
              width: responsive.width(0.15),
              height: responsive.width(0.15),
              fit: BoxFit.cover,
            ),
      ),
    );
  }

  // Pokémon name text
  Widget _buildPokemonName(ResponsiveHelper responsive) {
    return Text(
      name,
      style: TextThemes.textTitle.copyWith(
        fontSize: responsive.width(0.045),
        color: AppColors.black,
      ),
    );
  }

  // Pokémon types text
  Widget _buildPokemonTypes(ResponsiveHelper responsive) {
    return Text(
      'Types: ${types.join(', ')}',
      style: TextThemes.text.copyWith(fontSize: responsive.width(0.035)),
    );
  }
}
