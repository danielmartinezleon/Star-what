import 'package:flutter/material.dart';
import 'package:listaprofesional/models/people_response/people.dart';

class PeopleDetailScreen extends StatelessWidget {
  final People peopleItem;
  final String imageUrl;

  const PeopleDetailScreen({super.key, required this.peopleItem, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(peopleItem.name ?? 'Unknown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 120),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${peopleItem.name ?? 'N/A'}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Height: ${peopleItem.height ?? 'N/A'} cm'),
            Text('Mass: ${peopleItem.mass ?? 'N/A'} kg'),
            Text('Hair Color: ${peopleItem.hairColor ?? 'N/A'}'),
            Text('Skin Color: ${peopleItem.skinColor ?? 'N/A'}'),
            Text('Eye Color: ${peopleItem.eyeColor ?? 'N/A'}'),
            Text('Birth Year: ${peopleItem.birthYear ?? 'N/A'}'),
            Text('Gender: ${peopleItem.gender ?? 'N/A'}'),
            const SizedBox(height: 16),
            const Text(
              'Additional Information:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Homeworld: ${peopleItem.homeworld ?? 'N/A'}'),
            Text('Films: ${peopleItem.films?.join(', ') ?? 'N/A'}'),
            Text('Vehicles: ${peopleItem.vehicles?.join(', ') ?? 'N/A'}'),
            Text('Starships: ${peopleItem.starships?.join(', ') ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}