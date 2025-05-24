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
      title: 'Dzikir Pagi & Petang',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 249, 219, 183), // Set background color here
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Move content to bottom
            children: [
              Image.asset(
                'assets/images/dzikir_logo.png', // Replace with your image path
                height: 250,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.wb_sunny_outlined, color: Colors.brown),
                label: const Text(
                  'Dzikir Pagi',
                  style: TextStyle(color: Colors.brown),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DzikirSliderPage(
                        title: 'Dzikir Pagi',
                        dzikirList: dzikirPagi,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromARGB(255, 226, 168, 82),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon:
                    const Icon(Icons.nightlight_outlined, color: Colors.brown),
                label: const Text(
                  'Dzikir Petang',
                  style: TextStyle(color: Colors.brown),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: const Color.fromARGB(255, 226, 168, 82),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DzikirSliderPage(
                        title: 'Dzikir Petang',
                        dzikirList: dzikirPetang,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 24.0, right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/cwm.png',
              height: 120,
              width: 120,
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
      backgroundColor: const Color(0xFFFFE4C4), // Change background color here
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFFFFE4C4), // Set AppBar color to cream
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
                    color: const Color.fromARGB(
                        255, 230, 183, 113), // Set the box color to orange
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              dzikir.arabic,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Amiri', height: 2),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              dzikir.translation,
                              textAlign:
                                  TextAlign.center, // Center align the text
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 82, 48, 4)),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Play'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 150, 105, 0),
                                    foregroundColor: const Color(0xFFFFE4C4),
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
                                    foregroundColor: const Color(0xFFFFE4C4),
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
          Positioned(
            bottom: 10,
            left: 10,
            child: Image.asset(
              'assets/images/left_icon.png', // Replace with your left image path
              height: 80, // Increased the height
              width: 80, // Increased the width
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Image.asset(
              'assets/images/right_icon.png', // Replace with your right image path
              height: 80, // Increased the height
              width: 80, // Increased the width
            ),
          ),
        ],
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
    arabic:
        'أَعُوذُ بِاللَّهِ مِنْ الشَّيْطَانِ الرَّجِيمِ\nبِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
    translation:
        '“Aku berlindung kepada Allah dari godaan syaitan yang terkutuk.”'
        '“Dengan menyebut nama Allah, Yang Maha Pengasih lagi Maha Penyayang.”',
    audiopath: 'audio/1.mp3',
  ),
  DzikirItem(
    arabic:
        ' اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ، لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ، لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ، مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ، وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ، وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ، وَلَا يَئُودُهُ حِفْظُهُمَا، وَهُوَ الْعَلِيُّ الْعَظِيمُ',
    translation:
        'Allah tidak ada Ilah (yang berhak diibadahi) melainkan Dia Yang Hidup Kekal lagi terus menerus mengurus (makhluk-Nya); tidak mengantuk dan tidak tidur. Kepunyaan-Nya apa yang ada di langit dan di bumi. Tidak ada yang dapat memberi syafa’at di sisi Allah tanpa izin-Nya. Allah mengetahui apa-apa yang (berada) dihadapan mereka, dan dibelakang mereka dan mereka tidak mengetahui apa-apa dari Ilmu Allah melainkan apa yang dikehendaki-Nya. Kursi Allah meliputi langit dan bumi. Dan Allah tidak merasa berat memelihara keduanya, Allah Mahatinggi lagi Mahabesar. Al-[Baqarah/2: 255] (Dibaca 1x)',
    audiopath: 'audio/2.mp3',
  ),
  // Tambah dzikir pagi lainnya di sini
  DzikirItem(
    arabic:
        'قُلْ هُوَ اللَّهُ أَحَدٌ \n اللَّهُ الصَّمَدُ \n لَمْ يَلِدْ وَلَمْ يُولَدْ \n وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
    translation:
        'Katakanlah, Dia-lah Allah Yang Maha Esa. Allah adalah (Rabb) yang segala sesuatu bergantung kepada-Nya. Dia tidak beranak dan tidak pula diperanakkan. Dan tidak ada seorang pun yang setara dengan-Nya. [Al-Ikhlash/112: 1-4]. (Dibaca 3x)',
    audiopath: 'audio/3.mp3',
  ),

  DzikirItem(
    arabic:
        'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ\n مِن شَرِّ مَا خَلَقَ \n وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ \n وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ \n وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
    translation:
        'Katakanlah: ‘Aku berlindung kepada Rabb Yang menguasai (waktu) Shubuh dari kejahatan makhluk-Nya. Dan dari kejahatan malam apabila telah gelap gulita. Dan dari kejahatan wanita-wanita tukang sihir yang menghembus pada buhul-buhul. Serta dari kejahatan orang yang dengki apabila dia dengki. [Al-Falaq/113: 1-5]. (Dibaca 3x)',
    audiopath: 'audio/4.mp3',
  ),

  DzikirItem(
    arabic:
        'قُلْ أَعُوذُ بِرَبِّ النَّاسِ \n مَلِكِ النَّاسِ \n إِلَهِ النَّاسِ \n مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ \n الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ \n مِنَ الْجِنَّةِ وَ النَّاسِ',
    translation:
        'Katakanlah, ‘Aku berlindung kepada Rabb (yang memelihara dan menguasai) manusia. Raja manusia. Sembahan (Ilah) manusia. Dari kejahatan (bisikan) syaitan yang biasa bersembunyi. Yang membisikkan (kejahatan) ke dalam dada-dada manusia. Dari golongan jin dan manusia. [An-Naas/114: 1-6] (Dibaca 3x)',
    audiopath: 'audio/5.mp3',
  ),

  DzikirItem(
    arabic:
        'أَصْبَحْنَا عَلَى فِطْرَةِ اْلإِسْلاَمِ وَعَلَى كَلِمَةِ اْلإِخْلاَصِ، وَعَلَى دِيْنِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيْمَ، حَنِيْفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِيْنَ',
    translation:
        'Di waktu pagi kami berada diatas fitrah agama Islam, kalimat ikhlas, agama Nabi kami Muhammad صلي الله عليه وسلم dan agama ayah kami, Ibrahim, yang berdiri di atas jalan yang lurus, muslim dan tidak tergolong orang-orang musyrik. (Dibaca 1x)',
    audiopath: 'audio/6.mp3',
  ),

  DzikirItem(
    arabic:
        'رَضِيْتُ بِاللهِ رَبًّا، وَبِاْلإِسْلاَمِ دِيْنًا، وَبِمُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا',
    translation:
        'Aku rela (ridha) Allah sebagai Rabb-ku (untukku dan orang lain), Islam sebagai agamaku dan Muhammad صلي الله عليه وسلم sebagai Nabiku (yang diutus oleh Allah). (Dibaca 3x)...',
    audiopath: 'audio/7.mp3',
  ),

  DzikirItem(
    arabic:
        'اَللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوْتُ وَإِلَيْكَ النُّشُوْرُ',
    translation:
        'Ya Allah, dengan rahmat dan pertolongan-Mu kami memasuki waktu pagi, dan dengan rahmat dan pertolongan-Mu kami memasuki waktu sore. Dengan rahmat dan kehendak-Mu kami hidup dan dengan rahmat dan kehendak-Mu kami mati. Dan kepada-Mu kebangkitan (bagi semua makhluk). (Dibaca 1x)',
    audiopath: 'audio/8.mp3',
  ),

  DzikirItem(
    arabic:
        'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَـهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيْرُ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِيْ هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا فِيْهَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوْذُ بِكَ مِنَ الْكَسَلِ وَسُوْءِ الْكِبَرِ، رَبِّ أَعُوْذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
    translation:
        'Kami telah memasuki waktu pagi dan kerajaan hanya milik Allah, segala puji hanya milik Allah. Tidak ada ilah yang berhak diibadahi dengan benar kecuali Allah Yang Maha Esa, tiada sekutu bagi-Nya. Bagi-Nya kerajaan dan bagi-Nya pujian. Dia-lah Yang Mahakuasa atas segala sesuatu. Wahai Rabb, aku mohon kepada-Mu kebaikan di hari ini dan kebaikan sesudahnya. Aku berlindung kepada-Mu dari kejahatan hari ini dan kejahatan sesudahnya. Wahai Rabb, aku berlindung kepada-Mu dari kemalasan dan kejelekan di hari tua. Wahai Rabb, aku berlindung kepada-Mu dari siksaan di Neraka dan siksaan di kubur.    (Dibaca 1x)',
    audiopath: 'audio/9.mp3',
  ),

  DzikirItem(
    arabic:
        'اَللَّهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَاْلآخِرَةِ، اَللَّهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ اللَّهُمَّ اسْتُرْ عَوْرَاتِى وَآمِنْ رَوْعَاتِى. اَللَّهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ، وَمِنْ خَلْفِيْ، وَعَنْ يَمِيْنِيْ وَعَنْ شِمَالِيْ، وَمِنْ فَوْقِيْ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
    translation:
        'Ya Allah, sesungguhnya aku memohon kebajikan dan keselamatan di dunia dan akhirat. Ya Allah, sesungguhnya aku memohon kebajikan dan keselamatan dalam agama, dunia, keluarga dan hartaku. Ya Allah, tutupilah auratku (aib dan sesuatu yang tidak layak dilihat orang) dan tentramkan-lah aku dari rasa takut. Ya Allah, peliharalah aku dari depan, belakang, kanan, kiri dan dari atasku. Aku berlindung dengan kebesaran-Mu, agar aku tidak disambar dari bawahku (aku berlindung dari dibenamkan ke dalam bumi). (Dibaca 1x)',
    audiopath: 'audio/10.mp3',
  ),

  DzikirItem(
    arabic:
        'اَللَّهُمَّ أَنْتَ رَبِّيْ لاَ إِلَـهَ إِلاَّ أَنْتَ، خَلَقْتَنِيْ وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوْذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوْءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوْءُ بِذَنْبِيْ فَاغْفِرْ لِيْ فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوْبَ إِلاَّ أَنْتَ',
    translation:
        'Ya Allah, Engkau adalah Rabb-ku, tidak ada Ilah (yang berhak diibadahi dengan benar) kecuali Engkau, Engkau-lah yang menciptakanku. Aku adalah hamba-Mu. Aku akan setia pada perjanjianku dengan-Mu semampuku. Aku berlindung kepada-Mu dari kejelekan (apa) yang kuperbuat. Aku mengakui nikmat-Mu (yang diberikan) kepadaku dan aku mengakui dosaku, oleh karena itu, ampunilah aku. Sesungguhnya tidak ada yang dapat mengampuni dosa kecuali Engkau. (Dibaca 1x)',
    audiopath: 'audio/11.mp3',
  ),

  DzikirItem(
    arabic:
        'اَللَّهُمَّ عَافِنِيْ فِيْ بَدَنِيْ، اَللَّهُمَّ عَافِنِيْ فِيْ سَمْعِيْ، اَللَّهُمَّ عَافِنِيْ فِيْ بَصَرِيْ، لاَ إِلَـهَ إِلاَّ أَنْتَ. اَللَّهُمَّ إِنِّي أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لاَ إِلَـهَ إِلاَّ أَنْتَ',
    translation:
        'Ya Allah, selamatkanlah tubuhku (dari penyakit dan dari apa yang tidak aku inginkan). Ya Allah, selamatkanlah pendengaranku (dari penyakit dan maksiat atau dari apa yang tidak aku inginkan). Ya Allah, selamatkanlah penglihatanku, tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. Ya Allah, sesungguhnya aku berlindung kepada-Mu dari kekufuran dan kefakiran. Aku berlindung kepada-Mu dari siksa kubur, tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. (Dibaca 3x)',
    audiopath: 'audio/12.MP3',
  ),
  DzikirItem(
    arabic:
        'اَللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَاْلأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيْكَهُ، أَشْهَدُ أَنْ لاَ إِلَـهَ إِلاَّ أَنْتَ، أَعُوْذُ بِكَ مِنْ شَرِّ نَفْسِيْ، وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِيْ سُوْءًا أَوْ أَجُرُّهُ إِلَى مُسْلِمٍ',
    translation:
        'Ya Allah Yang Maha mengetahui yang ghaib dan yang nyata, wahai Rabb Pencipta langit dan bumi, Rabb atas segala sesuatu dan Yang Merajainya. Aku bersaksi bahwa tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. Aku berlindung kepada-Mu dari kejahatan diriku, syaitan dan ajakannya menyekutukan Allah (aku berlindung kepada-Mu) dari berbuat kejelekan atas diriku atau mendorong seorang muslim kepadanya. (Dibaca 1x)',
    audiopath: 'audio/13.MP3',
  ),
  DzikirItem(
    arabic:
        'بِسْمِ اللهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي اْلأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ',
    translation:
        'Dengan Menyebut Nama Allah, yang dengan Nama-Nya tidak ada satupun yang membahayakan, baik di bumi maupun dilangit. Dia-lah Yang Mahamendengar dan Maha mengetahui. (Dibaca 3x)',
    audiopath: 'audio/14.MP3',
  ),
  DzikirItem(
    arabic:
        'يَا حَيُّ يَا قَيُّوْمُ بِرَحْمَتِكَ أَسْتَغِيْثُ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ وَلاَ تَكِلْنِيْ إِلَى نَفْسِيْ طَرْفَةَ عَيْنٍ',
    translation:
        'Wahai Rabb Yang Maha hidup, Wahai Rabb Yang Maha berdiri sendiri (tidak butuh segala sesuatu) dengan rahmat-Mu aku meminta pertolongan, perbaikilah segala urusanku dan jangan diserahkan (urusanku) kepada diriku sendiri meskipun hanya sekejap mata (tanpa mendapat pertolongan dari-Mu). (Dibaca 1x)...',
    audiopath: 'audio/15.MP3',
  ),
  DzikirItem(
    arabic:
        'سُبْحَانَ اللهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
    translation:
        'Mahasuci Allah, aku memuji-Nya sebanyak bilangan makhluk-Nya, Mahasuci Allah sesuai ke-ridhaan-Nya, Mahasuci seberat timbangan ‘Arsy-Nya, dan Mahasuci sebanyak tinta (yang menulis) kalimat-Nya. (Dibaca 3x)',
    audiopath: 'audio/16.MP3',
  ),
  DzikirItem(
    arabic: 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
    translation:
        '“Mahasuci Allah, aku memuji-Nya.” (Dibaca pagi 10x atau 100x)',
    audiopath: 'audio/17.MP3',
  ),

  DzikirItem(
    arabic:
        'سُبْحَانَ اللهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
    translation:
        'Mahasuci Allah, aku memuji-Nya sebanyak bilangan makhluk-Nya, Mahasuci Allah sesuai ke-ridhaan-Nya, Mahasuci seberat timbangan ‘Arsy-Nya, dan Mahasuci sebanyak tinta (yang menulis) kalimat-Nya. (Dibaca 3x)',
    audiopath: 'audio/16.MP3',
  ),

  DzikirItem(
    arabic: 'أَسْتَغْفِرُ اللهَ وَأَتُوْبُ إِلَيْهِ',
    translation:
        '“Aku memohon ampunan kepada Allah dan bertaubat kepada-Nya.” (Dibaca setiap hari 10x atau 100x)',
    audiopath: 'audio/19.MP3',
  ),
];

