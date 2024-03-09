import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:equipohealth/health/bloc/healthbloc.dart';
import 'package:equipohealth/health/common/circlecontainer.dart';
import 'package:equipohealth/health/healthhome/auth/healthlogin.dart';
import 'package:equipohealth/health/newspage.dart';
import 'package:equipohealth/health/start/startingpage.dart';
import 'package:equipohealth/utils/helper.dart';
import 'package:equipohealth/utils/initializer.dart';
import 'package:equipohealth/utils/localstorage.dart';
import 'package:equipohealth/utils/nosplash.dart';

class HealthHome extends StatefulWidget {
  const HealthHome({super.key});

  @override
  State<HealthHome> createState() => _HealthHomeState();
}

class _HealthHomeState extends State<HealthHome> {
  @override
  void initState() {
    context.read<HealthBloc>().add(GetProfileData());
    context.read<HealthBloc>().add(GetDashBoardData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#f4efe9"),
        body: BlocConsumer<HealthBloc, HealthState>(
          buildWhen: (previous, current) =>
              current is DashBoardDataFetched ||
              current is DashBoardDataNotFound ||
              current is DashBoardDataNotFetched,
          listener: (context, state) async {
            if (state is DashBoardDataNotFound) {
              Helper.push(const StartingPage(), '');
            }
            if (state is LoggingOutSuccess) {
              await LocalStorage.clearAll().then((value) =>
                  Helper.pushReplacementRemove(const HealthLoginPage(), ''));
            }
          },
          builder: (context, state) => state is DashBoardDataFetched
              ? NoSplashScroll(
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 18, horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 38, vertical: 40),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 26,
                                            child: Icon(Icons.person_4),
                                          ),
                                          Helper.allowWidth(15),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                Initializer.userData!.docs
                                                    .first['name'],
                                                style: const TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Helper.allowHeight(5),
                                              Text(
                                                Initializer.userData!.docs
                                                    .first['email'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[500],
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Helper.allowHeight(25),
                                      InkWell(
                                        onTap: () {
                                          Helper.pop();
                                          context
                                              .read<HealthBloc>()
                                              .add(DoLogout());
                                        },
                                        child: Container(
                                          width: Helper.width(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18, horizontal: 36),
                                          decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: const Text(
                                            "Sign Out",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              // color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 26,
                                child: Icon(Icons.person_4),
                              ),
                            ),
                            Row(
                              children: [
                                CircleContainer(
                                  color: HexColor('#e6dfd6'),
                                  child: const Icon(Icons.search),
                                ),
                                Helper.allowWidth(15),
                                CircleContainer(
                                  color: HexColor('#e6dfd6'),
                                  child: const Icon(
                                      Icons.notifications_none_sharp),
                                )
                              ],
                            )
                          ],
                        ),
                        Helper.allowHeight(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text("Health\noverview",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Upcoming appointment",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]),
                                ),
                                Helper.allowHeight(10.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: HexColor('#e6dfd6'),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(
                                            vertical: 14, horizontal: 26),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(14),
                                                bottomRight:
                                                    Radius.circular(14),
                                                topLeft: Radius.circular(12.0),
                                                bottomLeft:
                                                    Radius.circular(12.0))),
                                        child: Column(
                                          children: [
                                            Text(
                                              Helper.setDateFormat(
                                                  dateTime: state.healthData!
                                                      .appointment.date,
                                                  format: "dd"),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              Helper.setDateFormat(
                                                  dateTime: state.healthData!
                                                      .appointment.date,
                                                  format: "EEE"),

                                              // Helper.setDateFormat(
                                              //     dateTime:state
                                              //         .healthData!
                                              //         .appointment!
                                              //         .date!,
                                              //     format: 'EEE'),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .symmetric(horizontal: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              state.healthData!.appointment
                                                  .referel,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Helper.allowHeight(2.5),
                                            Text(
                                              Helper.setDateFormat(
                                                  dateTime: state.healthData!
                                                      .appointment.date,
                                                  format: 'hh:mm a'),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Helper.allowHeight(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              "Todays medication",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "View all",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Helper.allowHeight(15),
                        NoSplashScroll(
                          child: SingleChildScrollView(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  state.healthData!.medications.length,
                                  (index) => Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          top: 20),
                                                  child: Row(
                                                    children: [
                                                      const CircleAvatar(
                                                        child: Icon(Icons
                                                            .medication_liquid),
                                                      ),
                                                      Helper.allowWidth(15.0),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            state
                                                                .healthData!
                                                                .medications[
                                                                    index]
                                                                .medicinename,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Helper.allowHeight(
                                                              2.0),
                                                          Text(
                                                            state
                                                                .healthData!
                                                                .medications[
                                                                    index]
                                                                .description,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[350],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Helper.allowHeight(10),
                                                const Divider(),
                                                Helper.allowHeight(2.5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    const Text(
                                                      "Due to be taken at",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Helper.allowWidth(10),
                                                    Text(
                                                      Helper.setDateFormat(
                                                          dateTime: state
                                                              .healthData!
                                                              .medications[
                                                                  index]
                                                              .due,
                                                          format: 'hh:mm a'),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Helper.allowWidth(10),
                                        ],
                                      )),
                            ),
                          ),
                        ),
                        Helper.allowHeight(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              "My health",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "View all",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Helper.allowHeight(15),
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          children: List.generate(
                              state.healthData!.overall.length,
                              (index) => Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      color: Colors.grey[350],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 14.0,
                                              child: Icon(Icons.healing),
                                              // backgroundImage: NetworkImage(
                                              //     'https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png')
                                              // backgroundImage: Imag,
                                            ),
                                            Helper.allowWidth(10.0),
                                            Text(
                                              state.healthData!.overall[index]
                                                  .title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                        Helper.allowHeight(20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              state.healthData!.overall[index]
                                                  .value
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Helper.allowWidth(5.0),
                                            Expanded(
                                              child: Text(
                                                state.healthData!.overall[index]
                                                    .unit,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[500],
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                        ),
                        Helper.allowHeight(30),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Latest Health News",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Helper.allowHeight(15),
                        Column(
                          children: List.generate(
                              Initializer.news.length,
                              (index) => Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Helper.push(
                                            NewsPage(
                                                news: Initializer.news[index]),
                                            'name'),
                                        child: Container(
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(
                                              vertical: 14, horizontal: 14),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            color: Colors.grey[300],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                child: Image.network(
                                                  Initializer.news[index]
                                                      ['image']!,
                                                  width: 120,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Helper.allowWidth(15),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      Initializer.news[index]
                                                          ['title']!,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Helper.allowHeight(5),
                                                    Text(
                                                      Initializer.news[index]
                                                          ['content']!,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Helper.allowHeight(10)
                                    ],
                                  )),
                        )
                      ],
                    ),
                  ),
                )
              : state is DashBoardDataNotFound
                  ? const Center(child: Text("No data found"))
                  : Container(),
        ),
      ),
    );
  }
}
