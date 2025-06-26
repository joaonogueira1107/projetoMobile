// main.dart
import 'package:flutter/material.dart';
import 'book_api_service.dart';
import 'read_later_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'book_detail_screen.dart';
import 'user_profile_screen.dart';
import 'following_screen.dart';
import 'followers_screen.dart';
import 'review_card.dart'; // Importe o novo widget ReviewCard
import 'user_books_screen.dart'; // Importe a nova tela de Livros do usuário
import 'user_reviews_screen.dart'; // Importe a nova tela de Reviews do usuário
import 'user_lists_screen.dart'; // Importe a nova tela de Listas do usuário


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Avaliação de Livros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/read_later': (context) => const ReadLaterScreen(),
        '/user_profile': (context) => const UserProfileScreen(),
        '/following': (context) => const FollowingScreen(),
        '/followers': (context) => const FollowersScreen(),
        '/user_books': (context) => const UserBooksScreen(), // Rota para Livros do usuário
        '/user_reviews': (context) => const UserReviewsScreen(), // Rota para Reviews do usuário
        '/user_lists': (context) => const UserListsScreen(), // Rota para Listas do usuário
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/book_detail') {
          final book = settings.arguments as Map<String, dynamic>?;
          if (book != null) {
            return MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: book),
            );
          }
        }
        return null;
      },
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
  final BookApiService _apiService = BookApiService(); 

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dados simulados para as reviews
  final List<Map<String, dynamic>> _friendReviews = [
    {
      'bookTitle': 'Capitães da Areia',
      'bookAuthor': 'Jorge Amado',
      'bookThumbnail': 'https://covers.openlibrary.org/b/id/8440537-M.jpg',
      'reviewerName': 'Aluno2',
      'reviewText': 'Essa foi a minha primeira leitura de Jorge Amado. E que leitura! Capitães da Areia não é somente uma crítica que persiste a ser feita, mas para além dela um encontro prazeroso com a escrita envolvente e popular de Jorge Amado. As vivências de Pedro Bala e do seu bando nas ruas da Bahia me fizeram não querer parar de descobrir quais seriam as (des)aventuras do próximo capítulo. Recomendo como uma ótima obra para quem quer se iniciar no universo de Amado.',
      'rating': 5.0,
    },
    {
      'bookTitle': 'Como eu era antes de você',
      'bookAuthor': 'Jojo Moyes',
      'bookThumbnail': 'https://covers.openlibrary.org/b/id/10667086-M.jpg',
      'reviewerName': 'Aluno3',
      'reviewText': 'Esse livro é perfeito, prende a atenção do leitor do início ao fim, o mesmo pode ser atribuído aos outros dois livros dessa trilogia. RECOMENDO DEMAIS.',
      'rating': 4.5,
    },
    {
      'bookTitle': 'A menina que roubava livros',
      'bookAuthor': 'Markus Zusak',
      'bookThumbnail': 'https://covers.openlibrary.org/b/id/12674395-M.jpg',
      'reviewerName': 'Aluno4',
      'reviewText': 'Um livro inteligente, profundo, bonito. Uma história que cruza realidade, experiência, sentimento e vida. Vale muito a leitura, vale a riqueza do relato.',
      'rating': 4.8,
    },
  ];

  // Dados simulados para as listas de livros
  final List<Map<String, dynamic>> _bookLists = [
    {
      'name': 'Novidades de amigos',
      'owner': 'Aluno2', // Nome do criador da lista
      'ownerAvatar': 'https://via.placeholder.com/150', // Avatar do criador
      'books': [
        {
          'title': 'Capitães da Areia',
          'author': 'Jorge Amado',
          'thumbnail': 'https://covers.openlibrary.org/b/id/8440537-M.jpg',
          'rating': 5.0,
        },
        {
          'title': 'A Princesa e a Ervilha',
          'author': 'Hans Christian Andersen',
          'thumbnail': 'https://covers.openlibrary.org/b/id/6932598-M.jpg',
          'rating': 4.0,
        },
        {
          'title': 'O Estrangeiro',
          'author': 'Albert Camus',
          'thumbnail': 'https://covers.openlibrary.org/b/id/8299105-M.jpg',
          'rating': 4.5,
        },
      ],
    },
    {
      'name': 'Favs da linda',
      'owner': 'Aluno3',
      'ownerAvatar': 'https://via.placeholder.com/150',
      'books': [
        {
          'title': 'Como eu era antes de você',
          'author': 'Jojo Moyes',
          'thumbnail': 'https://covers.openlibrary.org/b/id/10667086-M.jpg',
          'rating': 4.5,
        },
        {
          'title': 'James e o Pêssego Gigante',
          'author': 'Roald Dahl',
          'thumbnail': 'https://covers.openlibrary.org/b/id/9091871-M.jpg',
          'rating': 4.2,
        },
        {
          'title': 'Novelas nada exemplares',
          'author': 'Dalton Trevisan',
          'thumbnail': 'https://covers.openlibrary.org/b/id/8991819-M.jpg',
          'rating': 4.0,
        },
      ],
    },
    {
      'name': 'Esses moldam caráter',
      'owner': 'Aluno',
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
          'title': 'Uma Breve História da Humanidade',
          'author': 'Yuval Noah Harari',
          'thumbnail': 'https://covers.openlibrary.org/b/id/8447816-M.jpg',
          'rating': 4.7,
        },
      ],
    },
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchBooks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchBooks() async {
    debugPrint('Iniciando _fetchBooks...');
    try {
      final books = await _apiService.fetchBooks();
      debugPrint('Livros recebidos da API: ${books.length} livros');
      setState(() {
        _books = books;
      });
      debugPrint('Estado _books atualizado. Primeiro livro: ${_books.isNotEmpty ? _books[0]['title'] : 'Nenhum'}');
    } catch (e) {
      debugPrint('Erro ao buscar livros: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar livros: $e')),
      );
    }
  }

  Widget _buildBookList(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
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
                      child: GestureDetector(
                        onTap: () {
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
    );
  }

  Widget _buildReviewsFeed() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção "Novidades de amigos"
          Text(
            'Novidades de amigos',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ..._friendReviews.map((review) {
            return ReviewCard(
              bookTitle: review['bookTitle']!,
              bookAuthor: review['bookAuthor']!,
              bookThumbnail: review['bookThumbnail']!,
              reviewerName: review['reviewerName']!,
              reviewText: review['reviewText']!,
              rating: review['rating']!,
            );
          }).toList(),
          const SizedBox(height: 20),

          // Seção "Popular essa semana" - Adicione mais reviews aqui se desejar
          Text(
            'Popular essa semana',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Exemplo de uma review adicional para "Popular essa semana"
          ReviewCard(
            bookTitle: 'O Pequeno Príncipe',
            bookAuthor: 'Antoine de Saint-Exupéry',
            bookThumbnail: 'https://covers.openlibrary.org/b/id/7966838-M.jpg',
            reviewerName: 'Visitante1',
            reviewText: 'Um clássico atemporal que nos faz refletir sobre a vida e os relacionamentos. Leitura obrigatória para todas as idades!',
            rating: 5.0,
          ),
          ReviewCard(
            bookTitle: 'Dom Casmurro',
            bookAuthor: 'Machado de Assis',
            bookThumbnail: 'https://covers.openlibrary.org/b/id/8885662-M.jpg',
            reviewerName: 'Visitante2',
            reviewText: 'A trama de ciúmes e incertezas de Bentinho é um mergulho na psicologia humana. Capitu traiu ou não traiu? O debate continua!',
            rating: 4.7,
          ),
        ],
      ),
    );
  }

  Widget _buildListsFeed() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _bookLists.map((list) {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text("Bem-vindo(a), Aluno!"),
        backgroundColor: Colors.indigo[100],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                debugPrint('Avatar do usuário clicado!');
              },
              child: const CircleAvatar(
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
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
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
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
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home'); 
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Pesquisar'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Meu perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/user_profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.watch_later),
              title: const Text('Ler mais tarde'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/read_later');
              },
            ),
            ListTile(
              leading: const Icon(Icons.rate_review),
              title: const Text('Reviews'),
              onTap: () {
                Navigator.pop(context);
                _tabController.animateTo(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login'); 
                debugPrint('Usuário deslogado!');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Conteúdo da aba "Livros"
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
          // Conteúdo da aba "Reviews"
          _buildReviewsFeed(),
          // Conteúdo da aba "Listas"
          _buildListsFeed(),
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
                  'https://via.placeholder.com/120x150.png?text=Sem+Imagem',
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
