import 'package:flutter/material.dart';

AppBar app_bar(String title) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.blue,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
  );
}

/*AppBar app_bar(String? menuIsmi) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.menu,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              menuIsmi.toString(),
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.home,
              color: Colors.white,
              size: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Icon(Icons.help, color: Colors.white, size: 25),
            ),
            Icon(Icons.info, color: Colors.white, size: 25)
          ],
        )
      ],
    ),
    centerTitle: true,
    backgroundColor: Color(0xFF000080),
  );
}
*/
Drawer drawerim() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'KKTC Tanıtım Uygulaması',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Ana Sayfa'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('KKTC Hakkında'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Tarihi Yerler'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.restaurant_menu),
          title: const Text('Kıbrıs Mutfağı'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Ayarlar'),
          onTap: () {},
        ),
      ],
    ),
  );
}
