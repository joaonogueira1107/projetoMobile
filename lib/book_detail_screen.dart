// book_detail_screen.dart
import 'package:flutter/material.dart';
import 'book_api_service.dart'; // Certifique-se de importar o BookApiService

class BookDetailScreen extends StatefulWidget {
  // O mapa de dados do livro que será passado da tela anterior (Home Screen).
  final Map<String, dynamic> book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  Map<String, dynamic>? _fullBookDetails; // Detalhes completos do livro (resumo, ano)
  bool _isLoading = true; // Flag para indicar se os dados estão sendo carregados
  String _errorMessage = ''; // Mensagem de erro, se houver

  @override
  void initState() {
    super.initState();
    _fetchFullBookDetails(); // Inicia a busca pelos detalhes completos do livro
  }

  // Função assíncrona para buscar os detalhes completos do livro usando o workKey.
  Future<void> _fetchFullBookDetails() async {
    final String? workKey = widget.book['key']; // Obtém o 'key' (ID da obra) do livro inicial.

    // Verifica se o 'workKey' é nulo; se for, não há como buscar detalhes.
    if (workKey == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'ID da obra não encontrado para buscar detalhes.';
      });
      return;
    }

    try {
      // Chama o serviço de API para buscar os detalhes do livro.
      final details = await BookApiService().fetchBookDetails(workKey);
      setState(() {
        _fullBookDetails = details; // Armazena os detalhes na variável de estado.
        _isLoading = false; // Define o carregamento como concluído.
      });
    } catch (e) {
      // Em caso de erro, atualiza a mensagem de erro e define o carregamento como concluído.
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro ao carregar detalhes do livro: $e';
      });
      debugPrint('Erro ao carregar detalhes do livro: $e'); // Imprime o erro no console de depuração.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dados iniciais do livro (passados da Home Screen)
    final String title = widget.book['title'] ?? 'Título Desconhecido';
    final String author = widget.book['author'] ?? 'Autor Desconhecido';
    final String imageUrl = widget.book['thumbnail'] ?? 'https://via.placeholder.com/120x150.png?text=Sem+Imagem';
    final double rating = (widget.book['rating'] as num?)?.toDouble() ?? 0.0;

    // Dados que serão preenchidos pela requisição de detalhes (iniciais ou da API).
    String summary = 'Resumo não disponível.';
    String publicationYear = 'Ano Desconhecido';

    // Se os detalhes completos foram carregados, atualiza o resumo e o ano de publicação.
    if (_fullBookDetails != null) {
      summary = _fullBookDetails!['description'] ?? summary;
      publicationYear = _fullBookDetails!['first_publish_year'] ?? publicationYear;
    }

    return Scaffold(
      appBar: AppBar(
        // Título da AppBar, truncado se for muito longo.
        title: Text(title.length > 20 ? '${title.substring(0, 17)}...' : title),
        backgroundColor: Colors.indigo[100],
        elevation: 0, // Remove a sombra da AppBar.
      ),
      body: _isLoading // Se estiver carregando, mostra um CircularProgressIndicator.
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty // Se houver um erro, exibe a mensagem de erro.
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                )
              : SingleChildScrollView( // Conteúdo da tela de detalhes do livro.
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título do livro.
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Capa do livro.
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            imageUrl,
                            width: 200,
                            height: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://via.placeholder.com/200x300.png?text=Sem+Imagem',
                                width: 200,
                                height: 300,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Avaliação do livro (estrelas).
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 24,
                            color: index < rating.round() ? Colors.amber : Colors.grey[300],
                          );
                        }),
                      ),
                      const SizedBox(height: 24),

                      // Autor do livro.
                      Text(
                        'Autor: $author',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Resumo do livro (carregado da API).
                      const Text(
                        'Resumo:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        summary,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),

                      // Ano de Lançamento do livro (carregado da API).
                      Text(
                        'Ano Lançamento: $publicationYear',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Botões de ação.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('"${widget.book['title']}" adicionado à lista!')),
                              );
                            },
                            icon: const Icon(Icons.bookmark_add, color: Colors.white),
                            label: const Text('Ler mais tarde', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Avaliar "${widget.book['title']}"')),
                              );
                            },
                            icon: const Icon(Icons.star_rate, color: Colors.white),
                            label: const Text('Avaliar', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }
}
