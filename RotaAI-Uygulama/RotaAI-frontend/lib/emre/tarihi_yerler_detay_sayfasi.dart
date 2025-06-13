import 'package:flutter/material.dart';
// import 'package:teknofest_turizm_projesi/gerekli_metodlar.dart';
// import 'package:teknofest_turizm_projesi/turkiye_sayfasi.dart';

class TarihiYerlerDetaySayfasi extends StatelessWidget {
  final String title;
  final String bigtitle;
  final String content;
  /*
  final String description;
  final String location_information;
  final String opening_time_of_clock;
  final String opening_time_of_date;
  final String average_expense;
  final String comment;
  final bool is_comment_sent_by_male;
*/

  const TarihiYerlerDetaySayfasi({
    super.key,
    required this.title,
    required this.bigtitle,
    required this.content,
  });

  //const MuzeAyrintiSayfasi({super.key,required this.title, required this.content,required this.description ,required this.location_information ,required this.opening_time_of_clock ,required this.opening_time_of_date,required this.average_expense,required this.comment,required this.is_comment_sent_by_male });

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
                            bigtitle == "Tarihi Yerler"
                                ? "assets/images/tarihi.jpg"
                                : "assets/images/tarihce.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                content,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: Colors.black87,
                                ),
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

  Widget _buildExpandableSection(BuildContext context,
      {required String title,
      required IconData icon,
      required Widget content}) {
    //required String? imagePath}) {
    return ExpansionTile(
      title: Row(
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 27,
                //overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
          ),
        ],
      ),
      leading: Icon(icon, size: 25, color: Colors.white60),
      children: [content],
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required String fullText}) {
    return Card(
      elevation: 40,
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.9, // Kart genişliği (ekranın %90'ı)
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                fullText,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
