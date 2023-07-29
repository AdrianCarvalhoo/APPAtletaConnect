import 'dart:ui';
import 'package:atividade_lista_pags/pages/consultaTorneios.dart';
import 'package:atividade_lista_pags/pages/homeTorneio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class UserService {
  List<User> _users = [];

  void createUser(String firstName, String lastName, String email,
      String password, String username) {
    User user = User(firstName, lastName, email, password, username);
    _users.add(user);
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserService _userService = UserService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    bool isAuthenticated = _userService.authenticateUser(username, password);

    if (isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NextScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário ou senha inválidos.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _createAccount(BuildContext context) {
    String firstName = '';
    String lastName = '';
    String email = '';
    String password = '';
    String username = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cadastro'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  firstName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              TextField(
                onChanged: (value) {
                  lastName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Sobrenome',
                ),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  labelText: 'Nome do usuário',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _userService.createUser(
                  firstName, lastName, email, password, username);
              Navigator.of(context).pop();
              _showSnackbar(context, 'Conta criada com sucesso!');
            },
            child: Text(
              'Criar conta',
              style: TextStyle(
                color: Colors.lightGreenAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/001/196/370/non_2x/run-speed-png.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Login',
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://th.bing.com/th/id/OIG._FrbEA6pglJtuEj9D78w?pid=ImgGn',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.network(
                      'https://i.ibb.co/2q9vv0H/logotest.png',
                    ),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Nome de usuário',
                      hintStyle: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintStyle: TextStyle(color: Colors.black87),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'Fazer login',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent.withOpacity(0.7),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _createAccount(context);
                    },
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                        color: Colors.white70.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ',
          style: TextStyle(
            color: Colors.lightGreenAccent,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://th.bing.com/th/id/OIG.gb5kt45lQ.L81uaLIe76?pid=ImgGn',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bem-vindo ao nosso App!',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white70,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                    child: Text(
                      'Avançar para Cadastrar Atleta',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent.withOpacity(0.7),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConsultaTorneio(),
                        ),
                      );
                    },
                    child: Text(
                      'Avançar para Consultar Torneios',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent.withOpacity(0.7),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeTorneio(),
                        ),
                      );
                    },
                    child: Text(
                      'Avançar para Cadastrar Torneio',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 80,
            right: 80,
            child: Image.network(
              'https://lojabrasilsports.com.br/imagem/rodape.png',
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
