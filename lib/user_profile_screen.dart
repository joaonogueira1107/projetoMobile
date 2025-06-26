// user_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:projeto_mobile/main.dart'; // Importa para usar BookCover, ajuste o caminho se necessário
import 'following_screen.dart'; // Nova tela de Seguindo
import 'followers_screen.dart'; // Nova tela de Seguidores
import 'user_books_screen.dart'; // Nova tela de Livros do usuário
import 'user_reviews_screen.dart'; // Nova tela de Reviews do usuário
import 'user_lists_screen.dart'; // Nova tela de Listas do usuário


class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo para Livros Favoritos (mock data)
    final List<Map<String, dynamic>> favoriteBooks = [
      {
        'title': 'Pai Rico, Pai Pobre',
        'author': 'Robert Kiyosaki',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8372675-M.jpg', // Exemplo de imagem
        'rating': 4.5,
      },
      {
        'title': 'A Revolução dos Bichos',
        'author': 'George Orwell',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10292795-M.jpg', // Exemplo de imagem
        'rating': 5.0,
      },
      {
        'title': '1984',
        'author': 'George Orwell',
        'thumbnail': 'https://covers.openlibrary.org/b/id/12836268-M.jpg', // Exemplo de imagem
        'rating': 4.8,
      },
      {
        'title': 'Harry Potter e a Pedra Filosofal',
        'author': 'J.K. Rowling',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8230278-M.jpg', // Exemplo de imagem
        'rating': 4.9,
      },
    ];

    // Dados de exemplo para Últimos Livros Lidos (mock data)
    final List<Map<String, dynamic>> lastReadBooks = [
      {
        'title': 'Uma Breve História da Humanidade',
        'author': 'Yuval Noah Harari',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8447816-M.jpg',
        'rating': 4.7,
      },
      {
        'title': 'O Homem de Giz',
        'author': 'C.J. Tudor',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8718635-M.jpg',
        'rating': 4.2,
      },
      {
        'title': 'Memórias Póstumas de Brás Cubas',
        'author': 'Machado de Assis',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10103756-M.jpg',
        'rating': 4.9,
      },
      {
        'title': 'A Menina que Roubava Livros',
        'author': 'Markus Zusak',
        'thumbnail': 'https://covers.openlibrary.org/b/id/12674395-M.jpg',
        'rating': 4.6,
      },
       {
        'title': 'Antes que o café esfrie',
        'author': 'Toshikazu Kawaguchi',
        'thumbnail': 'https://covers.openlibrary.org/b/id/10706509-M.jpg',
        'rating': 4.0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Sem sombra
      ),
      extendBodyBehindAppBar: true, // Estende o corpo atrás da AppBar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80), // Espaço para a AppBar transparente
            // Imagem do perfil
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Substitua pela imagem do usuário
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 16),
            // Nome do usuário
            const Text(
              'Aluno', // Substitua pelo nome real do usuário
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // Seção Livros Favoritos
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Livros Favoritos',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 230, // Altura para a lista horizontal de livros
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: favoriteBooks.length,
                itemBuilder: (context, index) {
                  final book = favoriteBooks[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BookCover(
                      title: book['title']!,
                      author: book['author']!,
                      imageUrl: book['thumbnail']!,
                      rating: (book['rating'] as num).toDouble(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Seção Últimos livros lidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Últimos livros lidos',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint('Ver mais clicado');
                      // TODO: Implementar navegação para tela "Ver Mais" de livros lidos
                    },
                    child: const Text('Ver mais'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 230, // Altura para a lista horizontal de livros
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: lastReadBooks.length,
                itemBuilder: (context, index) {
                  final book = lastReadBooks[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: BookCover(
                      title: book['title']!,
                      author: book['author']!,
                      imageUrl: book['thumbnail']!,
                      rating: (book['rating'] as num).toDouble(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            // Métricas do usuário
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Torna "Livros" clicável
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/user_books');
                    },
                    child: _buildMetricRow(context, 'Livros', '522/13 esse ano'),
                  ),
                  const Divider(),
                  // "Diário" foi removido
                  GestureDetector( // Torna "Reviews" clicável
                    onTap: () {
                      Navigator.pushNamed(context, '/user_reviews');
                    },
                    child: _buildMetricRow(context, 'Reviews', '113'),
                  ),
                  const Divider(),
                  GestureDetector( // Torna "Listas" clicável
                    onTap: () {
                      Navigator.pushNamed(context, '/user_lists');
                    },
                    child: _buildMetricRow(context, 'Listas', '5'),
                  ),
                  const Divider(),
                  // "Ler mais tarde" e "Curtidas" foram removidos
                  GestureDetector( // Torna "Seguindo" clicável
                    onTap: () {
                      Navigator.pushNamed(context, '/following');
                    },
                    child: _buildMetricRow(context, 'Seguindo', '133'),
                  ),
                  const Divider(),
                  GestureDetector( // Torna "Seguidores" clicável
                    onTap: () {
                      Navigator.pushNamed(context, '/followers');
                    },
                    child: _buildMetricRow(context, 'Seguidores', '55'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir cada linha de métrica
  Widget _buildMetricRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
