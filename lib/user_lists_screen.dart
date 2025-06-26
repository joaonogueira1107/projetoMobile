// user_lists_screen.dart
import 'package:flutter/material.dart';
import 'package:projeto_mobile/main.dart'; // Importa para usar BookCover, ajuste o caminho se necessário
import 'book_detail_screen.dart'; // Para navegação ao clicar no livro

class UserListsScreen extends StatelessWidget {
  const UserListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo para listas do usuário
    final List<Map<String, dynamic>> userBookLists = [
      {
        'name': 'Meus Favoritos',
        'owner': 'Você',
        'ownerAvatar': 'https://via.placeholder.com/150',
        'books': [
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
            'title': '1984',
            'author': 'George Orwell',
            'thumbnail': 'https://covers.openlibrary.org/b/id/12836268-M.jpg',
            'rating': 4.8,
          },
        ],
      },
      {
        'name': 'Ficção Científica Essencial',
        'owner': 'Você',
        'ownerAvatar': 'https://via.placeholder.com/150',
        'books': [
          {
            'title': 'Fahrenheit 451',
            'author': 'Ray Bradbury',
            'thumbnail': 'https://covers.openlibrary.org/b/id/8267232-M.jpg',
            'rating': 4.6,
          },
          {
            'title': 'Duna',
            'author': 'Frank Herbert',
            'thumbnail': 'https://covers.openlibrary.org/b/id/8230279-M.jpg', // Exemplo de imagem
            'rating': 4.7,
          },
          {
            'title': 'Admirável Mundo Novo',
            'author': 'Aldous Huxley',
            'thumbnail': 'https://covers.openlibrary.org/b/id/8251214-M.jpg', // Exemplo de imagem
            'rating': 4.5,
          },
        ],
      },
       {
        'name': 'Livros para Crescimento Pessoal',
        'owner': 'Você',
        'ownerAvatar': 'https://via.placeholder.com/150',
        'books': [
          {
            'title': 'Hábitos Atômicos',
            'author': 'James Clear',
            'thumbnail': 'https://covers.openlibrary.org/b/id/10290076-M.jpg',
            'rating': 4.9,
          },
          {
            'title': 'A Sutil Arte de Ligar o F*da-se',
            'author': 'Mark Manson',
            'thumbnail': 'https://covers.openlibrary.org/b/id/9725838-M.jpg',
            'rating': 4.2,
          },
           {
            'title': 'O Poder do Hábito',
            'author': 'Charles Duhigg',
            'thumbnail': 'https://covers.openlibrary.org/b/id/8276182-M.jpg',
            'rating': 4.5,
          },
        ],
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
        title: const Text('Minhas Listas'), // Título da tela
        centerTitle: true,
        backgroundColor: Colors.indigo[100],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black), // Ícone de filtro
            onPressed: () {
              debugPrint('Filtrar Minhas Listas clicado!');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: userBookLists.map((list) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        list['name']!,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(list['ownerAvatar']!),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            list['owner']!,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 230, // Altura para a lista horizontal de livros
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (list['books'] as List<Map<String, dynamic>>).length,
                      itemBuilder: (context, index) {
                        final book = (list['books'] as List<Map<String, dynamic>>)[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              // Navega para a tela de detalhes do livro da lista
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
