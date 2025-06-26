// followers_screen.dart
import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados de exemplo para a lista de "Seguidores"
    final List<Map<String, dynamic>> followersUsers = [
      {'name': 'Aluno2', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno3', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno4', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno5', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno6', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno7', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno8', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': false},
      {'name': 'Aluno9', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': true},
      {'name': 'Aluno10', 'avatar': 'https://via.placeholder.com/150', 'isFollowing': false},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Seguidores'), // Título da tela
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black), // Ícone de filtro
            onPressed: () {
              debugPrint('Filtrar Seguidores clicado!');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: followersUsers.length,
        itemBuilder: (context, index) {
          final user = followersUsers[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['avatar']!),
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(user['name']!),
                trailing: IconButton(
                  icon: Icon(
                    user['isFollowing'] ? Icons.check_circle : Icons.add_circle,
                    color: user['isFollowing'] ? Colors.green : Colors.grey,
                  ),
                  onPressed: () {
                    // TODO: Implementar lógica de seguir/deixar de seguir
                    debugPrint('Ação de seguir/deixar de seguir para ${user['name']}');
                  },
                ),
                onTap: () {
                  // TODO: Implementar navegação para o perfil do usuário clicado
                  debugPrint('Perfil de ${user['name']} clicado!');
                },
              ),
              const Divider(indent: 72), // Linha divisória
            ],
          );
        },
      ),
    );
  }
}
