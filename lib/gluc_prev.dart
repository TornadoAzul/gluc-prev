import 'dart:io';
import 'dart:math';

class GlucosaCalculator {
  // Constantes para ajustar los cálculos
  static const double FACTOR_CARBOHIDRATOS = 0.1;
  static const double FACTOR_RESISTENCIA = 1.0;
  static const double UMBRAL_TYG = 4.5;

  double _resistenciaInsulina = 0.0;

  double calcularTyG(double trigliceridos, double glucosa) {
    if (trigliceridos <= 0 || glucosa <= 0) {
      throw ArgumentError('Los valores deben ser positivos');
    }
    return log(trigliceridos / 2) + log(glucosa / 2);
  }

  void guardarResistencia(double tyGIndex) {
    _resistenciaInsulina = tyGIndex;
  }

  double get resistenciaInsulina => _resistenciaInsulina;

  double calcularGlucosaFutura(
      double glucosaActual, double carbohidratosConsumidos) {
    // Predicción más equilibrada
    double impactoCarbohidratos =
        carbohidratosConsumidos * FACTOR_CARBOHIDRATOS;
    double ajusteResistencia = _resistenciaInsulina * FACTOR_RESISTENCIA;

    return glucosaActual + impactoCarbohidratos - ajusteResistencia;
  }

  String interpretarTyG(double tyGIndex) {
    return tyGIndex > UMBRAL_TYG
        ? 'Riesgo elevado de resistencia a la insulina'
        : 'Riesgo normal de resistencia a la insulina';
  }
}

void main() {
  final calc = GlucosaCalculator();

  try {
    print('Introduce los niveles de triglicéridos en mg/dL:');
    final trigliceridos = double.parse(stdin.readLineSync()!);

    print('Introduce los niveles de glucosa en ayunas en mg/dL:');
    final glucosaAyunas = double.parse(stdin.readLineSync()!);

    final tyGIndex = calc.calcularTyG(trigliceridos, glucosaAyunas);
    calc.guardarResistencia(tyGIndex);

    print("\nCálculo del Índice TyG:");
    print("Triglicéridos: $trigliceridos mg/dL");
    print("Glucosa en ayunas: $glucosaAyunas mg/dL");
    print("Índice TyG calculado: ${tyGIndex.toStringAsFixed(2)}");
    print(calc.interpretarTyG(tyGIndex));

    print('Introduce el nivel actual de glucosa en mg/dL:');
    final glucosaActual = double.parse(stdin.readLineSync()!);

    print('Introduce la cantidad de carbohidratos consumidos (en gramos):');
    final carbohidratosConsumidos = double.parse(stdin.readLineSync()!);

    final glucosaFutura =
        calc.calcularGlucosaFutura(glucosaActual, carbohidratosConsumidos);

    print("\nPredicción de Glucosa en 1 Hora:");
    print("Glucosa actual: $glucosaActual mg/dL");
    print("Carbohidratos consumidos: $carbohidratosConsumidos g");
    print(
        "Resistencia a la insulina: ${calc.resistenciaInsulina.toStringAsFixed(2)}");
    print(
        "Glucosa estimada en 1 hora: ${glucosaFutura.toStringAsFixed(2)} mg/dL");
  } on FormatException {
    print('Error: Introduce valores numéricos válidos');
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }
}
