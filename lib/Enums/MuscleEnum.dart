abstract class MuscleEnum {
  static const TRICEPS = 'triceps';
  static const BICEPS = 'biceps';
  static const BACK = 'back';
  static const CHEST = 'chest';
  static const FOREARMS = 'forearms';
  static const CALVES = 'calves';
  static const QUADRICEPS = 'quadriceps';
  static const HAMSTRINGS = 'hamstrings';
  static const ABS = 'abs';

  static List<String> getUpperBody(){
    return [
      TRICEPS,
      BICEPS,
      BACK,
      CHEST,
      FOREARMS,
    ];
  }

  static List<String> getLowerBody(){
    return [
      CALVES,
      QUADRICEPS,
      HAMSTRINGS,
      ABS
    ];
  }

  static List<String> getAll(){
    return [
      ...getUpperBody(),
      ...getLowerBody(),
    ];
  }
}