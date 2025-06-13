import 'package:flutter/material.dart';
import 'package:ornek003/turkiye/gerekli_metodlar.dart';
import 'package:ornek003/turkiye/yonlendirilen_ayrinti_sayfalari.dart';
import 'package:ornek003/turkiye/yoresel_tatlar_ayrinti_sayfasi.dart';
import 'package:ornek003/turkiye/tarihi_yerler_sayfasi.dart';
import 'package:ornek003/turkiye/yoresel_tatlar_sayfasi.dart';

class deneme3 extends StatelessWidget {
  const deneme3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sayfam3(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange), //Arka plana turuncu bir ton katar
        useMaterial3: true,
      ),
    );
  }
}

class Sayfam3 extends StatefulWidget {
  const Sayfam3({super.key});

  @override
  State<Sayfam3> createState() => _Sayfam3State();
}

class _Sayfam3State extends State<Sayfam3> {
  final List<bool> _isExpanded = [false, false, false];
  final List<bool> _showMore = [
    false,
    false
  ]; // Tarihi yerler ve yöresel tatlar için

  // Tarihi yerler için ek veriler
  final List<Map<String, dynamic>> _tarihiYerlerEk = [
    {
      'title': 'Sultanahmet Camii',
      'description':
          'İstanbul\'un en ünlü camilerinden biri olan Sultanahmet Camii, 1609-1616 yılları arasında Sultan I. Ahmed tarafından yaptırılmıştır.',
      'image': 'assets/images/sultanahmet.jpg',
      'location': 'İstanbul',
    },
    {
      'title': 'Topkapı Sarayı',
      'description':
          'Osmanlı İmparatorluğu\'nun 400 yıl boyunca yönetim merkezi olan Topkapı Sarayı, 15. yüzyılda Fatih Sultan Mehmet tarafından yaptırılmıştır.',
      'image': 'assets/images/topkapi.jpeg',
      'location': 'İstanbul',
    },
    {
      'title': 'Dolmabahçe Sarayı',
      'description':
          '19. yüzyılda Sultan Abdülmecid tarafından yaptırılan Dolmabahçe Sarayı, Osmanlı\'nın son dönem saraylarından biridir.',
      'image': 'assets/images/dolmabahce.jpg',
      'location': 'İstanbul',
    },
  ];

