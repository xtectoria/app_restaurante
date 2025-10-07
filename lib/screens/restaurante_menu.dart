import 'package:flutter/material.dart';
import 'package:app_restaurante/core/app_colors.dart';

// --- Modelos de Datos (Sin Cambios) ---

class MenuItem {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

class RestauranteMenuClientePage extends StatefulWidget {
  final String mesaId;

  const RestauranteMenuClientePage({super.key, required this.mesaId});

  @override
  State<RestauranteMenuClientePage> createState() =>
      _RestauranteMenuClientePageState();
}

class _RestauranteMenuClientePageState
    extends State<RestauranteMenuClientePage> {
  final Map<String, int> _itemQuantities = {};

  // Lista de items de ejemplo (Usaremos los mismos datos)
  final List<MenuItem> _menuItems = [
    MenuItem(
      id: '1',
      name: 'Hamburguesa Clásica',
      price: 8.50,
      description:
          'Carne de res premium, queso cheddar, lechuga romana, tomate y salsa especial de la casa. Servida con papas fritas.',
      imageUrl: 'assets/hamburguesa.jpg',
    ),
    MenuItem(
      id: '2',
      name: 'Pizza Pepperoni',
      price: 12.99,
      description:
          'Masa artesanal, salsa de tomate natural, abundante queso mozzarella y rodajas de pepperoni picante.',
      imageUrl: 'assets/pizza.jpg',
    ),
    MenuItem(
      id: '3',
      name: 'Tacos de Pescado',
      price: 9.25,
      description:
          'Tres tacos de tortilla de maíz con pescado blanco a la parrilla, repollo rallado y aderezo cremoso de chipotle.',
      imageUrl: 'assets/tacos.jpg',
    ),
    MenuItem(
      id: '4',
      name: 'Ensalada de Quinoa',
      price: 7.50,
      description:
          'Quinoa fresca, aguacate, tomate cherry, pepino y vinagreta de limón.',
      imageUrl: 'assets/ensalada.jpg',
    ),
    MenuItem(
      id: '5',
      name: 'Agua Embotellada',
      price: 1.50,
      description: 'Botella de agua mineral de 500ml, perfecta para acompañar.',
      imageUrl: 'assets/agua.jpg',
    ),
    MenuItem(
      id: '6',
      name: 'Cerveza Artesanal',
      price: 4.00,
      description: 'Cerveza IPA de lúpulo intenso y sabor cítrico.',
      imageUrl: 'assets/cerveza.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (var item in _menuItems) {
      _itemQuantities[item.id] = 0;
    }
  }

  // --- Funciones de Lógica (Mantenidas) ---

  void _incrementQuantity(String itemId) {
    setState(() {
      _itemQuantities[itemId] = (_itemQuantities[itemId] ?? 0) + 1;
    });
  }

  void _decrementQuantity(String itemId) {
    setState(() {
      if ((_itemQuantities[itemId] ?? 0) > 0) {
        _itemQuantities[itemId] = (_itemQuantities[itemId]!) - 1;
      }
    });
  }

  void _addToCart(MenuItem item) {
    final quantity = _itemQuantities[item.id] ?? 0;
    if (quantity > 0) {
      // 💡 Lógica de Carrito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Añadidos $quantity x ${item.name} al carrito.'),
        ),
      );
      setState(() {
        _itemQuantities[item.id] = 0;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selecciona una cantidad mayor a cero para ${item.name}.',
          ),
        ),
      );
    }
  }

  void _showDetailsModal(MenuItem item) {
    // La lógica del modal de detalles es la misma que la anterior.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item.imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Divider(height: 30),

              const Text(
                'Descripción e Ingredientes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    item.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Widget de Tarjeta Individual ---

  Widget _buildItemCard(MenuItem item) {
    final quantity = _itemQuantities[item.id] ?? 0;

    return Card(
      elevation: 4,
      // 💡 Altura y diseño vertical definidos por el contenido y el childAspectRatio del GridView
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1. IMAGEN (Ocupa aproximadamente la mitad de la altura disponible)
          Expanded(
            flex: 5, // 💡 Mayor proporción para la imagen
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
              ),
            ),
          ),

          // 2. INFORMACIÓN Y CONTROLES
          Expanded(
            flex: 6, // 💡 Proporción para el texto y controles
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nombre y Precio
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.secondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // Botón Detalles
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                    child: TextButton(
                      onPressed: () => _showDetailsModal(item),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Mostrar Detalles',
                        style: TextStyle(color: AppColors.accent, fontSize: 12),
                      ),
                    ),
                  ),

                  // Separador
                  const Divider(height: 8, thickness: 1),

                  // Selector de Cantidad y Botón de Carrito (en una fila)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Selector de Cantidad
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildQuantityButton(
                            Icons.remove_circle,
                            () => _decrementQuantity(item.id),
                            Colors.red,
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _buildQuantityButton(
                            Icons.add_circle,
                            () => _incrementQuantity(item.id),
                            Colors.green,
                          ),
                        ],
                      ),

                      // Botón "Agregar"
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: quantity > 0
                              ? () => _addToCart(item)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            textStyle: const TextStyle(fontSize: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Agregar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para los botones de cantidad
  Widget _buildQuantityButton(
    IconData icon,
    VoidCallback onPressed,
    Color color,
  ) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        icon: Icon(icon, color: color, size: 20),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Menú - Mesa # ${widget.mesaId}'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      // 💡 GridView.builder para la vista de dos columnas
      body: GridView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 💡 Dos columnas
          crossAxisSpacing: 12.0, // Espacio horizontal entre tarjetas
          mainAxisSpacing: 12.0, // Espacio vertical entre tarjetas
          childAspectRatio:
              0.7, // 💡 Relación de aspecto: Altura ligeramente mayor que la anchura
        ),
        itemBuilder: (context, index) {
          return _buildItemCard(_menuItems[index]);
        },
      ),

      // Botón Flotante: "Ver Carrito" (Sin cambios)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica para navegar a la pantalla del carrito
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Navegando a la pantalla del Carrito...'),
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('VER CARRITO'),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
