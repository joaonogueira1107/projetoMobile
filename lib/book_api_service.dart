// book_api_service.dart
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
        // Extrai o 'key' (ID da obra) para buscar detalhes posteriormente
        final workKey = book['key'] as String?;

        final thumbnail = coverId != null
            ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
            : 'https://via.placeholder.com/128x198.png?text=Sem+Imagem';

        return {
          'title': title,
          'author': author,
          'thumbnail': thumbnail,
          'rating': 3.0, // Simulação de avaliação
          'key': workKey, // Adiciona o key para uso na tela de detalhes
        };
      }).take(10).toList(); // limita a 10 livros por sessão
    } else {
      throw Exception('Erro ao carregar livros da Open Library');
    }
  }

  // Novo método para buscar detalhes de um livro específico
  Future<Map<String, dynamic>> fetchBookDetails(String workId) async {
    final response = await http.get(Uri.parse('https://openlibrary.org$workId.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      // Extrai a descrição, que pode ser uma String ou um Map
      String description = 'Resumo não disponível.';
      if (data['description'] is String) {
        description = data['description'];
      } else if (data['description'] is Map && data['description'].containsKey('value')) {
        description = data['description']['value'];
      }

      // Extrai o ano de lançamento
      final String firstPublishYear = data['first_publish_year']?.toString() ?? 'Ano Desconhecido';

      return {
        'description': description,
        'first_publish_year': firstPublishYear,
        // Você pode adicionar outros campos que a API de detalhes fornece aqui
      };
    } else {
      throw Exception('Erro ao carregar detalhes do livro: ${response.statusCode}');
    }
  }
}
