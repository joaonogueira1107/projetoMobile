// review_card.dart
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String bookTitle;
  final String bookAuthor;
  final String bookThumbnail;
  final String reviewerName;
  final String reviewText;
  final double rating;

  const ReviewCard({
    super.key,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookThumbnail,
    required this.reviewerName,
    required this.reviewText,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Informações do livro e avaliação
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  bookThumbnail,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'https://via.placeholder.com/80x120.png?text=Sem+Imagem',
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      bookAuthor,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 18,
                          color: index < rating.round() ? Colors.amber : Colors.grey[300],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Nome do revisor e avatar
          Row(
            children: [
              // Avatar padrão para revisor
              const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                reviewerName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Texto da avaliação
          Text(
            reviewText,
            style: const TextStyle(fontSize: 14),
            maxLines: 5, // Limita o número de linhas para a pré-visualização
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
