import 'package:app_restaurante/screens/restaurante_seleccion_rol.dart';
import 'package:flutter/material.dart';
import 'package:app_restaurante/core/app_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Casa Flora'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        backgroundColor: AppColors.background,
        body: RestauranteSelectionRol(),
      ),
    );
  }
}
