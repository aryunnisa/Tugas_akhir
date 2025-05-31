class Dzikir {
  final String arab;
  final String arti;

  Dzikir({
    required this.arab,
    required this.arti,
  });

  factory Dzikir.fromJson(Map<String, dynamic> json) {
    return Dzikir(
      arab: json['arab'],
      arti: json['arti'],
    );
  }
}
