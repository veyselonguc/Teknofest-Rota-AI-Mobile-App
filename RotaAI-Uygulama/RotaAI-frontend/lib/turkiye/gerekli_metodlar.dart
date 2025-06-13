import 'package:flutter/material.dart';

AppBar app_bar(String? title) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [],
        ),
        Row(
          children: [
            Text(
              "$title      ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
    leading: Builder(
        builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.white, size: 35))),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 0, 0, 163), Colors.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
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
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Menü',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          title: Text('Türkiyeyi Tanıyalım'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Tarihin Öne Çıkanları'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Yöresel Yiyecekler'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Harita'),
          onTap: () {},
        ),
      ],
    ),
  );
}
