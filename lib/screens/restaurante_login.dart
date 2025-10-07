// Este es el archivo que ya tenías, solo ajustado para que sea llamado por el Splash.
import 'package:flutter/material.dart';
import 'package:app_restaurante/core/app_colors.dart';

class RestauranteLoginPage extends StatefulWidget {
  const RestauranteLoginPage({super.key});

  @override
  State<RestauranteLoginPage> createState() => _RestauranteLoginPageState();
}

class _RestauranteLoginPageState extends State<RestauranteLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // 💡 Aquí iría la llamada a la API para autenticar y obtener el rol (COCINA o ADMIN).
      print('Intentando iniciar sesión con:');
      print('Email: $email');
      print('Contraseña: $password');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login de Empleado exitoso. Verificando rol...'),
        ),
      );

      // 💡 Lógica de Navegación por Rol:
      // if (rol == 'ADMIN') { Navigator.of(context).pushReplacement(...DashboardAdmin); }
      // else if (rol == 'COCINA') { Navigator.of(context).pushReplacement(...KitchenDisplaySystem); }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Acceso Empleados'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ... (Campos de Email y Contraseña son idénticos al código previo)
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce tu correo.';
                      }
                      if (!value.contains('@')) {
                        return 'Introduce un correo válido.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce tu contraseña.';
                      }
                      if (value.length < 6) {
                        return 'Debe tener al menos 6 caracteres.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('INICIAR SESIÓN'),
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
