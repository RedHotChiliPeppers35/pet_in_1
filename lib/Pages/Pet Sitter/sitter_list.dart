import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Pet%20Owner/Main%20Page/list_view_page.dart';
import 'package:flutter_application_1/Pages/constants.dart';
import 'package:flutter_application_1/main.dart';
import '../Pet Owner/Profile Page/personal info/personal_info_page.dart';

class PetSitterListPage extends StatefulWidget {
  const PetSitterListPage({super.key});

  @override
  State<PetSitterListPage> createState() => _PetSitterListPageState();
}

class _PetSitterListPageState extends State<PetSitterListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
            stream: null,
            builder: (context, snapshot) {
              return WillPopScope(
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      floating: true,
                      automaticallyImplyLeading: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      toolbarHeight: 100,
                      leadingWidth: 8,
                      centerTitle: false,
                      title: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "Hoşgeldin $userFirstName",
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 180,
                                  child: TextField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    readOnly: true,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    textCapitalization: TextCapitalization.words,
                                    onTap: () {
                                      showSearch(
                                        context: context,
                                        delegate: CitySearch(controller: searchController),
                                      );
                                    },
                                    keyboardType: TextInputType.streetAddress,
                                    textAlign: TextAlign.start,
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        alignment: Alignment.topCenter,
                                        onPressed: () {
                                          showSearch(
                                            context: context,
                                            delegate: CitySearch(controller: searchController),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.location_on,
                                          size: 20,
                                        ),
                                      ),
                                      hintText: "Şehir ara",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
                              ],
                            )
                          ],
                        ),
                      ),
                      actions: [
                        StreamBuilder(
                            stream: null,
                            builder: (context, snapshot) {
                              return TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => const PersonalInformationPage(),
                                    )),
                                child: Builder(
                                  builder: (context) {
                                    if (imageURL != null) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(imageURL!),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 2, color: applicationOrange)),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.person,
                                            size: 60,
                                            color: applicationOrange,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            }),
                      ],
                    )
                  ],
                  body: Center(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.black,
                          height: 10,
                        );
                      },
                    ),
                  ),
                ),
              );
            }));
  }
}
