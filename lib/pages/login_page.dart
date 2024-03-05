// ignore_for_file: avoid_print

import 'package:counter/pages/olvideMiContase%C3%B1a.dart';
import 'package:counter/pages/principal_page.dart';
import 'package:counter/pages/registro_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Usuario Autenticado");
    } catch (e) {
      print("Error al iniciar sesión: $e");
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ignore: unused_element
  Future<void> _signIn() async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    print("Usuario Autenticado");
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Principal(),
      ),
    );

  } catch (e) {
    // Manejo de errores
    print("Error al iniciar sesión: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Fondo(),
          Contenido(
            auth: _auth,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ],
      ),
    );
  }
}

class Fondo extends StatelessWidget {
  const Fondo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
    );
  }
}

class Contenido extends StatefulWidget {
  final FirebaseAuth auth;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const Contenido({
    required this.auth,
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContenidoState createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Bienvenido a tu cuenta",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Datos(
            emailController: widget.emailController,
            passwordController: widget.passwordController,
            auth: widget.auth,
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistroPage(),
                  ),
                );
              },
              child: const Text(
                "Registrarse",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Datos extends StatefulWidget {
  final FirebaseAuth auth;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const Datos({
    required this.auth,
    required this.emailController,
    required this.passwordController,
    Key? key,
  }) : super(key: key);

  @override
  State<Datos> createState() => _DatosState();
}

class _DatosState extends State<Datos> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Correo",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "correo@gcorreo.com",
            ),
          ),
          const SizedBox(height: 5,),
          const Text(
            "Contraseña",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: widget.passwordController,
            obscureText: showPassword,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "password",
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: () => {
                  setState(() {
                    showPassword == true ? showPassword = false : showPassword = true;
                  })                
                },
              )
            ),
          ),
          const SizedBox(height: 5,),
          const Remember(),
          const SizedBox( height: 5, ),
          Botones(
            emailController: widget.emailController,
            passwordController: widget.passwordController,
          ),
        ],        
      ),
    );
  }
}

class Remember extends StatefulWidget {
  const Remember({Key? key}) : super(key: key);

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: (isChecked) {
            setState(() {
              checked = isChecked ?? false;
            });
          },
        ),
        const Text(
          "Recordar cuenta",
          style: TextStyle(fontSize: 12,),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OlvideMiContrasena(),
              ),
            );
          },
          child: const Text(
            "¿Olvidó su contraseña?",
            style: TextStyle(fontSize: 12,),
          ),
        ),
      ],
    );
  }
}

class Botones extends StatelessWidget {
  final AuthController _authController = AuthController();
  final TextEditingController emailController;
  final TextEditingController passwordController;

  Botones({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          print("Antes de la autenticación");
          await _authController.signInWithEmailAndPassword(
            emailController.text,
            passwordController.text,
          );
          print("Despues de la autenticación");
          
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff142047)),
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),
        const Text(
          "O entra con:",
          style: TextStyle(color: Colors.grey,),
        ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: ()=>{},
            child: const Text(
              "Google",
              style: TextStyle(
                color: Color(0xff142047),
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
          width: double.infinity,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: ()=>{},
            child: const Text(
              "Github",
              style: TextStyle(
                color: Color(0xff142047),
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
        const SizedBox(),
      ],
    );
  }
}
