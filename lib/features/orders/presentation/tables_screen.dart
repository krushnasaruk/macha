import 'package:flutter/material.dart';
import '../../../core/components/app_card.dart';
import '../../../core/theme/app_spacing.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dining Tables'),
      ),
      body: GridView.builder(
        padding: AppSpacing.paddingLg,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          final tableNum = index + 1;
          final isOccupied = tableNum % 3 == 0;

          return AppCard(
            isSelected: isOccupied,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.table_restaurant_rounded,
                  size: 32,
                  color: isOccupied ? Colors.amber[800] : Colors.green[700],
                ),
                const SizedBox(height: 8),
                Text(
                  'Table $tableNum',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  isOccupied ? 'Occupied (2 items)' : 'Available (4 seats)',
                  style: TextStyle(
                    fontSize: 11,
                    color: isOccupied ? Colors.amber[800] : Colors.green[700],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