// Contoh isi Dzikir Petang
final List<DzikirItem> dzikirPetang = [
  DzikirItem(
    arabic:
        'أَعُوذُ بِاللَّهِ مِنْ الشَّيْطَانِ الرَّجِيمِ\nبِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
    translation:
        '“Aku berlindung kepada Allah dari godaan syaitan yang terkutuk.”'
        '“Dengan menyebut nama Allah, Yang Maha Pengasih lagi Maha Penyayang.”',
    audiopath: 'audio/1.mp3',
  ),
  DzikirItem(
    arabic:
        ' اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ، لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ، لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ، مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ، وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلاَّ بِمَا شَاءَ، وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ، وَلَا يَئُودُهُ حِفْظُهُمَا، وَهُوَ الْعَلِيُّ الْعَظِيمُ',
    translation:
        'Allah tidak ada Ilah (yang berhak diibadahi) melainkan Dia Yang Hidup Kekal lagi terus menerus mengurus (makhluk-Nya); tidak mengantuk dan tidak tidur. Kepunyaan-Nya apa yang ada di langit dan di bumi. Tidak ada yang dapat memberi syafa’at di sisi Allah tanpa izin-Nya. Allah mengetahui apa-apa yang (berada) dihadapan mereka, dan dibelakang mereka dan mereka tidak mengetahui apa-apa dari Ilmu Allah melainkan apa yang dikehendaki-Nya. Kursi Allah meliputi langit dan bumi. Dan Allah tidak merasa berat memelihara keduanya, Allah Mahatinggi lagi Mahabesar. \n Al-[Baqarah/2: 255] (Dibaca 1x)',
    audiopath: 'audio/2.mp3',
  ),
  // Tambah dzikir pagi lainnya di sini
  DzikirItem(
    arabic:
        'قُلْ هُوَ اللَّهُ أَحَدٌ \n اللَّهُ الصَّمَدُ \n لَمْ يَلِدْ وَلَمْ يُولَدْ \n وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
    translation:
        'Katakanlah, Dia-lah Allah Yang Maha Esa. Allah adalah (Rabb) yang segala sesuatu bergantung kepada-Nya. Dia tidak beranak dan tidak pula diperanakkan. Dan tidak ada seorang pun yang setara dengan-Nya. [Al-Ikhlash/112: 1-4]. (Dibaca 3x)',
    audiopath: 'audio/3.mp3',
  ),

  DzikirItem(
    arabic:
        'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ\n مِن شَرِّ مَا خَلَقَ \n وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ \n وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ \n وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
    translation:
        'Katakanlah: ‘Aku berlindung kepada Rabb Yang menguasai (waktu) Shubuh dari kejahatan makhluk-Nya. Dan dari kejahatan malam apabila telah gelap gulita. Dan dari kejahatan wanita-wanita tukang sihir yang menghembus pada buhul-buhul. Serta dari kejahatan orang yang dengki apabila dia dengki. [Al-Falaq/113: 1-5]. (Dibaca 3x)',
    audiopath: 'audio/4.mp3',
  ),

  DzikirItem(
    arabic:
        'قُلْ أَعُوذُ بِرَبِّ النَّاسِ \n مَلِكِ النَّاسِ \n إِلَهِ النَّاسِ \n مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ \n الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ \n مِنَ الْجِنَّةِ وَ النَّاسِ',
    translation:
        'Katakanlah, ‘Aku berlindung kepada Rabb (yang memelihara dan menguasai) manusia. Raja manusia. Sembahan (Ilah) manusia. Dari kejahatan (bisikan) syaitan yang biasa bersembunyi. Yang membisikkan (kejahatan) ke dalam dada-dada manusia. Dari golongan jin dan manusia. [An-Naas/114: 1-6] (Dibaca 3x)',
    audiopath: 'audio/5.mp3',
  ),

  DzikirItem(
    arabic:
        'أَمْسَيْنَا عَلَى فِطْرَةِ اْلإِسْلاَمِ وَعَلَى كَلِمَةِ اْلإِخْلاَصِ، وَعَلَى دِيْنِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِيْنَا إِبْرَاهِيْمَ، حَنِيْفًا مُسْلِمًا وَمَا كَانَ مِنَ الْمُشْرِكِيْنَ',
    translation:
        '“Di waktu sore kami berada diatas fitrah agama Islam, kalimat ikhlas, agama Nabi kita Muhammad صلي الله عليه وسلم dan agama ayah kami, Ibrahim, yang berdiri di atas jalan yang lurus, muslim dan tidak tergolong orang-orang yang musyrik.” (Dibaca 1x)',
    audiopath: 'audio/20.MP3',
  ),
  DzikirItem(
    arabic:
        'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا،وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيْرُ',
    translation:
        'Ya Allah, dengan rahmat dan pertolongan-Mu kami memasuki waktu sore dan dengan rahmat dan pertolongan-Mu kami memasuki waktu pagi. Dengan rahmat dan kehendak-Mu kami hidup dan dengan rahmat dan kehendak-Mu kami mati. Dan kepada-Mu tempat kembali (bagi semua makhluk). (Dibaca 1x)',
    audiopath: 'audio/21.MP3',
  ),
  DzikirItem(
    arabic:
        'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ للهِ، وَالْحَمْدُ للهِ، لَا إِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُبِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُبِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُبِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
    translation:
        'Kami telah memasuki waktu sore dan kerajaan hanya milik Allah, segala puji hanya milik Allah. Tidak ada Ilah yang berhak diibadahi dengan benar kecuali Allah Yang Maha Esa, tiada sekutu bagi-Nya. Bagi-Nya kerajaan dan bagi-Nya pujian. Dia-lah Yang Mahakuasa atas segala sesuatu. Wahai Rabb, aku mohon kepada-Mu kebaikan di malam ini dan kebaikan sesudahnya. Aku berlindung kepada-Mu dari kejahatan malam ini dan kejahatan sesudahnya. Wahai Rabb, aku berlindung kepada-Mu dari kemalasan dan kejelekan di hari tua. Wahai Rabb, aku berlindung kepada-Mu dari siksaan di Neraka dan siksaan di kubur. \n (Dibaca Sore 1x)',
    audiopath: 'audio/22.MP3',
  ),
  DzikirItem(
    arabic:
        'اَللَّهُمَّ أَنْتَ رَبِّيْ لاَ إِلَـهَ إِلاَّ أَنْتَ، خَلَقْتَنِيْ وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوْذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوْءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوْءُ بِذَنْبِيْ فَاغْفِرْ لِيْ فَإِنَّهُ لاَ يَغْفِرُ الذُّنُوْبَ إِلاَّ أَنْتَ',
    translation:
        '“Ya Allah, Engkau adalah Rabb-ku, tidak ada Ilah (yang berhak diibadahi dengan benar) kecuali Engkau, Engkau-lah yang menciptakanku. Aku adalah hamba-Mu. Aku akan setia pada perjanjianku dengan-Mu semampuku. Aku berlindung kepada-Mu dari kejelekan (apa) yang kuperbuat. Aku mengakui nikmat-Mu (yang diberikan) kepadaku dan aku mengakui dosaku, oleh karena itu, ampunilah aku. Sesungguhnya tidak ada yang dapat mengampuni dosa kecuali Engkau.” \n (Dibaca 1x)',
    audiopath: 'audio/23.MP3',
  ),

  DzikirItem(
    arabic:
        'رَضِيْتُ بِاللهِ رَبًّا، وَبِاْلإِسْلاَمِ دِيْنًا، وَبِمُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا',
    translation:
        'Aku rela (ridha) Allah sebagai Rabb-ku (untukku dan orang lain), Islam sebagai agamaku dan Muhammad صلي الله عليه وسلم sebagai Nabiku (yang diutus oleh Allah). (Dibaca 3x)...',
    audiopath: 'audio/7.mp3',
  ),

  DzikirItem(
    arabic:
        'اَللَّهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَاْلآخِرَةِ، اَللَّهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ اللَّهُمَّ اسْتُرْ عَوْرَاتِى وَآمِنْ رَوْعَاتِى. اَللَّهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ، وَمِنْ خَلْفِيْ، وَعَنْ يَمِيْنِيْ وَعَنْ شِمَالِيْ، وَمِنْ فَوْقِيْ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
    translation:
        'Ya Allah, sesungguhnya aku memohon kebajikan dan keselamatan di dunia dan akhirat. Ya Allah, sesungguhnya aku memohon kebajikan dan keselamatan dalam agama, dunia, keluarga dan hartaku. Ya Allah, tutupilah auratku (aib dan sesuatu yang tidak layak dilihat orang) dan tentramkan-lah aku dari rasa takut. Ya Allah, peliharalah aku dari depan, belakang, kanan, kiri dan dari atasku. Aku berlindung dengan kebesaran-Mu, agar aku tidak disambar dari bawahku (aku berlindung dari dibenamkan ke dalam bumi). (Dibaca 1x)',
    audiopath: 'audio/10.mp3',
  ),
  //4,6,8,9,10
  DzikirItem(
    arabic:
        'اَللَّهُمَّ عَافِنِيْ فِيْ بَدَنِيْ، اَللَّهُمَّ عَافِنِيْ فِيْ سَمْعِيْ، اَللَّهُمَّ عَافِنِيْ فِيْ بَصَرِيْ، لاَ إِلَـهَ إِلاَّ أَنْتَ. اَللَّهُمَّ إِنِّي أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وَأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لاَ إِلَـهَ إِلاَّ أَنْتَ',
    translation:
        'Ya Allah, selamatkanlah tubuhku (dari penyakit dan dari apa yang tidak aku inginkan). Ya Allah, selamatkanlah pendengaranku (dari penyakit dan maksiat atau dari apa yang tidak aku inginkan). Ya Allah, selamatkanlah penglihatanku, tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. Ya Allah, sesungguhnya aku berlindung kepada-Mu dari kekufuran dan kefakiran. Aku berlindung kepada-Mu dari siksa kubur, tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. (Dibaca 3x)',
    audiopath: 'audio/12.MP3',
  ),
  DzikirItem(
    arabic:
        'اَللَّهُمَّ عَالِمَ الْغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَاوَاتِ وَاْلأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيْكَهُ، أَشْهَدُ أَنْ لاَ إِلَـهَ إِلاَّ أَنْتَ، أَعُوْذُ بِكَ مِنْ شَرِّ نَفْسِيْ، وَمِنْ شَرِّ الشَّيْطَانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِيْ سُوْءًا أَوْ أَجُرُّهُ إِلَى مُسْلِمٍ',
    translation:
        'Ya Allah Yang Maha mengetahui yang ghaib dan yang nyata, wahai Rabb Pencipta langit dan bumi, Rabb atas segala sesuatu dan Yang Merajainya. Aku bersaksi bahwa tidak ada Ilah yang berhak diibadahi dengan benar kecuali Engkau. Aku berlindung kepada-Mu dari kejahatan diriku, syaitan dan ajakannya menyekutukan Allah (aku berlindung kepada-Mu) dari berbuat kejelekan atas diriku atau mendorong seorang muslim kepadanya. (Dibaca 1x)',
    audiopath: 'audio/13.MP3',
  ),

  DzikirItem(
    arabic:
        'بِسْمِ اللهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي اْلأَرْضِ وَلاَ فِي السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ',
    translation:
        'Dengan Menyebut Nama Allah, yang dengan Nama-Nya tidak ada satupun yang membahayakan, baik di bumi maupun dilangit. Dia-lah Yang Mahamendengar dan Maha mengetahui. (Dibaca 3x)',
    audiopath: 'audio/24.MP3',
  ),
  DzikirItem(
    arabic: 'أَعُوْذُ بِكَلِمَاتِ اللهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    translation:
        'Aku berlindung dengan kalimat-kalimat Allah yang sempurna, dari kejahatan sesuatu yang diciptakan-Nya. \n (Dibaca 3x)',
    audiopath: 'audio/sore.MP3',
  ),

  DzikirItem(
    arabic:
        'يَا حَيُّ يَا قَيُّوْمُ بِرَحْمَتِكَ أَسْتَغِيْثُ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ وَلاَ تَكِلْنِيْ إِلَى نَفْسِيْ طَرْفَةَ عَيْنٍ',
    translation:
        'Wahai Rabb Yang Maha hidup, Wahai Rabb Yang Maha berdiri sendiri (tidak butuh segala sesuatu) dengan rahmat-Mu aku meminta pertolongan, perbaikilah segala urusanku dan jangan diserahkan (urusanku) kepada diriku sendiri meskipun hanya sekejap mata (tanpa mendapat pertolongan dari-Mu). \n (Dibaca 1x)',
    audiopath: 'audio/25.MP3',
  ),
  DzikirItem(
    arabic:
        'سُبْحَانَ اللهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ وَمِدَادَ كَلِمَاتِهِ',
    translation:
        'Mahasuci Allah, aku memuji-Nya sebanyak bilangan makhluk-Nya, Mahasuci Allah sesuai ke-ridhaan-Nya, Mahasuci seberat timbangan ‘Arsy-Nya, dan Mahasuci sebanyak tinta (yang menulis) kalimat-Nya. \n (Dibaca 3x)',
    audiopath: 'audio/16.MP3',
  ),

  // Tambah dzikir petang lainnya di sini
  DzikirItem(
    arabic: 'سُبْحَانَ اللهِ وَبِحَمْدِهِ',
    translation: '“Mahasuci Allah, aku memuji-Nya.” \n (Dibaca 10x atau 100x)',
    audiopath: 'audio/17.MP3',
  ),
  DzikirItem(
    arabic: 'أَسْتَغْفِرُ اللهَ وَأَتُوْبُ إِلَيْهِ',
    translation:
        '“Aku memohon ampunan kepada Allah dan bertaubat kepada-Nya.” \n (Dibaca setiap hari 10x atau 100x)',
    audiopath: 'audio/19.MP3',
  ),
];
