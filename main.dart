import 'package:flutter/material.dart';
import 'book_api_service.dart'; // Certifique-se de que este arquivo existe e está correto
import 'read_later_screen.dart'; // Importe a nova tela
import 'login_screen.dart'; // Importe sua tela de login
import 'registration_screen.dart'; // Importe sua tela de cadastro

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Avaliação de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Define a tela de login como a tela inicial
      routes: {
        // Defina as rotas para navegação nomeada, se desejar
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Livros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _books = [];
  final BookApiService _apiService = BookApiService(); // Supondo que BookApiService está definido

  // Chave global para o Scaffold, usada para abrir o Drawer programaticamente
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final books = await _apiService.fetchBooks();
      setState(() {
        _books = books;
      });
    } catch (e) {
      debugPrint('Erro ao buscar livros: $e');
      // Adicionar um feedback visual para o usuário em caso de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar livros: $e')),
      );
    }
  }

  Widget _buildBookList(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: _books.isEmpty
              ? const Center(child: Text("Nenhum livro disponível."))
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _books.length,
            itemBuilder: (context, index) {
              final book = _books[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Atribua a chave global ao Scaffold
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Abre o Drawer
          },
        ),
        title: const Text("Bem-vindo(a), Aluno!"),
        backgroundColor: Colors.indigo[100],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Ação ao clicar no avatar do usuário, por exemplo, ir para o perfil
                debugPrint('Avatar do usuário clicado!');
              },
              child: const CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search), // Adiciona o ícone de busca ao lado do avatar
            onPressed: () {
              // Ação ao clicar no ícone de busca
              debugPrint('Ícone de busca clicado!');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.indigo,
          tabs: const [
            Tab(text: "Livros"),
            Tab(text: "Reviews"),
            Tab(text: "Listas"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text("Aluno Exemplo"),
              accountEmail: const Text("@ex_amigo"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Substitua pela URL da imagem do usuário
                backgroundColor: Colors.white,
              ),
              decoration: BoxDecoration(
                color: Colors.indigo[400],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                // Adicione a navegação para a tela Home aqui, se necessário
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Pesquisar'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                // Adicione a navegação para a tela de Pesquisa aqui
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meu perfil'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                // Adicione a navegação para a tela de Perfil aqui
              },
            ),
            ListTile(
              leading: const Icon(Icons.watch_later),
              title: const Text('Ler mais tarde'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.push( // Navega para a nova tela
                  context,
                  MaterialPageRoute(builder: (context) => ReadLaterScreen()), // <<<<<<<< AQUI ESTÁ A CORREÇÃO!
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.rate_review),
              title: const Text('Reviews'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                _tabController.animateTo(1); // Navega para a aba de Reviews
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                // Adicione a navegação para a tela de Configurações aqui
              },
            ),
            const Divider(), // Adiciona um divisor
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                // Adicione a lógica de logout aqui
                debugPrint('Usuário deslogado!');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _books.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBookList("Popular essa semana"),
                const SizedBox(height: 20),
                _buildBookList("Novidades de amigos"),
                const SizedBox(height: 20),
                _buildBookList("Popular com amigos"),
              ],
            ),
          ),
          const Center(child: Text("Conteúdo da aba Reviews")),
          const Center(child: Text("Conteúdo da aba Listas")),
        ],
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final double rating;

  const BookCover({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
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
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://via.placeholder.com/120x150.png?text=Sem+Imagem', // Imagem de fallback
                  width: 120,
                  height: 150,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Column(
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  author,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                size: 14,
                color: index < rating.round() ? Colors.amber : Colors.grey[300],
              );
            }),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
