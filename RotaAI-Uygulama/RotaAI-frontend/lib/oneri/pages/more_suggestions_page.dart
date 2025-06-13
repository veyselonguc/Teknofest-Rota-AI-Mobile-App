import 'package:flutter/material.dart';

class MoreSuggestionsPage extends StatelessWidget {
  const MoreSuggestionsPage({super.key});

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
          'Daha Fazla Öneri',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),
          const SizedBox(width: 16),
        ],
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
            stops: const [0.0, 0.3, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSuggestionCard(
                context,
                'Patara Plajı',
                'assets/images/patara.jpg',
                'Patara, eşsiz plajı ve antik kalıntılarıyla ünlüdür.',
                'Patara Plajı, Türkiye\'nin en uzun plajlarından biridir ve 18 kilometrelik kumsala sahiptir. Antik Likya şehri Patara\'nın yanında yer alan bu plaj, caretta caretta kaplumbağalarının da yumurtlama alanıdır. Plajın arkasında yer alan antik kent kalıntıları, tarihi atmosferi modern plaj keyfiyle birleştirmektedir.',
              ),
              _buildSuggestionCard(
                context,
                'Göbeklitepe',
                'assets/images/gobeklitepe.jpg',
                'Göbeklitepe, insanlık tarihinin en eski tapınak kompleksi olarak bilinir.',
                'Göbeklitepe, MÖ 10.000 yılına tarihlenen ve bilinen en eski tapınak kompleksidir. Şanlıurfa\'da bulunan bu arkeolojik alan, insanlık tarihini yeniden yazmıştır. T şeklindeki dikilitaşları, hayvan figürleri ve geometrik desenleriyle dikkat çeken yapı, UNESCO Dünya Mirası Listesi\'nde yer almaktadır.',
              ),
              _buildSuggestionCard(
                context,
                'Kapadokya',
                'assets/images/kapadokya.jpg',
                'Kapadokya, peri bacaları ve sıcak hava balonları ile ünlüdür.',
                'Kapadokya, doğal ve tarihi güzellikleriyle dünyaca ünlü bir bölgedir. Peri bacaları olarak bilinen ilginç kaya oluşumları, yeraltı şehirleri, kaya kiliseleri ve fresklerle dolu vadileriyle benzersiz bir açık hava müzesidir. Bölge aynı zamanda sıcak hava balonu turları, şarap tadımları ve mağara otelleriyle de turistlerin gözdesidir.',
              ),
              _buildSuggestionCard(
                context,
                'Efes Antik Kenti',
                'assets/images/efes.jpg',
                'Efes, antik Roma dönemi yapılarıyla oldukça ünlüdür.',
                'Efes Antik Kenti, İzmir\'in Selçuk ilçesinde yer alan ve dünyanın en iyi korunmuş antik kentlerinden biridir. Celsus Kütüphanesi, Büyük Tiyatro, Hadrian Tapınağı gibi etkileyici yapıları barındıran kent, Roma İmparatorluğu döneminin en önemli ticaret ve kültür merkezlerinden biriydi. UNESCO Dünya Mirası Listesi\'nde yer alan Efes, her yıl milyonlarca turist tarafından ziyaret edilmektedir.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionCard(
    BuildContext context,
    String title,
    String imageUrl,
    String description,
    String detailDescription,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.05),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                insetPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: Image.asset(
                                  imageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 48,
                                          color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      detailDescription,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 30),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
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
