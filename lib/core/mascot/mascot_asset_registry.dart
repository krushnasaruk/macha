/// Centralized asset registry for Chef Barnaby mascot illustrations.
/// Replaces hardcoded file paths with type-safe enums and asset resolvers.
library;

enum MascotExpression {
  neutral('neutral.png'),
  slightSmile('slight_smile.png'),
  happy('happy.png'),
  veryExcited('very_excited.png'),
  laughing('laughing.png'),
  confused('confused.png'),
  surprised('surprised.png'),
  thinking('thinking.png'),
  sleepy('sleepy.png'),
  worried('worried.png'),
  proud('proud.png'),
  disappointed('disappointed.png'),
  embarrassed('embarrassed.png'),
  curious('curious.png'),
  determined('determined.png');

  final String filename;
  const MascotExpression(this.filename);

  String get path => 'assets/mascot/expressions/$filename';
}

enum MascotAction {
  holdingCoffeeCup('holding_coffee_cup.png'),
  holdingTray('holding_tray.png'),
  cookingPan('cooking_pan.png'),
  holdingSpatula('holding_spatula.png'),
  checkingRecipe('checking_recipe.png'),
  holdingMenu('holding_menu.png'),
  holdingReceipt('holding_receipt.png'),
  carryingCake('carrying_cake.png'),
  wearingOvenMitts('wearing_oven_mitts.png'),
  thumbsUp('thumbs_up.png'),
  armsCrossed('arms_crossed.png'),
  tastingFood('tasting_food.png'),
  holdingCoffeePot('holding_coffee_pot.png'),
  preparingOrder('preparing_order.png'),
  relaxingShift('relaxing_shift.png');

  final String filename;
  const MascotAction(this.filename);

  String get path => 'assets/mascot/chef_actions/$filename';
}

enum MascotInteraction {
  welcoming('welcoming.png'),
  wavingHello('waving_hello.png'),
  pointingInterface('pointing_interface.png'),
  explaining('explaining.png'),
  holdingChecklist('holding_checklist.png'),
  lookingDashboard('looking_dashboard.png'),
  typingLaptop('typing_laptop.png'),
  readingNotification('reading_notification.png'),
  waitingPatiently('waiting_patiently.png'),
  celebratingTask('celebrating_task.png'),
  highFive('high_five.png'),
  wavingGoodbye('waving_goodbye.png');

  final String filename;
  const MascotInteraction(this.filename);

  String get path => 'assets/mascot/app_interactions/$filename';
}

enum MascotStateIllustration {
  loadingPatiently('loading_patiently.png'),
  offlineConcerned('offline_concerned.png'),
  synchronizing('synchronizing.png'),
  errorWarning('error_warning.png'),
  holdingRetrySign('holding_retry_sign.png'),
  celebratingSuccess('celebrating_success.png'),
  emptyPlate('empty_plate.png'),
  lowInventoryWarning('low_inventory_warning.png'),
  sleepingIdle('sleeping_idle.png'),
  reactingNewOrder('reacting_new_order.png'),
  failedPrinter('failed_printer.png'),
  stockWarning('stock_warning.png');

  final String filename;
  const MascotStateIllustration(this.filename);

  String get path => 'assets/mascot/application_states/$filename';
}

enum MascotPose {
  standingRelaxed('standing_relaxed.png'),
  pointingLeft('pointing_left.png'),
  pointingRight('pointing_right.png'),
  celebrating('celebrating.png'),
  lookingCorner('looking_corner.png'),
  sleeping('sleeping.png');

  final String filename;
  const MascotPose(this.filename);

  String get path => 'assets/mascot/poses/$filename';
}

class MascotAssetRegistry {
  const MascotAssetRegistry._();

  static const String masterReference = 'assets/mascot/reference/master_character.png';
  static const String masterTransparent = 'assets/mascot/reference/master_character_transparent.png';
  static const String characterSheet = 'assets/mascot/reference/character_sheet.png';

  // Branding
  static const String logoPrimary = 'assets/branding/logo/cafeos_primary.svg';
  static const String logoIcon = 'assets/branding/logo/cafeos_icon.svg';
  static const String logoWordmark = 'assets/branding/logo/cafeos_wordmark.svg';
  static const String appIcon = 'assets/branding/logo/cafeos_app_icon.png';
  static const String logoLight = 'assets/branding/logo/cafeos_logo_light.svg';
  static const String logoDark = 'assets/branding/logo/cafeos_logo_dark.svg';

  // Pre-built scenes
  static const String welcomeScene = 'assets/mascot/onboarding/welcome_chef.png';
  static const String emptyMenuScene = 'assets/mascot/empty_states/empty_menu.png';
  static const String emptyOrdersScene = 'assets/mascot/empty_states/empty_orders.png';
  static const String celebrationScene = 'assets/mascot/celebrations/confetti_celebration.png';
}
