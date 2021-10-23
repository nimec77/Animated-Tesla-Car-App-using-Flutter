class TyrePsi {
  TyrePsi({required this.psi, required this.temp, required this.isLowPressure});

  final double psi;
  final int temp;
  final bool isLowPressure;

}

final List<TyrePsi> demoPsiList = [
  TyrePsi(psi: 23.6, temp: 56, isLowPressure: true),
  TyrePsi(psi: 35, temp: 41, isLowPressure: false),
  TyrePsi(psi: 34.6, temp: 41, isLowPressure: false),
  TyrePsi(psi: 34.8, temp: 42, isLowPressure: false),
];
