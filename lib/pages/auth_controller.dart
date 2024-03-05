// auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Lógica adicional después de iniciar sesión exitosamente
    } catch (e) {
      // Manejo de errores
      print("Error al iniciar sesión: $e");
    }
  }
}
