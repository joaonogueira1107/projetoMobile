//read_later_screen.dart
import 'package:flutter/material.dart';
import 'book_api_service.dart'; // Importe o serviço de API
import 'package:projeto_mobile/main.dart'; // Importe main.dart para BookCover

class ReadLaterScreen extends StatefulWidget {
  const ReadLaterScreen({super.key});

  @override
  State<ReadLaterScreen> createState() => _ReadLaterScreenState();
}

class _ReadLaterScreenState extends State<ReadLaterScreen> {
  List<Map<String, dynamic>> _readLaterBooks = [];
  final BookApiService _apiService = BookApiService();

  @override
  void initState() {
    super.initState();
    _fetchReadLaterBooks();
  }

  Future<void> _fetchReadLaterBooks() async {
    try {
      // Para simular a tela "Ler mais tarde", vamos pegar os mesmos livros da API
      // e simular que eles são os livros salvos.
      // Em um aplicativo real, você carregaria esses livros de um banco de dados local
      // ou de uma API específica para "ler mais tarde".
      final books = await _apiService.fetchBooks();
      setState(() {
        _readLaterBooks = books;
      });
    } catch (e) {
      debugPrint('Erro ao carregar livros para ler mais tarde: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar livros: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        title: const Text("Ler mais tarde de Aluno"),
        centerTitle: true,
        backgroundColor: Colors.indigo[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list), // Ícone de filtro
            onPressed: () {
              debugPrint('Ícone de filtro clicado!');
              // Implementar funcionalidade de filtro aqui
            },
          ),
          const SizedBox(width: 8), // Espaçamento
        ],
      ),
      body: _readLaterBooks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 colunas, como na imagem
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.55, // Ajustar para o tamanho do card do livro
          ),
          itemCount: _readLaterBooks.length,
          itemBuilder: (context, index) {
            final book = _readLaterBooks[index];
            return BookCover(
              title: book['title'] ?? 'Título Desconhecido',
              author: book['author'] ?? 'Autor Desconhecido',
              imageUrl: book['thumbnail'] ?? 'https://via.placeholder.com/120x150.png?text=Sem+Imagem',
              rating: (book['rating'] as num?)?.toDouble() ?? 0.0,
            );
          },
        ),
      ),
    );
  }
}