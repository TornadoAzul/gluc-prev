import 'package:gluc_prev/gluc_prev.dart';

void main() {
  // Crear una instancia del calculador
  GlucosaCalculator calc = GlucosaCalculator();

  // Datos de entrada iniciales (en mg/dL)
  double trigliceridos = 150.0; // Niveles de triglicéridos en ayunas
  double glucosaAyunas = 100.0; // Niveles de glucosa en ayunas

  // Cálculo del índice TyG
  double tyGIndex = calc.calcularTyG(trigliceridos, glucosaAyunas);
  calc.guardarResistencia(tyGIndex);

  // Mostrar resultados iniciales
  print("\nCálculo del Índice TyG:");
  print("Triglicéridos: \$trigliceridos mg/dL");
  print("Glucosa en ayunas: \$glucosaAyunas mg/dL");
  print("Índice TyG calculado: \$tyGIndex\n");

  // Comprobación de si el índice TyG está elevado
  if (tyGIndex > 4.5) {
    print(
        "El Índice TyG es elevado, lo que indica un posible riesgo de resistencia a la insulina o diabetes.");
  } else {
    print(
        "El Índice TyG es normal, lo que sugiere un menor riesgo de resistencia a la insulina.");
  }

  // Entrada de glucosa actual y carbohidratos consumidos
  double glucosaActual = 120.0; // Ejemplo: nivel actual de glucosa
  double carbohidratosConsumidos =
      50.0; // Ejemplo: carbohidratos consumidos (gramos)

  // Cálculo de glucosa futura considerando resistencia y carbohidratos
  calc.calcularGlucosaFutura(glucosaActual, carbohidratosConsumidos);

  // Mostrar resultados finales
  print("\nPredicción de Glucosa en 1 Hora:");
  print("Glucosa actual: \$glucosaActual mg/dL");
  print("Carbohidratos consumidos: \$carbohidratosConsumidos g");
  print("Resistencia a la insulina: \${calc.resistenciaInsulina}");
  print("Glucosa estimada en 1 hora: \$glucosaFutura mg/dL\n");
}
