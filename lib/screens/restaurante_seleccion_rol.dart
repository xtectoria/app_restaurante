import 'package:flutter/material.dart';
import 'package:app_restaurante/core/app_colors.dart';
// 💡 Importamos la pantalla de Login para empleados
import 'restaurante_login.dart';
// // 💡 Importamos la nueva pantalla para clientes
import 'restaurante_mesa_input.dart';

class RestauranteSelectionRol extends StatelessWidget {
  const RestauranteSelectionRol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenido al Sistema de Pedidos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 50),

            // Opción 1: Soy Cliente (Acceso por número de mesa)
            _buildRoleButton(context, 'Soy Cliente', Icons.restaurant_menu, () {
              // Navegar a la pantalla de ingreso de mesa
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RestauranteMesaInputPage(),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Opción 2: Soy Empleado (Acceso por login)
            _buildRoleButton(
              context,
              'Soy Empleado',
              Icons.admin_panel_settings,
              () {
                // Navegar a la pantalla de login tradicional
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RestauranteLoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 300,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Text(title, style: const TextStyle(fontSize: 18)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
