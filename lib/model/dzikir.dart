class Dzikir {
  final String arab;
  final String latin;
  final String arti;
  final String audio; // Tambahkan field audio

  Dzikir({
    required this.arab,
    required this.latin,
    required this.arti,
    required this.audio, // Tambahkan parameter audio
  });

  factory Dzikir.fromJson(Map<String, dynamic> json) {
    return Dzikir(
      arab: json['arab'],
      latin: json['latin'],
      arti: json['arti'],
      audio: json['audio'], // Ambil audio dari json
    );
  }
}
