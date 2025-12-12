enum FlavorsEnum {
  bankingDev,
  bankingProd,
  restaurantDev,
  restaurantProd,
  fgtsAntecipationDev,
  fgtsAntecipationProd,
  formalizationDev,
  formalizationProd
}

class F {
  static FlavorsEnum? appFlavor;

  static String get title {
    return {
          FlavorsEnum.bankingDev: 'Zili Dev',
          FlavorsEnum.bankingProd: 'Zili',
          FlavorsEnum.restaurantDev: 'Restaurant Dev',
          FlavorsEnum.restaurantProd: 'Restaurant',
          FlavorsEnum.fgtsAntecipationDev: 'FGTS Antecipation Dev',
          FlavorsEnum.fgtsAntecipationProd: 'FGTS Antecipation',
          FlavorsEnum.formalizationDev: 'Zili Formalization Dev',
          FlavorsEnum.formalizationProd: 'Zili Formalization Prod',
        }[appFlavor] ??
        'Zili';
  }

  static bool get isProd {
    return {
          FlavorsEnum.bankingProd: true,
          FlavorsEnum.restaurantProd: true,
          FlavorsEnum.fgtsAntecipationProd: true,
          FlavorsEnum.formalizationProd: true,
        }[appFlavor] ??
        false;
  }

  static bool get isBanking {
    return {
          FlavorsEnum.bankingDev: true,
          FlavorsEnum.bankingProd: true,
        }[appFlavor] ??
        false;
  }
}
