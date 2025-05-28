// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const DzikirApp());
}

class DzikirApp extends StatelessWidget {
  const DzikirApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dzikir Pagi & Petang',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 251, 202, 143), // Set background color here
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Move content to bottom
            children: [
              Image.asset(
                'assets/images/yaspat.png', // Replace with your image path
                height: 150,
              ),
              const SizedBox(height: 30),
              const Text(
                "Alma'tsurat Digital \n SMK Fatahillah Cileungsi",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.wb_sunny_outlined,
                    color: Color.fromARGB(255, 251, 202, 143)),
                label: const Text(
                  'Dzikir Sughro',
                  style: TextStyle(color: Color.fromARGB(255, 251, 202, 143)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DzikirSliderPage(
                        title: 'Dzikir Sughro',
                        dzikirList: dzikirPagi,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.brown,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Created by ARYUNNISA AULIA PUTRI',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0.5, left: 25.0, right: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/cwm.png',
              height: 130,
              width: 130,
            ),
            Image.asset(
              'assets/images/cwf.png',
              height: 120,
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}

class DzikirSliderPage extends StatefulWidget {
  final String title;
  final List<DzikirItem> dzikirList;

  const DzikirSliderPage(
      {Key? key, required this.title, required this.dzikirList})
      : super(key: key);

  @override
  State<DzikirSliderPage> createState() => _DzikirSliderPageState();
}

class _DzikirSliderPageState extends State<DzikirSliderPage> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 251, 202, 143), // Change background color here
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor:
            Color.fromARGB(255, 251, 202, 143), // Set AppBar color to cream
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.dzikirList.length,
            itemBuilder: (context, index) {
              final dzikir = widget.dzikirList[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    color: Color.fromARGB(
                        255, 255, 221, 171), // Set the box color to orange
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                dzikir.arabic,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Amiri',
                                    height: 2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              dzikir.translation,
                              textAlign:
                                  TextAlign.center, // Center align the text
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Play'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown,
                                    foregroundColor:
                                        Color.fromARGB(255, 251, 202, 143),
                                  ),
                                  onPressed: () async {
                                    await _audioPlayer
                                        .play(AssetSource(dzikir.audiopath));
                                  },
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.stop),
                                  label: const Text('Stop'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.brown,
                                    foregroundColor:
                                        Color.fromARGB(255, 251, 202, 143),
                                  ),
                                  onPressed: () async {
                                    await _audioPlayer.stop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        blurRadius: 48,
                        offset: Offset(0, 20),
                        spreadRadius: 8,
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/dzikir_logo.png',
                    height: 90,
                    width: 90,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Created by: ARYUNNISA AULIA PUTRI',
              style: TextStyle(
                fontSize: 10,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class DzikirItem {
  final String arabic;
  final String translation;
  final String audiopath;

  DzikirItem({
    required this.arabic,
    required this.translation,
    required this.audiopath,
  });
}

// Contoh isi Dzikir Pagi
final List<DzikirItem> dzikirPagi = [
  DzikirItem(
    arabic: 'أَعُوذُ بِاللَّهِ مِنْ الشَّيْطَانِ الرَّجِيمِ',
    translation:
        '“Aku berlindung kepada Allah dari godaan syaitan yang terkutuk.”',
    audiopath: 'audio/1.mp3',
  ),
  DzikirItem(
      arabic:
          "بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ (١) ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَـٰلَمِينَ (٢) ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ (٣) مَـٰلِكِ يَوْمِ ٱلدِّينِ (٤) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (٥) ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ (٦) صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ (٧)",
      translation:
          "Dengan nama Allah Yang Maha Pengasih, Maha Penyayang(١) \n Segala puji bagi Allah, Tuhan semesta alam(٢)  Yang Maha Pengasih, Maha Penyayang(٣)  Yang menguasai di Hari Pembalasan(٤)  Hanya Engkaulah yang kami sembah dan hanya kepada Engkaulah kami mohon pertolongan(٥)  \n Tunjukilah kami jalan yang lurus(٦)  yaitu jalan orang-orang yang telah Engkau beri nikmat, bukan jalan mereka yang dimurkai dan bukan pula jalan mereka yang sesat.(٧)  [Al-Fatihah/1: 1-7]",
      audiopath: "audio/2.mp3"),
  DzikirItem(
      arabic:
          "الٓمٓ (١) ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًۭى لِّلْمُتَّقِينَ (٢) ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَوٰةَ وَمِمَّا رَزَقْنَـٰهُمْ يُنفِقُونَ (٣) وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْـَٔاخِرَةِ هُمْ يُوقِنُونَ (٤) أُو۟لَـٰٓئِكَ عَلَىٰ هُدًۭى مِّن رَّبِّهِمْ ۖ وَأُو۟لَـٰٓئِكَ هُمُ ٱلْمُفْلِحُونَ (٥)",
      translation:
          " Alif Lām Mīm.(١) \n Kitab (Al-Qur`an) ini tidak ada keraguan padanya; petunjuk bagi mereka yang bertakwa(٢) \n (Yaitu) mereka yang beriman kepada yang gaib, melaksanakan salat, dan menginfakkan sebagian rezeki yang Kami berikan kepada mereka.(٣) \n Dan mereka yang beriman kepada (Al-Qur`an) yang diturunkan kepadamu (Muhammad) dan kitab-kitab yang diturunkan sebelum kamu, dan mereka yakin akan adanya (kehidupan) akhirat.(٤) Mereka itulah yang mendapat petunjuk dari Tuhannya, dan mereka itulah orang-orang yang beruntung.(٥)  Al-[Baqarah/2: 1-5]",
      audiopath: "audio/3.mp3"),
  DzikirItem(
    arabic:
        ' اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ، لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ، لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ، مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ، وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ، وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ، وَلَا يَئُودُهُ حِفْظُهُمَا، وَهُوَ الْعَلِيُّ الْعَظِيمُ',
    translation:
        'Allah tidak ada Ilah (yang berhak diibadahi) melainkan Dia Yang Hidup Kekal lagi terus menerus mengurus (makhluk-Nya); tidak mengantuk dan tidak tidur. Kepunyaan-Nya apa yang ada di langit dan di bumi. Tidak ada yang dapat memberi syafa’at di sisi Allah tanpa izin-Nya. Allah mengetahui apa-apa yang (berada) dihadapan mereka, dan dibelakang mereka dan mereka tidak mengetahui apa-apa dari Ilmu Allah melainkan apa yang dikehendaki-Nya. Kursi Allah meliputi langit dan bumi. Dan Allah tidak merasa berat memelihara keduanya, Allah Mahatinggi lagi Mahabesar. \n Al-[Baqarah/2: 255]',
    audiopath: 'audio/3.mp3',
  ),

  DzikirItem(
      arabic:
          "لَآ إِكۡرَاهَ فِي ٱلدِّينِۖ قَد تَّبَيَّنَ ٱلرُّشۡدُ مِنَ ٱلۡغَيِّۚ فَمَن يَكۡفُرۡ بِٱلطَّٰغُوتِ وَيُؤۡمِنۢ بِٱللَّهِ فَقَدِ ٱسۡتَمۡسَكَ بِٱلۡعُرۡوَةِ ٱلۡوُثۡقَىٰ لَا ٱنفِصَامَ لَهَاۗ وَٱللَّهُ سَمِيعٌ عَلِيمٌ",
      translation:
          "Tidak ada paksaan untuk (memasuki) agama (Islam); sesungguhnya telah jelas jalan yang benar daripada jalan yang sesat. Karena itu barang siapa yang ingkar kepada Thaghut dan beriman kepada Allah, maka sesungguhnya ia telah berpegang kepada buhu tali yang amat kuat yang tidak akan putus. Dan Allah Maha Mendengar lagi Maha Mengetahui.",
      audiopath: "audio/4.mp3"),
  // Tambah dzikir pagi lainnya di sini
  DzikirItem(
      arabic:
          "ٱللَّهُ وَلِيُّ ٱلَّذِينَ ءَامَنُواْ يُخۡرِجُهُم مِّنَ ٱلظُّلُمَٰتِ إِلَى ٱلنُّورِۖ وَٱلَّذِينَ كَفَرُوٓاْ أَوۡلِيَآؤُهُمُ ٱلطَّٰغُوتُ يُخۡرِجُونَهُم مِّنَ ٱلنُّورِ إِلَى ٱلظُّلُمَٰتِۗ أُوْلَٰٓئِكَ أَصۡحَٰبُ ٱلنَّارِۖ هُمۡ فِيهَا خَٰلِدُونَ",
      translation:
          "Allah Pelindung orang-orang yang beriman; Dia mengeluarkan mereka dari kegelapan (kekafiran) kepada cahaya (iman). Dan orang-orang yang kafir, pelindung-pelindungnya ialah setan, yang mengeluarkan mereka dari cahaya kepada kegelapan (kekafiran). Mereka itu adalah penghuni neraka; mereka kekal di dalamnya",
      audiopath: "audio/5.MP3"),
  DzikirItem(
      arabic:
          "لِّلَّهِ مَا فِي ٱلسَّمَٰوَٰتِ وَمَا فِي ٱلۡأَرۡضِۗ وَإِن تُبۡدُواْ مَا فِيٓ أَنفُسِكُمۡ أَوۡ تُخۡفُوهُ يُحَاسِبۡكُم بِهِ ٱللَّهُۖ فَيَغۡفِرُ لِمَن يَشَآءُ وَيُعَذِّبُ مَن يَشَآءُۗ وَٱللَّهُ عَلَىٰ كُلِّ شَيۡءٖ قَدِيرٌ",
      translation:
          "Kepunyaan Allah-lah segala apa yang ada di langit dan apa yang ada di bumi. Dan jika kamu melahirkan apa yang ada di dalam hatimu atau kamu menyembunyikannya, niscaya Allah akan membuat perhitungan dengan kamu tentang perbuatanmu itu. Maka Allah mengampuni siapa yang dikehendaki-Nya dan menyiksa siapa yang dikehendaki-Nya; dan Allah Maha Kuasa atas segala sesuatu",
      audiopath: "audio/6.MP3"),
  DzikirItem(
      arabic:
          "ءَامَنَ ٱلرَّسُولُ بِمَآ أُنزِلَ إِلَيۡهِ مِن رَّبِّهِۦ وَٱلۡمُؤۡمِنُونَۚ كُلٌّ ءَامَنَ بِٱللَّهِ وَمَلَٰٓئِكَتِهِۦ وَكُتُبِهِۦ وَرُسُلِهِۦ لَا نُفَرِّقُ بَيۡنَ أَحَدٖ مِّن رُّسُلِهِۦۚ وَقَالُواْ سَمِعۡنَا وَأَطَعۡنَاۖ غُفۡرَانَكَ رَبَّنَا وَإِلَيۡكَ ٱلۡمَصِيرُ",
      translation:
          "Rasul telah beriman kepada Al Qur'an yang diturunkan kepadanya dari Tuhannya, demikian pula orang-orang yang beriman. Semuanya beriman kepada Allah, malaikat-malaikat-Nya, kitab-kitab-Nya dan rasul-rasul-Nya. \n (Mereka mengatakan): 'Kami tidak membeda-bedakan antara seseorang pun (dengan yang lain) dari rasul rasul-Nya', dan mereka mengatakan: 'Kami dengar dan kami taat'. (Mereka berdoa):'Ampunilah kami ya Tuhan kami dan kepada Engkaulah tempat kembali'",
      audiopath: "audiopath/7.MP3"),
  DzikirItem(
      arabic:
          "لَا يُكَلِّفُ ٱللَّهُ نَفۡسًا إِلَّا وُسۡعَهَاۚ لَهَا مَا كَسَبَتۡ وَعَلَيۡهَا مَا ٱكۡتَسَبَتۡۗ رَبَّنَا لَا تُؤَاخِذۡنَآ إِن نَّسِينَآ أَوۡ أَخۡطَأۡنَاۚ رَبَّنَا وَلَا تَحۡمِلۡ عَلَيۡنَآ إِصۡرٗا كَمَا حَمَلۡتَهُۥ عَلَى ٱلَّذِينَ مِن قَبۡلِنَاۚ رَبَّنَا وَلَا تُحَمِّلۡنَا مَا لَا طَاقَةَ لَنَا بِهِۦۖ وَٱعۡفُ عَنَّا وَٱغۡفِرۡ لَنَا وَٱرۡحَمۡنَآۚ أَنتَ مَوۡلَىٰنَا فَٱنصُرۡنَا عَلَى ٱلۡقَوۡمِ ٱلۡكَٰفِرِينَ",
      translation:
          "Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya. Ia mendapat pahala (dari kebajikan) yang diusahakannya dan ia mendapat siksa (dari kejahatan) yang dikerjakannya. (Mereka berdo`a): 'Ya Tuhan kami, janganlah Engkau hukum kami jika kami lupa atau kami tersalah. Ya Tuhan kami, janganlah Engkau bebankan kepada kami beban yang berat sebagaimana Engkau bebankan kepada orang-orang yang sebelum kami. Ya Tuhan kami, janganlah Engkau pikulkan kepada kami apa yang tak sanggup kami memikulnya. Beri maaflah kami; ampunilah kami; dan rahmatilah kami. Engkaulah Penolong kami, maka tolonglah kami terhadap kaum yang kafir.'",
      audiopath: "audio/8.MP3"),
  DzikirItem(
    arabic:
        'قُلْ هُوَ اللّٰهُ اَحَدٌۚ (١) اَللّٰهُ الصَّمَدُۚ (٢) لَمْ يَلِدْ وَلَمْ يُوْلَدْۙ (٣) وَلَمْ يَكُنْ لَّهٗ كُفُوًا اَحَدٌ  (٤)',
    translation:
        'Katakanlah, Dia-lah Allah Yang Maha Esa. Allah adalah (Rabb) yang segala sesuatu bergantung kepada-Nya. Dia tidak beranak dan tidak pula diperanakkan. Dan tidak ada seorang pun yang setara dengan-Nya. \n [Al-Ikhlash/112: 1-4]. (Dibaca 3x)',
    audiopath: 'audio/9.mp3',
  ),

  DzikirItem(
    arabic:
        'قُلْ اَعُوْذُ بِرَبِّ الْفَلَقِۙ (١)مِنْ شَرِّ مَا خَلَقَۙ (٢)وَمِنْ شَرِّ غَاسِقٍ اِذَا وَقَبَۙ (٣)وَمِنْ شَرِّ النَّفّٰثٰتِ فِى الْعُقَدِۙ (٤)وَمِنْ شَرِّ حَاسِدٍ اِذَا حَسَدَ  (٥)',
    translation:
        'Katakanlah: ‘Aku berlindung kepada Rabb Yang menguasai (waktu) Shubuh dari kejahatan makhluk-Nya. Dan dari kejahatan malam apabila telah gelap gulita. Dan dari kejahatan wanita-wanita tukang sihir yang menghembus pada buhul-buhul. Serta dari kejahatan orang yang dengki apabila dia dengki. \n [Al-Falaq/113: 1-5]. (Dibaca 3x)',
    audiopath: 'audio/10.mp3',
  ),

  DzikirItem(
    arabic:
        ' قُلْ اَعُوْذُ بِرَبِّ النَّاسِۙ(١)مَلِكِ النَّاسِۙ(٢)اِلٰهِ النَّاسِۙ(٣)مِنْ شَرِّ الْوَسْوَاسِ ەۙ'
        'الْخَنَّاسِۖ(٤)الَّذِيْ يُوَسْوِسُ فِيْ صُدُوْرِ النَّاسِۙ(٥)مِنَ الْجِنَّةِ وَالنَّاسِ (٦ࣖ)',
    translation:
        'Katakanlah, ‘Aku berlindung kepada Rabb (yang memelihara dan menguasai) manusia. Raja manusia. Sembahan (Ilah) manusia. Dari kejahatan (bisikan) syaitan yang biasa bersembunyi. Yang membisikkan (kejahatan) ke dalam dada-dada manusia. Dari golongan jin dan manusia. \n [An-Naas/114: 1-6] (Dibaca 3x)',
    audiopath: 'audio/11.mp3',
  ),
//
  DzikirItem(
    arabic:
        'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيْرُ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِيْ هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا فِيْهَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوْذُ بِكَ مِنَ الْكَسَلِ وَسُوْءِ الْكِبَرِ، رَبِّ أَعُوْذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
    translation:
        'Kami telah memasuki waktu pagi dan kerajaan hanya milik Allah, segala puji hanya milik Allah. Tidak ada ilah yang berhak diibadahi dengan benar kecuali Allah Yang Maha Esa, tiada sekutu bagi-Nya. Bagi-Nya kerajaan dan bagi-Nya pujian. Dia-lah Yang Mahakuasa atas segala sesuatu. Wahai Rabb, aku mohon kepada-Mu kebaikan di hari ini dan kebaikan sesudahnya. Aku berlindung kepada-Mu dari kejahatan hari ini dan kejahatan sesudahnya. Wahai Rabb, aku berlindung kepada-Mu dari kemalasan dan kejelekan di hari tua. Wahai Rabb, aku berlindung kepada-Mu dari siksaan di Neraka dan siksaan di kubur.',
    audiopath: 'audio/12.mp3',
  ),
  DzikirItem(
    arabic:
        'أَصْبَحْنَا عَلَى فِطْرَةِ اْلإِسْلاَمِ وَعَلَى كَلِمَةِ اْلإِخْلاَصِ، وَعَلَى دِيْنِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيْمَ، حَنِيْفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِيْنَ',
    translation:
        'Di waktu pagi kami berada diatas fitrah agama Islam, kalimat ikhlas, agama Nabi kami Muhammad صلي الله عليه وسلم dan agama ayah kami, Ibrahim, yang berdiri di atas jalan yang lurus, muslim dan tidak tergolong orang-orang musyrik.',
    audiopath: 'audio/13.mp3',
  ),
  DzikirItem(
      arabic:
          "اللَّهُمَّ إِنِّي أَصْبَحْتُ مِنْكَ فِي نِعْمَةٍ وَعَافِيَةٍ وَسِتْر فَأَتِمَّ عَلَيَّ نِعْمَتَكَ وَعَافِيَتَكَ وَسِتْرَكَ فِي الدُّنْيَا وَالآخِرَة",
      translation:
          "Ya Allah, sesungguhnya aku berpagi hari dari-Mu dalam kenikmatan, kesehatan dan perlindungan. Maka sempurnakannlah untukku kenikmatan, kesehatan dan perlindungan-Mu itu di dunia dan akhirat.",
      audiopath: "audio/14.mp3"),
  DzikirItem(
      arabic:
          "اللَّهُمَّ مَا أَصْبَحَ بِيْ مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لاَ شَرِيْكَ لَكَ فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ",
      translation:
          "Ya Allah, segala nikmat yang aku rasakan di waktu pagi  ini, atau yang dirasakan oleh salah seorang dari makhluk-Mu, maka semuanya itu adalah dari-Mu semata, tidak ada sekutu bagi-Mu. Maka hanya bagi-Mu segala puji dan syukur.",
      audiopath: "audio/15.mp3"),
  DzikirItem(
      arabic:
          "يَا رَبِّي لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ وَلِعَظِيمِ سُلْطَانِكَ",
      translation:
          "Ya Tuhanku, Segala puji bagiMu sebagaimana seyogyanya kemuliaan wajahMu dan keagungan kekuasaanMu.",
      audiopath: "audio/16.MP3"),
  // DzikirItem(
  //     arabic: "arabic", translation: "translation", audiopath: "audiopath"),
  DzikirItem(
    arabic:
        'رَضِيْتُ بِاللهِ رَبًّا، وَبِاْلإِسْلاَمِ دِيْنًا، وَبِمُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا',
    translation:
        'Aku rela (ridha) Allah sebagai \n Rabb-ku (untukku dan orang lain), Islam sebagai agamaku dan Muhammad صلي الله عليه وسلم sebagai Nabiku (yang diutus oleh Allah).',
    audiopath: 'audio/17.mp3',
  ),

  DzikirItem(
    arabic:
        'سُبْحَانَ اللهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
    translation:
        'Mahasuci Allah, aku memuji-Nya sebanyak bilangan makhluk-Nya, Mahasuci Allah sesuai ke-ridhaan-Nya, Mahasuci seberat timbangan ‘Arsy-Nya, dan Mahasuci sebanyak tinta (yang menulis) kalimat-Nya. (Dibaca 3x)',
    audiopath: 'audio/18.MP3',
  ),

  DzikirItem(
    arabic:
        'بِسْمِ اللهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي اْلأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ',
    translation:
        'Dengan Menyebut Nama Allah, yang dengan Nama-Nya tidak ada satupun yang membahayakan, baik di bumi maupun dilangit. Dia-lah Yang Mahamendengar dan Maha mengetahui. (Dibaca 3x)',
    audiopath: 'audio/19.MP3',
  ),
  DzikirItem(
      arabic:
          "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُه",
      translation:
          "Ya Allah sesungguhnya kami berlindung kepadaMu dari menyekutukanMu dengan sesuatu yang kami ketahui, dan kami memohon ampunanMu dari apa-apa yang tidak kami ketahui.",
      audiopath: "audio/20.MP3"),
  DzikirItem(
      arabic:
          "اَللَّهُمَّ إِنِّي أَعُوْذُ بِكَ مِنَ الهَمِّ وَالْحَزَنِ وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالبُخْلِ وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ",
      translation:
          "Ya Allah, aku berlindung kepada-Mu dari rasa gelisah dan sedih, dari kelemahan dan kemalasan, dari sifat pengecut dan bakhil, dan dari lilitan hutang dan kesewenang-wenangan orang.",
      audiopath: "audio/21.MP3"),
  DzikirItem(
    arabic:
        'اَللَّهُمَّ عَافِنِيْ فِيْ بَدَنِيْ، اَللَّهُمَّ عَافِنِيْ فِيْ سَمْعِيْ، اَللَّهُمَّ عَافِنِيْ فِيْ بَصَرِيْ، لاَ إِلَـهَ إِلاَّ أَنْتَ. اَللَّهُمَّ إِنِّي أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لاَ إِلَـهَ إِلاَّ أَنْتَ',
    translation:
        'Ya Allah, selamatkanlah tubuhku (dari penyakit dan dari apa yang tidak aku inginkan). Ya Allah, selamatkanlah pendengaranku (dari penyakit dan maksiat atau dari apa yang tidak aku inginkan). Ya Allah, selamatkanlah penglihatanku, tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. Ya Allah, sesungguhnya aku berlindung kepada-Mu dari kekufuran dan kefakiran. Aku berlindung kepada-Mu dari siksa kubur, tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. (Dibaca 3x)',
    audiopath: 'audio/22.MP3',
  ),

  DzikirItem(
      arabic:
          "اَللَّهُمَّ إِنِّي أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِوَأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِلاَ إِلهَ إِلاَّ أَنْتَ",
      translation:
          "Ya Allah sungguh aku berlindung kepadaMu dari kekufuran dan kefaqiran, Ya Allah sungguh aku berlindung kepadaMu dari azab kubur, tidak ada Ilah kecuali Engkau.",
      audiopath: "audio/23.MP3"),
  DzikirItem(
    arabic:
        'اَللَّهُمَّ أَنْتَ رَبِّيْ لاَ إِلَـهَ إِلاَّ أَنْتَ، خَلَقْتَنِيْ وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوْذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوْءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوْءُ بِذَنْبِيْ فَاغْفِرْ لِيْ فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوْبَ إِلاَّ أَنْتَ',
    translation:
        'Ya Allah, Engkau adalah Rabb-ku, tidak ada Ilah (yang berhak diibadahi dengan benar) kecuali Engkau, Engkau-lah yang menciptakanku. Aku adalah hamba-Mu. Aku akan setia pada perjanjianku dengan-Mu semampuku. Aku berlindung kepada-Mu dari kejelekan (apa) yang kuperbuat. Aku mengakui nikmat-Mu (yang diberikan) kepadaku dan aku mengakui dosaku, oleh karena itu, ampunilah aku. Sesungguhnya tidak ada yang dapat mengampuni dosa kecuali Engkau. (Dibaca 1x)',
    audiopath: 'audio/24.mp3',
  ),
  DzikirItem(
    arabic:
        'أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ الَّذِي لَا إلهَ إِلَّا هُوَ الْحَيَّ الْقَيُّومَ وَأَتُوبُ إِلَيْهِ',
    translation:
        'Aku memohon ampunan Allah Yang Tiada Tuhan melainkan Dia, Yang Maha Hidup dan Maha Mengurus (makhluk-Nya).',
    audiopath: 'audio/25.mp3',
  ),
  DzikirItem(
    arabic:
        'اَللّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ كَمَا صَلَّــيْتَ عَـلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلَى آلِ سَيِّدِنَا إِبْـرَاهِيْمَ وبَارِكْ عَـلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِ سَيِّدِنَا مُحَمَّدٍ كَمَا بَارَكْتَ عَـلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَــلَى آلِ سَيـِّدِنَا إِبْـرَاهِيْمَ فِي الْعَالَمِيْنَ إِنَّكَ حَمِيْدٌ مَجِيْدٌ',
    translation:
        'Ya Allah berikanlah shalawat kepada Nabi Muhammad dan keluarga Nabi Muhammad, sebagaimana telah Engkau berikan kepada Nabi Ibrahim dan keluarga Nabi Ibrahim. Berikanlah barakah kepada Nabi Muhammad dan keluarga Nabi Muhammad, sebagaimana telah Engkau berikan kepada Nabi Ibrahim dan keluarga Nabi Ibrahim. Di alam Engkaulah Yang Maha Terpuji lagi Maha Mulia.',
    audiopath: 'audio/26.mp3',
  ),

  DzikirItem(
    arabic:
        'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَلَا إِلَهَ إِلَّا اللَّهُ وَاللَّهُ أَكْبَرُ',
    translation:
        'Mahasuci Allah, segala puji bagi Allah, tidak ada Ilah (yang berhak diibadahi dengan benar) kecuali Allah, dan Allah Maha Besar. (Dibaca 100x)',
    audiopath: 'audio/27.mp3',
  ),

  DzikirItem(
    arabic:
        'لاَ إلهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيْكَ لَهُ ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيْرٌ',
    translation:
        'Tiada Tuhan melainkan Allah semata, yang tiada sekutu bagi-Nya, bagi-Nya kerajaan dan bagi-Nya segala puji, dan Dia berkuasa ata segala sesuatu.',
    audiopath: 'audio/28.mp3',
  ),

  DzikirItem(
    arabic:
        "سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ أَشْهَدُ أَنْ لَّا إلهَ إِلَّا أَنْتَ أَسْتَغْفِرُكَ وَأَتُوْبُ إِلَيْكَ",
    translation:
        "Maha suci Engkau ya Allah, dan segala puji bagi-Mu. Aku bersaksi bahwa tiada Tuhan melainkan Engkau, aku memohon ampunan dan bertaubat kepada-Mu",
    audiopath: "audio/29.mp3",
  ),
  DzikirItem(
      arabic:
          "اَللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ عَبْدِكَ وَرَسُوْلِكَ النَّبِيِّ الأُمِّيِّ وَعَلَى آلِهِ وَصَحْبِهِ وَسَلِّمْ تَسْلِيْمًا عَدَدَ مَا أَحَاطَ بِهِ عِلْمُكَ وَخَطَّ بِهِ قَلَمُكَ وَأَحْصَاهُ كِتَابُكَ، وَارْضَ اللَّهُمَّ عَنْ سَادَاتِنَا أَبِيْ بَكْرٍ وَعُمَرَ وَعُثْمَانَ وَعَلِيْ، وَعَنِ الصَّحَابَةِ أَجْمَعِيْنَ، وَعَنِ التَّابِعِيْنَ وَتَابِعِيْهِمْ بِإِحْسَانٍ إِلَى يَوْمِ الدِّيْن سُبْحَانَ رَبِّك رَبِّ العِزَّةِ عَمَّا يَصِفُوْنَ، وَسَلَامٌ عَلَى المُرْسَلِيْنَ، وَالحَمْدُ لِلَّهِ رَبِّ العَالَمِيْنَ",
      translation:
          "Ya Allah berikanlah shalawat kepada Nabi Muhammad; hamba-Mu, nabi-Mu, dan Rasul-Mu; Nabi yang ummi. Juga kepada keluarga dan para sahabatnya serta berilah keselamatan sebanyak yang terjangkau oleh ilmu-Mu yang tergores oleh pena-Mu, dan yang terangkum oleh kitab-Mu. Ridhailah ya Allah para pemimpin kami, Abu Bakar, Umar, Utsman, dan Ali, semua sahabat, semua tabi’in dan orang-orang yang mengikuti mereka sampai hari pembalasan. Maha suci Tuhanmu; Tuhan kemuliaan, dari apa-apa yang mereka sifatkan. Keselamatan semoga tercurah kepada para utusan dan segala puji bagi Allah, Tuhan semesta alam.",
      audiopath: "audio/30.mp3"),

  DzikirItem(
      arabic:
          "قُلِ ٱللَّهُمَّ مَٰلِكَ ٱلۡمُلۡكِ تُؤۡتِي ٱلۡمُلۡكَ مَن تَشَآءُ وَتَنزِعُ ٱلۡمُلۡكَ مِمَّن تَشَآءُ وَتُعِزُّ مَن تَشَآءُ وَتُذِلُّ مَن تَشَآءُۖ بِيَدِكَ ٱلۡخَيۡرُۖ إِنَّكَ عَلَىٰ كُلِّ شَيۡءٖ قَدِيرٞ",
      translation:
          "Katakanlah: 'Wahai Tuhan Yang mempunyai kerajaan, Engkau berikan kerajaan kepada orang yang Engkau kehendaki dan Engkau cabut kerajaan dari orang yang Engkau kehendaki. Engkau muliakan orang yang Engkau kehendaki dan Engkau hinakan orang yang Engkau kehendaki. Di tangan Engkaulah segala kebajikan.Sesungguhnya Engkau Maha Kuasa atas segala sesuatu.'",
      audiopath: "audio/31.mp3"),
  DzikirItem(
      arabic:
          "تُولِجُ ٱلَّيۡلَ فِي ٱلنَّهَارِ وَتُولِجُ ٱلنَّهَارَ فِي ٱلَّيۡلِۖ وَتُخۡرِجُ ٱلۡحَيَّ مِنَ ٱلۡمَيِّتِ وَتُخۡرِجُ ٱلۡمَيِّتَ مِنَ ٱلۡحَيِّۖ وَتَرۡزُقُ مَن تَشَآءُ بِغَيۡرِ حِسَابٖ",
      translation:
          "Engkau masukkan malam ke dalam siang dan Engkau masukkan siang ke dalam malam. Engkau keluarkan yang hidup dari yang mati, dan Engkau keluarkan yang mati dari yang hidup. Dan Engkau beri rezeki siapa yang Engkau kehendaki tanpa hisab (batas)",
      audiopath: "audio/32.mp3"),
  DzikirItem(
      arabic:
          "اَللَّهُمَّ إِنَّ هَذَا إِقْبَالُ نَهَارِكَ (لَيْلِكَ) وَإِدْبَارُ لَيْلِكَ (نَهَارِكَ) وَأَصْوَاتُ دُعَاتِكَ فَاغْفِرْلِي",
      translation:
          "Ya Allah, sesungguhnya ini adalah siang-Mu (malam-Mu) yang telah menjelang dan (malam-Mu) siang-Mu yang tengah berlalu serta suara-suara penyeru-Mu, maka ampunilah aku.",
      audiopath: "audio/33.mp3"),

  DzikirItem(
    arabic:
        "اَللّهُمَّ إِنَّكَ تَعْلَمُ أَنَّ هَذِهِ الْقُلُوْبَ، قَدِ اجْتَمَعَتْ عَلَى مَحَبَّتِكَ وَالْتَقَتْ عَلَى طَاعَتِكَ، وَتَوَحَّدَتْ عَلَى دَعْوَتِكَ وَتَعَاهَدَتْ عَلَى نُصْرَةِ شَرِيْعَتِكَ فَوَثِّقِ اللَّهُمَّ رَابِطَتَهَا، وَأَدِمْ وُدَّهَا، وَاهْدِهَا سُبُلَهَا وَامْلَأَهَا بِنُوْرِكَ الَّذِيْ لاَ يَخْبُوْا وَاشْرَحْ صُدُوْرَهَا بِفَيْضِ الْإِيْمَانِ بِكَ، وَجَمِيْلِ التَّوَكُّلِ عَلَيْكَ وَاَحْيِهَا بِمَعْرِفَتِكَ، وَأَمِتْهَا عَلَى الشَّهَادَةِ فِي سَبِيْلِكَ إِنَّكَ نِعْمَ الْمَوْلَى وَنِعْمَ النَّصِيْرِ. اَللَّهُمَّ أَمِيْنَ. وَصَلِّ اللَّهُمَّ عَلَى سَيِّدَنَا مُحَمَّدٍ وَعَلَى آلِهِ وَصَحْبِهِ وَسَلِّمَ.",
    translation:
        "Ya Allah, sesungguhnya Engkau Maha Mengetahui bahawa hati-hati ini, telah berhimpun di atas dasar kecintaan terhadapmu, bertemu di atas ketaatan kepada-Mu dan bersatu bagi memikul beban dakwah-Mu, hati-hati ini telah mengikat persetiaan untuk menolong meninggikan syariat-Mu. Oleh itu, Ya Allah, Engkau perkukuhkan ikatannya dan Engkau kekalkan kemesraan hati-hati ini, tunjukilah hati-hati ini akan jalan yang sebenar,  serta penuhkanlah (piala) hati-hati ini dengan cahaya Rabbani-Mu yang tidak kunjung redup, lapangkanlah hati-hati dengan limpahan keimanan serta keindahan tawakkal kepada-Mu, hidup suburkanlah hati-hati ini dengan makrifat (pengenalan yang sebenarnya) tentang-Mu.  (Jika Engkau takdirkan kami mati) maka matikanlah hati-hati ini sebagai para syuhada dalam perjuangan agama-Mu. Sesungguhnya Engkau sebaik-baik pelindung dan sebaik-baik penolong.  Ya Allah perkenankanlah doa kami. Dan semoga shalawat serta salam selalu tercurah kepada Nabi Muhammad, keluarganya dan kepada semua sahabatnya.",
    audiopath: "audio/34.mp3",
  ),
];
