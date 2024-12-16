import 'dart:io';
import 'dart:math';

class GlucosaCalculator {
  double resistenciaInsulina = 0.0;

  double calcularTyG(double trigliceridos, double glucosa) {
    return log(trigliceridos / 2) + log(glucosa / 2);
  }

  void guardarResistencia(double tyGIndex) {
    resistenciaInsulina = tyGIndex;
  }

  double calcularGlucosaFutura(
      double glucosaActual, double carbohidratosConsumidos) {
    double impactoCarbohidratos = carbohidratosConsumidos * 0.12;
    double reduccionPorInsulina = resistenciaInsulina * 1.5;
    return glucosaActual + impactoCarbohidratos - reduccionPorInsulina;
  }
}

void main() {
  // Crear una instancia del calculador
  GlucosaCalculator calc = GlucosaCalculator();

  // Solicitar datos de entrada al usuario
  print('Introduce los niveles de triglicéridos en mg/dL:');
  double trigliceridos = double.parse(stdin.readLineSync()!);

  print('Introduce los niveles de glucosa en ayunas en mg/dL:');
  double glucosaAyunas = double.parse(stdin.readLineSync()!);

  // Cálculo del índice TyG
  double tyGIndex = calc.calcularTyG(trigliceridos, glucosaAyunas);
  calc.guardarResistencia(tyGIndex);

  // Mostrar resultados iniciales
  print("\nCálculo del Índice TyG:");
  print("Triglicéridos: $trigliceridos mg/dL");
  print("Glucosa en ayunas: $glucosaAyunas mg/dL");
  print("Índice TyG calculado: ${tyGIndex.toStringAsFixed(2)}");

  // Comprobación de si el índice TyG está elevado
  if (tyGIndex > 4.5) {
    print(
        "El Índice TyG es elevado, lo que indica un posible riesgo de resistencia a la insulina o diabetes.");
  } else {
    print(
        "El Índice TyG es normal, lo que sugiere un menor riesgo de resistencia a la insulina.");
  }

  // Solicitar datos de glucosa actual y carbohidratos consumidos
  print('Introduce el nivel actual de glucosa en mg/dL:');
  double glucosaActual = double.parse(stdin.readLineSync()!);

  print('Introduce la cantidad de carbohidratos consumidos (en gramos):');
  double carbohidratosConsumidos = double.parse(stdin.readLineSync()!);

  // Cálculo de glucosa futura considerando resistencia y carbohidratos
  double glucosaFutura =
      calc.calcularGlucosaFutura(glucosaActual, carbohidratosConsumidos);

  // Mostrar resultados finales
  print("\nPredicción de Glucosa en 1 Hora:");
  print("Glucosa actual: $glucosaActual mg/dL");
  print("Carbohidratos consumidos: $carbohidratosConsumidos g");
  print(
      "Resistencia a la insulina: ${calc.resistenciaInsulina.toStringAsFixed(2)}");
  print(
      "Glucosa estimada en 1 hora: ${glucosaFutura.toStringAsFixed(2)} mg/dL");
}
