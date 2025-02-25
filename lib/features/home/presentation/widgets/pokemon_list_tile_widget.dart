import 'package:flutter/material.dart';

class PokemonListTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> types;

  const PokemonListTile({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/placeholder.png',
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Types: ${types.join(', ')}',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).pushNamed('/pokemonDetail');
        },
      ),
    );
  }
}