import 'package:flutter_test/flutter_test.dart';
import 'package:cafe_os/features/home/domain/daily_food_special.dart';

void main() {
  group('DailyFoodSpecial Domain Tests', () {
    test('Resolves 7 unique specials for Monday through Sunday', () {
      expect(DailyFoodSpecial.allSpecials.length, 7);

      for (int i = 1; i <= 7; i++) {
        final special = DailyFoodSpecial.forWeekday(i);
        expect(special.weekday, i);
        expect(special.title.isNotEmpty, true);
        expect(special.assetPath, contains('food_day_$i'));
      }
    });

    test('forDate maps DateTime weekday correctly', () {
      // 2026-11-16 is Monday (weekday 1)
      final monday = DateTime(2026, 11, 16);
      expect(monday.weekday, DateTime.monday);
      expect(DailyFoodSpecial.forDate(monday).dayName, 'Monday');

      // 2026-11-21 is Saturday (weekday 6)
      final saturday = DateTime(2026, 11, 21);
      expect(saturday.weekday, DateTime.saturday);
      expect(DailyFoodSpecial.forDate(saturday).dayName, 'Saturday');

      // 2026-11-22 is Sunday (weekday 7)
      final sunday = DateTime(2026, 11, 22);
      expect(sunday.weekday, DateTime.sunday);
      expect(DailyFoodSpecial.forDate(sunday).dayName, 'Sunday');
    });
  });
}