  // Yöresel tatlar için ek veriler
  final List<Map<String, dynamic>> _yoreselTatlarEk = [
    {
      'title': 'İskender Kebap',
      'description':
          'Bursa\'nın meşhur yemeği olan İskender Kebap, ince döş etinden yapılan, domates sosu ve yoğurt ile servis edilen bir kebap türüdür.',
      'image': 'assets/images/iskender.jpg',
      'location': 'Bursa',
    },
    {
      'title': 'Mantı',
      'description':
          'Kayseri\'nin meşhur yemeği olan Mantı, küçük hamur parçalarının içine kıyma konularak yapılan ve yoğurt ile servis edilen bir yemektir.',
      'image': 'assets/images/manti.jpeg',
      'location': 'Kayseri',
    },
    {
      'title': 'Künefe',
      'description':
          'Hatay\'ın meşhur tatlısı olan Künefe, kadayıf ve peynir ile yapılan, şerbetli bir tatlıdır.',
      'image': 'assets/images/kunefe.jpeg',
      'location': 'Hatay',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Türkiye',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.2, 0.2, 1.0],
          ),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 8,
          radius: const Radius.circular(12),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  // Bayrak ve Başlık Bölümü
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "assets/images/türkiyee.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Türkiye Cumhuriyeti",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Asya ve Avrupa'nın Kesişimindeki Ülke",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Kategoriler
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      colorScheme: ColorScheme.fromSwatch().copyWith(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Türkiyeyi Tanıyalım Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[0] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[0],
                            backgroundColor: _isExpanded[0]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "Türkiyeyi Tanıyalım",
                              style: TextStyle(
                                color: _isExpanded[0]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[0] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[0] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.library_books_outlined,
                              color: _isExpanded[0]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[0] ? 28 : 24,
                            ),
                            children: [
                              _buildInfoCard(
                                context,
                                "Türkiyeyi Tanıyalım",
                                Icons.library_books_outlined,
                                "assets/images/tarihce.jpg",
                                [
                                  _buildInfoSection(
                                    context,
                                    "Türkiye Tanıtımı",
                                    "Ülke Tarihçesi",
                                    "Türkiye, dünyanın en eski medeniyetlerine ev sahipliği yapan bir ülkedir...",
                                    "- Türkiye Cumhuriyeti'nin topraklarını oluşturan bölgenin tarihi olarak anlaşılan Türkiye tarihi, hem Anadolu'nun hem de Doğu Trakya'nın tarihini içerir. Bu topraklar üzerinde Hititler, Frigler, Lidyalılar, İyonlar, Persler, Romalılar, Bizanslılar, Selçuklular ve Osmanlılar gibi birçok önemli medeniyet hüküm sürmüştür.\n\n- Anadolu'nun ilk yerleşim izleri Paleolitik Çağ'a (MÖ 2.000.000 - MÖ 10.000) dayanmaktadır. Neolitik Çağ'da (MÖ 8.000 - MÖ 5.500) Çatalhöyük, Göbeklitepe gibi önemli yerleşim merkezleri kurulmuştur.\n\n- Hititler (MÖ 2.000 - MÖ 1.200) döneminde Anadolu'da ilk büyük devlet kurulmuştur. Bu dönemde yazı kullanılmaya başlanmış ve önemli kültürel gelişmeler yaşanmıştır.\n\n- Roma İmparatorluğu döneminde (MÖ 27 - MS 395) Anadolu, imparatorluğun en zengin ve gelişmiş bölgelerinden biri olmuştur. Bu dönemde birçok antik kent ve yapı inşa edilmiştir.\n\n- Bizans İmparatorluğu döneminde (395-1453) İstanbul, dünyanın en önemli kentlerinden biri haline gelmiştir. Bu dönemde Hristiyanlık yayılmış ve önemli dini yapılar inşa edilmiştir.\n\n- Selçuklular döneminde (1071-1308) Anadolu'ya Türk göçleri başlamış ve İslam kültürü yayılmıştır. Bu dönemde birçok medrese, cami ve kervansaray inşa edilmiştir.\n\n- Osmanlı İmparatorluğu döneminde (1299-1922) Türkiye, dünyanın en güçlü devletlerinden biri haline gelmiştir. Bu dönemde İstanbul başkent olmuş ve imparatorluk üç kıtaya yayılmıştır.\n\n- 1923 yılında Mustafa Kemal Atatürk önderliğinde kurulan Türkiye Cumhuriyeti, modern ve laik bir devlet olarak tarih sahnesine çıkmıştır. Cumhuriyet'in ilanından sonra gerçekleştirilen devrimler ve reformlarla Türkiye, çağdaş bir toplum haline gelmiştir.",
                                    cardImage: "assets/images/tarihce.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "Türkiye Tanıtımı",
                                    "Ülke Genel Tanıtım",
                                    "Türkiye, hem Asya hem de Avrupa kıtalarında yer alan eşsiz bir ülkedir...",
                                    "- Türkiye, 783.562 km²'lik yüzölçümüyle dünyanın en büyük 37. ülkesidir. Kuzeyde Karadeniz, güneyde Akdeniz, batıda Ege Denizi ile çevrilidir. Boğazlar ve Marmara Denizi ile Asya ve Avrupa kıtalarını birbirine bağlar.\n\n- Nüfusu 85 milyonu aşan Türkiye, dünyanın en kalabalık 18. ülkesidir. Başkenti Ankara olan ülkenin en büyük şehri İstanbul'dur. Ülke, 81 il ve 922 ilçeden oluşmaktadır.\n\n- Türkiye, zengin kültürel mirası, doğal güzellikleri, tarihi eserleri ve lezzetli mutfağıyla dünyanın en çok ziyaret edilen ülkelerinden biridir. UNESCO Dünya Mirası Listesi'nde 19 eseri bulunmaktadır. Pamukkale, Kapadokya, Efes Antik Kenti, Ayasofya gibi dünyaca ünlü turistik mekanlara ev sahipliği yapar.\n\n- Ülke, stratejik konumu sayesinde Asya ve Avrupa arasında önemli bir köprü görevi görmektedir. Ayrıca, Türkiye'nin üç tarafı denizlerle çevrili olup, zengin bir doğal yaşam ve çeşitli iklim bölgelerine sahiptir. Karadeniz, Akdeniz, Karasal ve Marmara olmak üzere dört farklı iklim tipi görülür.\n\n- Türkiye, gelişmekte olan bir ülke olup, dünyanın en büyük 20 ekonomisinden biridir. Tarım, sanayi ve hizmet sektörlerinde güçlü bir yapıya sahiptir. Otomotiv, tekstil, turizm ve inşaat sektörleri öne çıkan alanlardır.\n\n- Türk kültürü, binlerce yıllık tarihi boyunca birçok medeniyetin etkisiyle zenginleşmiştir. Geleneksel el sanatları, halk oyunları, müzik ve mutfak kültürü dünya çapında tanınmaktadır. Türk mutfağı, UNESCO'nun Somut Olmayan Kültürel Miras Listesi'nde yer almaktadır.\n\n- Eğitim ve bilim alanında da önemli gelişmeler kaydeden Türkiye'de, 200'den fazla üniversite bulunmaktadır. Ayrıca, uzay teknolojileri, savunma sanayi ve yenilenebilir enerji gibi alanlarda önemli yatırımlar yapılmaktadır.",
                                    cardImage: "assets/images/türkiyee.png",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Tarihi Yerler Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[1] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[1],
                            backgroundColor: _isExpanded[1]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "Tarihi Yerler",
                              style: TextStyle(
                                color: _isExpanded[1]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[1] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[1] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.location_on,
                              color: _isExpanded[1]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[1] ? 28 : 24,
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _showMore[0]
                                    ? _tarihiYerlerEk.length
                                    : _tarihiYerlerEk.length,
                                itemBuilder: (context, index) {
                                  final yer = index < _tarihiYerlerEk.length
                                      ? _tarihiYerlerEk[index]
                                      : _tarihiYerlerEk[
                                          index - _tarihiYerlerEk.length];
                                  return _buildTarihiYerCard(context, yer);
                                },
                              ),
                              if (!_showMore[0]) ...[
                                const SizedBox(height: 16),
                                Center(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TarihiYerlerSayfasi(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    label: const Text('Daha Fazla Göster'),
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Yöresel Tatlar Kategorisi
                        Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ExpansionTile(
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _isExpanded[2] = expanded;
                              });
                            },
                            initiallyExpanded: _isExpanded[2],
                            backgroundColor: _isExpanded[2]
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.white,
                            collapsedBackgroundColor:
                                Theme.of(context).primaryColor,
                            title: Text(
                              "Yöresel Tatlar",
                              style: TextStyle(
                                color: _isExpanded[2]
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: _isExpanded[2] ? 20 : 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: _isExpanded[2] ? 0.5 : 0,
                              ),
                            ),
                            leading: Icon(
                              Icons.restaurant_menu,
                              color: _isExpanded[2]
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: _isExpanded[2] ? 28 : 24,
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _showMore[1]
                                    ? _yoreselTatlarEk.length
                                    : _yoreselTatlarEk.length,
                                itemBuilder: (context, index) {
                                  final tat = index < _yoreselTatlarEk.length
                                      ? _yoreselTatlarEk[index]
                                      : _yoreselTatlarEk[
                                          index - _yoreselTatlarEk.length];
                                  return _buildYoreselTatCard(context, tat);
                                },
                              ),
                              if (!_showMore[1]) ...[
                                const SizedBox(height: 16),
                                Center(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              YoreselTatlarSayfasi(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    label: const Text('Daha Fazla Göster'),
                                    style: TextButton.styleFrom(
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    IconData icon,
    String imagePath,
    List<Widget> sections,
  ) {
    // Her kategori için farklı renk belirleme
    Color cardColor;
    if (title == "Türkiyeyi Tanıyalım") {
      cardColor = const Color(0xFFF5E6FF); // Soft mor tonu
    } else if (title == "Tarihi Yerler") {
      cardColor = const Color(0xFFE8F5E9); // Açık yeşil tonu
    } else {
      cardColor = const Color(0xFFE3F2FD); // Açık mavi tonu
    }

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String bigtitle,
    String title,
    String summary,
    String fullText, {
    String? region,
    String? locationForEat,
    String? locationInformation,
    String? cardImage,
  }) {
    // Her kategori için farklı renk belirleme
    Color sectionColor;
    if (bigtitle == "Türkiyeyi Tanıyalım") {
      sectionColor = const Color(0xFFFAF5FF); // Daha açık soft mor tonu
    } else if (bigtitle == "Tarihi Yerler") {
      sectionColor = const Color(0xFFF5FBF6); // Daha açık yeşil tonu
    } else {
      sectionColor = const Color(0xFFF8FBFE); // Daha açık mavi tonu
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          yonlendirelecekSayfaBelirle(
            bigtitle,
            title,
            summary,
            fullText,
            region,
            locationForEat,
            locationInformation,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cardImage != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  cardImage,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Resim yükleme hatası: $error');
                    print('Resim yolu: $cardImage');
                    return Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summary,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (region != null)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    region,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (region != null) const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Devamını Oku",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarihiYerCard(BuildContext context, Map<String, dynamic> yer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              yer['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Resim yükleme hatası: $error');
                print('Resim yolu: ${yer['image']}');
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  yer['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  yer['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                yer['location'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.8),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Detaylar",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYoreselTatCard(BuildContext context, Map<String, dynamic> tat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              tat['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Resim yükleme hatası: $error');
                print('Resim yolu: ${tat['image']}');
                return Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tat['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tat['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Detaylar",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

MaterialPageRoute yonlendirelecekSayfaBelirle(
    String? bigtitle,
    String? title,
    String? summary,
    String? content,
    String? region,
    String? locationForEat,
    String? locationInformation) {
  if (bigtitle == "Tarihi Yerler") {
    final Map<String, String> imageMap = {
      'Sultanahmet Camii': 'assets/images/sultanahmet.jpg',
      'Topkapı Sarayı': 'assets/images/topkapi.jpeg',
      'Dolmabahçe Sarayı': 'assets/images/dolmabahce.jpg',
      'Göbeklitepe': 'assets/images/gobeklitepe.jpg',
    };

    return MaterialPageRoute(
      builder: (context) => MuzeAyrintiSayfasi(
        title: title.toString(),
        bigtitle: bigtitle.toString(),
        content: content.toString(),
        imagePath: imageMap[title] ?? 'assets/images/tarihi.jpg',
      ),
    );
  } else if (bigtitle == "Yöresel Tatlar") {
    final Map<String, String> imageMap = {
      'İskender Kebap': 'assets/images/iskender.jpg',
      'Mantı': 'assets/images/manti.jpeg',
      'Künefe': 'assets/images/kunefe.jpeg',
    };

    return MaterialPageRoute(
      builder: (context) => YoresleTatlarAyrintiSayfasi(
        title: title.toString(),
        bigtitle: bigtitle.toString(),
        content: content.toString(),
        region: region.toString(),
        locationForEat: locationForEat.toString(),
        locationInformation: locationInformation.toString(),
        imagePath: imageMap[title] ?? 'assets/images/yoresel_tat.jpg',
      ),
    );
  } else {
    final Map<String, String> imageMap = {
      'Ülke Tarihçesi': 'assets/images/tarihce.jpg',
      'Ülke Genel Tanıtım': 'assets/images/türkiyee.png',
    };

    return MaterialPageRoute(
      builder: (context) => DetailPage(
        title: title.toString(),
        content: content.toString(),
        imagePath: imageMap[title] ?? 'assets/images/tarihi.jpg',
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;

  const DetailPage({
    super.key,
    required this.title,
    required this.content,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Colors.white,
              Colors.white,
            ],
            stops: const [0.0, 0.2, 0.2, 1.0],
          ),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 8,
          radius: const Radius.circular(12),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            imagePath,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            content,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
