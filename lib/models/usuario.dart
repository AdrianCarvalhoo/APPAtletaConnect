import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

class UserService {
  List<User> _users = [];
  PostgreSQLConnection? _connection;

  UserService() {
    fetchUsersFromDatabase();
  }

  void fetchUsersFromDatabase() async {
    final connection = PostgreSQLConnection(
      'localhost',
      5432,
      'projetoweb',
      username: 'postgres',
      password: 'postgres',
    );

    await connection.open();

    final results = await connection.query('SELECT * FROM users');
    for (final row in results) {
      final rowMap = row.toColumnMap();
      final user = User(
        rowMap['firstname'] != null ? rowMap['firstname'].toString() : '',
        rowMap['lastname'] != null ? rowMap['lastname'].toString() : '',
        rowMap['email'] != null ? rowMap['email'].toString() : '',
        rowMap['password'] != null ? rowMap['password'].toString() : '',
        rowMap['username'] != null ? rowMap['username'].toString() : '',
      );
      _users.add(user);
    }

    await connection.close();
  }

  Future<void> connectToDatabase() async {
    _connection = PostgreSQLConnection('localhost', 5432, 'projetoweb',
        username: 'postgres', password: 'postgres');
    await _connection!.open();
  }

  Future<void> closeConnection() async {
    await _connection?.close();
  }

  Future<void> createUser(String firstName, String lastName, String email,
      String password, String username) async {
    await _connection?.transaction((connection) async {
      final id = Uuid().v4();
      await connection.query(
        'INSERT INTO users (id, username, password, firstname, lastname, email) VALUES (@id, @username, @password, @firstname, @lastname, @email)',
        substitutionValues: {
          'id': id,
          'username': username,
          'password': password,
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
        },
      );
    });
  }

  bool authenticateUser(String username, String password) {
    for (User user in _users) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }
}

class User {
  String firstName;
  String lastName;
  String email;
  String password;
  String username;

  User(this.firstName, this.lastName, this.email, this.password, this.username);
}

void main() async {
  final userService = UserService();

  // Criando um novo usuário
  await userService.connectToDatabase();
  await userService.createUser(
    'Aluno',
    'Exemplo',
    'aluno@gmail.com',
    'aluno111',
    'alunoexemplo',
  );
  await userService.closeConnection();

  if (userService.authenticateUser('adriancarv', 'adrian123')) {
    print('Usuário autenticado com sucesso!');
  } else {
    print('');
  }
}
