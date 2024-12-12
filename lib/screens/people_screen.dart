import 'package:flutter/material.dart';
import 'package:listaprofesional/models/people_response/people_response.dart';
import 'package:http/http.dart' as http;

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  late Future<PeopleResponse> peopleResponse;

  @override
  void initState() {
    super.initState();
    peopleResponse = getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STAR WHAT?'),
      ),
      body: FutureBuilder<PeopleResponse>(
        future: peopleResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildPeopleList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<PeopleResponse> getPeople() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));

    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _buildPeopleList(PeopleResponse peopleResponse) {
    return ListView.builder(
      itemCount: peopleResponse.results!.length,
      itemBuilder: (context, index) {
        final character = peopleResponse.results![index];
        final imageUrl = 'https://starwars-visualguide.com/assets/img/characters/${index + 1}.jpg';

        return Container(
          color: index.isEven ? Colors.grey[200] : Colors.white,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 60),
                ),
              ),
              title: Text(
                character.name ?? 'Unknown',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Height: ${character.height ?? 'N/A'} cm\n'
                'Mass: ${character.mass ?? 'N/A'} kg\n'
                'Hair Color: ${character.hairColor ?? 'N/A'}\n'
                'Skin Color: ${character.skinColor ?? 'N/A'}\n'
                'Eye Color: ${character.eyeColor ?? 'N/A'}\n'
                'Birth Year: ${character.birthYear ?? 'N/A'}\n'
                'Gender: ${character.gender ?? 'N/A'}',
                style: const TextStyle(fontSize: 14),
              ),
              trailing: const Icon(Icons.more_vert),
            ),
          ),
        );
      },
    );
  }
}
