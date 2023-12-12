// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vigenesia/bloc/get_all_motivation/get_all_motivation_bloc.dart';
import 'package:vigenesia/bloc/get_motivation_user/get_motivation_user_bloc.dart';
import 'package:vigenesia/bloc/motivation/motivation_bloc.dart';
import 'package:vigenesia/data/datasource/local/auth_local_datasource.dart';
import 'package:vigenesia/data/model/request/motivation_request_model.dart';
import 'package:vigenesia/page/login_page.dart';

import '../bloc/delete_motivation/delete_motivation_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  TextEditingController? _controller;

  @override
  void initState() {
    getMotivation();
    getMotivationUser();
    _controller = TextEditingController();
    _tabController = TabController(
      vsync: this, // the SingleTickerProviderStateMixin
      length: 2, // this is the number of tabs.
    );
    super.initState();
  }

  void getMotivation() {
    context.read<GetAllMotivationBloc>().add(GetAllMotivation());
  }

  void getMotivationUser() {
    context.read<GetMotivationUserBloc>().add(GetMotivationUser());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        title: const Text(
          'ViGeNesia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xffBC0BE6),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final logout = await AuthLocalDatasource().removeAuthData();
              if (logout) {
                context.go(LoginPage.routeName);
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
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
              child: Column(
                children: [
                  FutureBuilder(
                      future: AuthLocalDatasource().getName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else {
                          return Text(
                            'Halo, ${snapshot.data}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                      }),
                  const Text(
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
                        controller: _controller,
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
                      BlocConsumer<MotivationBloc, MotivationState>(builder: (context, state) {
                        if (state is MotivationLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.purple,
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              final model = MotivationRequestModel(motivation: _controller!.text);
                              context.read<MotivationBloc>().add(PostMotivation(model));
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _controller!.clear();
                              });
                            },
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
                          );
                        }
                      }, listener: (context, state) {
                        if (state is MotivationError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (state is MotivationSuccess) {
                          // getMotivation();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.motivation.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                          setState(() {
                            getMotivation();
                            getMotivationUser();
                          });
                        }
                      }),
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
                            BlocBuilder<GetAllMotivationBloc, GetAllMotivationState>(builder: (context, state) {
                              if (state is GetAllMotivationLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.purple,
                                  ),
                                );
                              } else if (state is GetAllMotivationSuccess) {
                                return ListView.builder(
                                  itemCount: state.motivation.data.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        tileColor: const Color(0xffF5F5F5),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        title: Text(state.motivation.data[index].username),
                                        subtitle: Text(state.motivation.data[index].motivation),
                                        leading: const Icon(Icons.person),
                                        // trailing: Text(DateFormat("d-M-yyyy", "id_ID").format(DateTime.parse(state.motivation.data[index].createdAt.toString()).toLocal())),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is GetAllMotivationError) {
                                return Center(child: Text(state.message));
                              }
                              return const Center(child: Text(''));
                            }),
                            BlocBuilder<GetMotivationUserBloc, GetMotivationUserState>(
                              builder: (context, state) {
                                if (state is GetMotivationUserLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
                                  );
                                } else if (state is GetMotivationUserSuccess) {
                                  return ListView.builder(
                                    itemCount: state.motivation.data.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          tileColor: const Color(0xffF5F5F5),
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          title: Text(state.motivation.data[index].motivation),
                                          subtitle: Text(DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.parse(state.motivation.data[index].createdAt.toString()).toLocal())),
                                          trailing: IconButton(
                                            onPressed: () {
                                              context.read<DeleteMotivationBloc>().add(DeleteMotivation(state.motivation.data[index].id));
                                              Future.delayed(const Duration(milliseconds: 500), () {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Motivasi berhasil dihapus'),
                                                    backgroundColor: Colors.green,
                                                  ),
                                                );
                                                setState(() {
                                                  getMotivation();
                                                  getMotivationUser();
                                                });
                                              });
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else if (state is GetMotivationUserError) {
                                  return Center(child: Text(state.message));
                                } else {
                                  return const Center(child: Text('Anda belum mempunyai motivasi'));
                                }
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
