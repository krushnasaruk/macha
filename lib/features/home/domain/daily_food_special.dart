/// Domain model representing daily featured food and beverages for CaféOS.
/// Changes dynamically according to the day of the week (Monday = 1, Sunday = 7).
class DailyFoodSpecial {
  final int weekday; // 1 = Monday, ..., 7 = Sunday
  final String dayName;
  final String title;
  final String tag;
  final String assetPath;
  final String description;

  const DailyFoodSpecial({
    required this.weekday,
    required this.dayName,
    required this.title,
    required this.tag,
    required this.assetPath,
    required this.description,
  });

  static const List<DailyFoodSpecial> allSpecials = [
    DailyFoodSpecial(
      weekday: DateTime.monday, // 1
      dayName: 'Monday',
      title: 'Artisanal Latte on Saucer',
      tag: 'Monday Kickstart ☕',
      assetPath: 'assets/food/food_day_1_monday.png',
      description: 'Velvety microfoam latte with rosetta art in ceramic cup on saucer.',
    ),
    DailyFoodSpecial(
      weekday: DateTime.tuesday, // 2
      dayName: 'Tuesday',
      title: 'Avocado Toast & Poached Egg',
      tag: 'Healthy Tuesday 🥑',
      assetPath: 'assets/food/food_day_2_tuesday.png',
      description: 'Rustic sourdough toast layered with creamy avocado, chili flakes and farm egg.',
    ),
    DailyFoodSpecial(
      weekday: DateTime.wednesday, // 3
      dayName: 'Wednesday',
      title: 'Belgian Waffles & Wild Berries',
      tag: 'Midweek Sweet 🧇',
      assetPath: 'assets/food/food_day_3_wednesday.png',
      description: 'Crisp golden Belgian waffles dusted with powdered sugar, fresh berries and syrup.',
    ),
    DailyFoodSpecial(
      weekday: DateTime.thursday, // 4
      dayName: 'Thursday',
      title: 'Iced Caramel Macchiato',
      tag: 'Thursday Chill 🥤',
      assetPath: 'assets/food/food_day_4_thursday.png',
      description: 'Layered cold brew, sweet milk and buttery caramel drizzle served over ice.',
    ),
    DailyFoodSpecial(
      weekday: DateTime.friday, // 5
      dayName: 'Friday',
      title: 'Gourmet Toasted Panini',
      tag: 'Friday Feast 🥪',
      assetPath: 'assets/food/food_day_5_friday.png',
      description: 'Toasted artisan sandwich with melted mozzarella, savory fillings and herbs.',
    ),
    DailyFoodSpecial(
      weekday: DateTime.saturday, // 6
      dayName: 'Saturday',
      title: 'Blueberry Pancake Stack',
      tag: 'Weekend Brunch 🥞',
      assetPath: 'assets/food/food_day_6_saturday.png',
      description: 'Triple fluffy buttermilk pancake stack with butter and bursting blueberries.',
    ),
    DailyFoodSpecial(
      weekday: DateTime.sunday, // 7
      dayName: 'Sunday',
      title: 'French Strawberry Tart',
      tag: 'Sunday Indulgence 🍓',
      assetPath: 'assets/food/food_day_7_sunday.png',
      description: 'Glazed fresh strawberries nestled in delicate vanilla custard and shortcrust pastry.',
    ),
  ];

  /// Resolves the special for a specific date or weekday.
  static DailyFoodSpecial forDate([DateTime? date]) {
    final target = date ?? DateTime.now();
    return forWeekday(target.weekday);
  }

  /// Resolves the special directly by weekday (1..7).
  static DailyFoodSpecial forWeekday(int weekday) {
    return allSpecials.firstWhere(
      (s) => s.weekday == weekday,
      orElse: () => allSpecials.first,
    );
  }
}
