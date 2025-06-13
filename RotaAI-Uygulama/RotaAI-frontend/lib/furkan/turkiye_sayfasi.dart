import 'package:flutter/material.dart';
import 'package:ornek003/furkan/turkiye_gerekli_metodlar.dart';
import 'package:ornek003/furkan/yonlendirilen_ayrinti_sayfalari.dart';
import 'package:ornek003/furkan/yoresel_tatlar_ayrinti_sayfasi.dart';

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
                                    "- Türkiye Cumhuriyeti'nin topraklarını oluşturan bölgenin tarihi olarak anlaşılan Türkiye tarihi, hem Anadolu'nun hem de Doğu Trakya'nın tarihini içerir...",
                                    cardImage: "assets/images/tarihce.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "Türkiye Tanıtımı",
                                    "Ülke Genel Tanıtım",
                                    "Türkiye, hem Asya hem de Avrupa kıtalarında yer alan eşsiz bir ülkedir...",
                                    "- Türkiye, hem Asya hem de Avrupa kıtalarında yer alan stratejik konumu ve kültürel zenginlikleri ile dünyanın en eşsiz ülkelerinden biridir...",
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
                              _buildInfoCard(
                                context,
                                "Tarihi Yerler",
                                Icons.location_on,
                                "assets/images/tarihi.jpg",
                                [
                                  _buildInfoSection(
                                    context,
                                    "Tarihi Yerler",
                                    "Ayasofya",
                                    "Ayasofya, İstanbul'da yer alan tarihi bir yapıdır...",
                                    "Ayasofya, Bizans İmparatoru I. Justinianus tarafından 537 yılında kilise olarak inşa edilmiştir...",
                                    cardImage: "assets/images/tarihi.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "Tarihi Yerler",
                                    "Topkapı Sarayı",
                                    "Topkapı Sarayı, Osmanlı İmparatorluğu'nun idari ve kültürel merkeziydi...",
                                    "Topkapı Sarayı, İstanbul'da yer alan ve Osmanlı İmparatorluğu döneminde padişahların yaşam alanı olarak kullanılan bir saraydır...",
                                    cardImage: "assets/images/tarihi.jpg",
                                  ),
                                ],
                              ),
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
                              _buildInfoCard(
                                context,
                                "Yöresel Tatlar",
                                Icons.restaurant_menu,
                                "assets/images/yoresel_tat.jpg",
                                [
                                  _buildInfoSection(
                                    context,
                                    "Yöresel Tatlar",
                                    "Kebap",
                                    "Yumuşak, sinirden arındırılmış ve zırhla çekilmiş kıymanın bol acı biber ve tuzla buluştuğu Adana kebabı...",
                                    "- Yumuşak, sinirden arındırılmış ve zırhla çekilmiş kıymanın bol acı biber ve tuzla buluştuğu Adana kebabı ve şalgam ikilisini her gurmenin bir kez de Adana'da denemesi gerekiyor...",
                                    region: "Adana/Urfa - (Doğu Bölgesi)",
                                    locationForEat:
                                        "Her şehirde yenebilir ancak ait olduğu yöre olan Adana veya Urfa da yenmesi daha çok önerilir.",
                                    locationInformation:
                                        "Adana: Türkiye'deki yedinci büyük metropolitan alan olup ülkenin önde gelen tarım, ticaret ve kültür merkezlerinden biridir.",
                                    cardImage: "assets/images/yoresel_tat.jpg",
                                  ),
                                  _buildInfoSection(
                                    context,
                                    "Yöresel Tatlar",
                                    "Baklava",
                                    "İnce yufka tabakaları ve aralarına serpilmiş fıstık veya ceviz...",
                                    "Baklava yapımı, özen ve sabır isteyen bir süreçtir...",
                                    region: "Gazi Antep - (Güney Doğu Bölgesi)",
                                    locationForEat:
                                        "Her şehirde yenebilir ancak ait olduğu yöre olan Gazi Antep de yenmesi daha çok önerilir.",
                                    locationInformation:
                                        "En önemli özellikleri arasında tarihi ipek yolu güzergahında bulunması olan Gaziantep oldukça çeşitli kültürlere ev sahipliği yapıyor.",
                                    cardImage: "assets/images/yoresel_tat.jpg",
                                  ),
                                ],
                              ),
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
    print(
        "bigtitle: $bigtitle,title: $title,summary: $summary,content: $content");
    return MaterialPageRoute(
      builder: (context) => MuzeAyrintiSayfasi(
          title: title.toString(),
          bigtitle: bigtitle.toString(),
          content: content.toString()),
    );
  } else {
    if (bigtitle == "Yöresel Tatlar") {
      return MaterialPageRoute(
        builder: (context) => YoresleTatlarAyrintiSayfasi(
          title: title.toString(),
          bigtitle: bigtitle.toString(),
          content: content.toString(),
          region: region.toString(),
          locationForEat: locationForEat.toString(),
          locationInformation: locationInformation.toString(),
        ),
      );
    } else {
      print(
          "bigtitle: $bigtitle,title: $title,summary: $summary,content: $content");
      return MaterialPageRoute(
        builder: (context) =>
            DetailPage(title: title.toString(), content: content.toString()),
      );
    }
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String content;

  const DetailPage({super.key, required this.title, required this.content});

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
                    child: Padding(
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
