// user_reviews_screen.dart
import 'package:flutter/material.dart';
import 'package:projeto_mobile/review_card.dart'; // Importa o ReviewCard

class UserReviewsScreen extends StatelessWidget {
  const UserReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo para reviews do usuário
    final List<Map<String, dynamic>> userReviews = [
      {
        'bookTitle': 'O Pequeno Príncipe',
        'bookAuthor': 'Antoine de Saint-Exupéry',
        'bookThumbnail': 'https://covers.openlibrary.org/b/id/7966838-M.jpg',
        'reviewerName': 'Você', // Representando o usuário logado
        'reviewText': 'Uma obra-prima atemporal que toca a alma. Cada releitura revela novas camadas de sabedoria. Absolutamente essencial!',
        'rating': 5.0,
      },
      {
        'bookTitle': 'O Hobbit',
        'bookAuthor': 'J.R.R. Tolkien',
        'bookThumbnail': 'https://covers.openlibrary.org/b/id/8254497-M.jpg',
        'reviewerName': 'Você',
        'reviewText': 'Uma aventura cativante e o pontapé inicial para um universo fantástico. Bilbo Bolseiro é um herói improvável e adorável.',
        'rating': 4.8,
      },
      {
        'bookTitle': 'Fahrenheit 451',
        'author': 'Ray Bradbury',
        'thumbnail': 'https://covers.openlibrary.org/b/id/8267232-M.jpg',
        'reviewerName': 'Você',
        'reviewText': 'Uma distopia assustadoramente relevante. A queima de livros como metáfora para a supressão do pensamento crítico. Leitura poderosa!',
        'rating': 4.9,
      },
       {
        'bookTitle': 'O Alquimista',
        'bookAuthor': 'Paulo Coelho',
        'bookThumbnail': 'https://covers.openlibrary.org/b/id/8271790-M.jpg',
        'reviewerName': 'Você',
        'reviewText': 'Uma jornada espiritual sobre seguir seus sonhos. Inspirador, apesar de por vezes um pouco repetitivo. Vale a leitura pela mensagem positiva.',
        'rating': 4.0,
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
        title: const Text('Minhas Reviews'), // Título da tela
        centerTitle: true,
        backgroundColor: Colors.indigo[100],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black), // Ícone de filtro
            onPressed: () {
              debugPrint('Filtrar Minhas Reviews clicado!');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: userReviews.map((review) {
            return ReviewCard(
              bookTitle: review['bookTitle']!,
              bookAuthor: review['bookAuthor']!,
              bookThumbnail: review['bookThumbnail']!,
              reviewerName: review['reviewerName']!,
              reviewText: review['reviewText']!,
              rating: review['rating']!,
            );
          }).toList(),
        ),
      ),
    );
  }
}
