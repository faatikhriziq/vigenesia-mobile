import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this, // the SingleTickerProviderStateMixin
      length: 2, // this is the number of tabs.
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'ViGeNesia',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color(0xffBC0BE6),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xffBC0BE6),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffBC0BE6),
                    Color(0xff3115AE),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65),
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'Halo, Hansen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Bagikan Motivasimu hari ini!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                height: 450,
                width: width / 1.25,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                width: width / 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        cursorColor: const Color(0xffBC0BE6),
                        decoration: const InputDecoration(
                          focusColor: Color(0xffBC0BE6),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBC0BE6)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          hintText: 'Tuliskan Motivasimu disini!',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xffBC0BE6),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Kirim',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TabBar(
                        controller: _tabController,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        labelColor: Colors.black,
                        indicatorColor: const Color(0xffBC0BE6),
                        tabs: const [
                          Tab(
                            text: 'All Motivasi',
                          ),
                          Tab(
                            text: 'Motivasi Saya',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    tileColor: const Color(0xffF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text('Hansen'),
                                    subtitle: const Text('Haiya, lu olang kalau mau kaya jangan rebahan mulu lo, cali kelja lo, phei a phei !'),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border),
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    tileColor: const Color(0xffF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text('Senin, 20 September 2023'),
                                    subtitle: const Text('Haiya, lu olang kalau mau kaya jangan rebahan mulu lo, cali kelja lo, phei a phei !'),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffBC0BE6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://conferenceoeh.com/wp-content/uploads/profile-pic-dummy.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hansen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'hansen@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to home page
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to profile page
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings page
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Perform logout action
              },
            ),
          ],
        ),
      ),
    );
  }
}
