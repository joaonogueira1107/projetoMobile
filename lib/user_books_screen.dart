// user_books_screen.dart
import 'package:flutter/material.dart';
import 'package:projeto_mobile/main.dart'; // Importa para usar BookCover, ajuste o caminho se necessário
import 'book_detail_screen.dart'; // Importa a tela de detalhes do livro


class UserBooksScreen extends StatelessWidget {
  const UserBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo para livros avaliados pelo usuário
    final List<Map<String, dynamic>> userEvaluatedBooks = [
      {
        'title': 'Pai Rico, Pai Pobre',
        'author': 'Robert Kiyosaki',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8372675-M.jpg',
        'rating': 4.5,
      },
      {
        'title': 'A Revolução dos Bichos',
        'author': 'George Orwell',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10292795-M.jpg',
        'rating': 5.0,
      },
      {
        'title': 'The Complete Maus',
        'author': 'Art Spiegelman',
        'thumbnail': 'https://covers.openlibrary.org/b/id/12316499-M.jpg', // Exemplo de imagem
        'rating': 4.8,
      },
      {
        'title': 'O Homem de Giz',
        'author': 'C.J. Tudor',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8718635-M.jpg',
        'rating': 4.2,
      },
      {
        'title': 'Antes que o café esfrie',
        'author': 'Toshikazu Kawaguchi',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10706509-M.jpg',
        'rating': 4.0,
      },
      {
        'title': 'Memórias Póstumas de Brás Cubas',
        'author': 'Machado de Assis',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10103756-M.jpg',
        'rating': 4.9,
      },
      {
        'title': 'Uma Breve História da Humanidade',
        'author': 'Yuval Noah Harari',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8447816-M.jpg',
        'rating': 4.7,
      },
      {
        'title': 'Harry Potter e a Pedra Filosofal',
        'author': 'J.K. Rowling',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8230278-M.jpg',
        'rating': 4.9,
      },
      {
        'title': 'Fahrenheit 451',
        'author': 'Ray Bradbury',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8267232-M.jpg', // Exemplo de imagem
        'rating': 4.6,
      },
      {
        'title': 'O Luto é Coisa com Penas',
        'author': 'Max Porter',
        'thumbnail': 'https://covers.openlibrary.org/b/id/9749175-M.jpg', // Exemplo de imagem
        'rating': 4.3,
      },
      {
        'title': 'É Muito Céu Pra Tão Pouco Certo',
        'author': 'Alice Ruiz',
        'thumbnail': 'https://covers.openlibrary.org/b/id/9379650-M.jpg', // Exemplo de imagem
        'rating': 4.1,
      },
      {
        'title': 'Você Não Está Sozinho',
        'author': 'Dalai Lama',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10892015-M.jpg', // Exemplo de imagem
        'rating': 4.4,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Livros de Aluno'), // Título da tela
        centerTitle: true,
        backgroundColor: Colors.indigo[100],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black), // Ícone de filtro
            onPressed: () {
              debugPrint('Filtrar Livros de Aluno clicado!');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 colunas, como na imagem
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.55, // Ajustar para o tamanho do card do livro
          ),
          itemCount: userEvaluatedBooks.length,
          itemBuilder: (context, index) {
            final book = userEvaluatedBooks[index];
            return GestureDetector(
              onTap: () {
                // Navega para a tela de detalhes do livro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: book),
                  ),
                );
              },
              child: BookCover(
                title: book['title'] ?? 'Título Desconhecido',
                author: book['author'] ?? 'Autor Desconhecido',
                imageUrl: book['thumbnail'] ?? 'https://via.placeholder.com/120x150.png?text=Sem+Imagem',
                rating: (book['rating'] as num?)?.toDouble() ?? 0.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
