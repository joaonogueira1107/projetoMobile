import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class BookApiService {
  static const String _baseUrl = 'https://openlibrary.org/search.json?q=the';

  Future<List<Map<String, dynamic>>> fetchBooks() async {
    final randomPage = Random().nextInt(10) + 1; // páginas 1 a 10
    final response = await http.get(Uri.parse('$_baseUrl&page=$randomPage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List books = data['docs'];

      return books.map<Map<String, dynamic>>((book) {
        final coverId = book['cover_i'];
        final title = book['title'] ?? 'Sem título';
        final author = (book['author_name'] != null && book['author_name'].isNotEmpty)
            ? book['author_name'][0]
            : 'Autor desconhecido';

        final thumbnail = coverId != null
            ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
            : 'https://via.placeholder.com/128x198.png?text=Sem+Imagem';

        return {
          'title': title,
          'author': author,
          'thumbnail': thumbnail,
          'rating': 3.0, // Simulação de avaliação
        };
      }).take(10).toList(); // limita a 10 livros por sessão
    } else {
      throw Exception('Erro ao carregar livros da Open Library');
    }
  }
}
