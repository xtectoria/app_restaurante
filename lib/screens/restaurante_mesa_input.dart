import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_restaurante/core/app_colors.dart';
// 💡 Importamos la nueva pantalla de menú
import 'restaurante_menu.dart';

// Constante para el límite de mesas
const int maxMesas = 17;

class RestauranteMesaInputPage extends StatefulWidget {
  const RestauranteMesaInputPage({super.key});

  @override
  State<RestauranteMesaInputPage> createState() =>
      _RestauranteMesaInputPageState();
}

class _RestauranteMesaInputPageState extends State<RestauranteMesaInputPage> {
  final TextEditingController _mesaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _ingresarMesa() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      String numeroMesa = _mesaController.text;

      // La validación ya ocurrió, solo navegamos.
      print('Mesa ingresada: $numeroMesa. Navegando al Menú...');

      // 🚀 Navegación a la pantalla del menú
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RestauranteMenuClientePage(mesaId: numeroMesa),
        ),
      );
    }
  }

  @override
  void dispose() {
    _mesaController.dispose();
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
          title: const Text('Ingresa tu Número de Mesa'),
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
                  const Text(
                    'Por favor, ingresa el número de mesa (1 a $maxMesas).',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.secondary),
                  ),
                  const SizedBox(height: 30),

                  // Campo de Número de Mesa
                  TextFormField(
                    controller: _mesaController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        2,
                      ), // Límite a 2 dígitos (suficiente para el 17)
                    ],
                    decoration: InputDecoration(
                      labelText: 'Número de Mesa',
                      hintText: 'Ej: 15',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                    // 💡 VALIDACIÓN CLAVE: Asegura que el número esté entre 1 y 17
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debes ingresar un número de mesa.';
                      }
                      final int? mesa = int.tryParse(value);
                      if (mesa == null || mesa < 1 || mesa > maxMesas) {
                        return 'Número de mesa inválido. Debe ser entre 1 y $maxMesas.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 40),

                  // Botón de Ingresar
                  ElevatedButton(
                    onPressed: _ingresarMesa,
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
                    child: const Text('VER MENÚ'),
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
