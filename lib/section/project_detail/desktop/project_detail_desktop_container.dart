import 'dart:ui';

import 'package:amlak_app/data/model/projects/Projects.dart';
import 'package:amlak_app/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/cache_image.dart';

class ProjectDetailDesktopContainer extends StatefulWidget {
  Project _project;
  ProjectDetailDesktopContainer(this._project, {super.key});

  @override
  State<ProjectDetailDesktopContainer> createState() =>
      _ProjectDetailDesktopContainerState();
}

class _ProjectDetailDesktopContainerState
    extends State<ProjectDetailDesktopContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              color:
                  Colors.blue.withOpacity(0.2), // Adjust the opacity as desired
            ),
          ),
          Responsive.isMobile(context)
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.8,
                          child: widget._project.images.isNotEmpty
                              ? CachedImage(
                                  imageUrl:
                                      widget._project.images[0].originalUrl,
                                  radious: 10,
                                )
                              : SizedBox(
                                  child: Image.asset(
                                      "assets/images/placeholder.png"),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      Responsive.isDesktop(context) ? 55 : 33,
                                  height:
                                      Responsive.isDesktop(context) ? 20 : 10,
                                  decoration: const BoxDecoration(
                                    color: Color(
                                      0xff54D03F,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "open",
                                      style: TextStyle(
                                        fontSize: Responsive.isDesktop(context)
                                            ? 15
                                            : 8,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                if (widget._project.address.isNotEmpty)
                                  Text(
                                    '${widget._project.address}',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 20
                                          : 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff2b2b2b),
                                      height: 24 / 16,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '%${widget._project.latitude.split(".").first}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        Responsive.isDesktop(context) ? 16 : 12,
                                    color: Color(0xff2b2b2b),
                                    height: 24 / 10,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'سود تخمینی',
                                  style: TextStyle(
                                    fontSize:
                                        Responsive.isDesktop(context) ? 18 : 12,
                                    color: Color(0xff2b2b2b),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget._project.minInvest}',
                                  style: TextStyle(
                                    fontSize:
                                        Responsive.isDesktop(context) ? 18 : 12,
                                    color: Color(0xff2b2b2b),
                                  ),
                                ),
                                Text(
                                  "حداقل سرمایه گذاری",
                                  style: TextStyle(
                                    fontSize:
                                        Responsive.isDesktop(context) ? 18 : 12,
                                    color: Color(0xff2b2b2b),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${widget._project.description}',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize:
                                        Responsive.isDesktop(context) ? 18 : 12,
                                    color: const Color(0xff2b2b2b),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.8,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: widget._project.images.isNotEmpty
                                ? CachedImage(
                                    imageUrl:
                                        widget._project.images[0].originalUrl,
                                    radious: 10,
                                  )
                                : SizedBox(
                                    child: Image.asset(
                                        "assets/images/placeholder.png"),
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        Responsive.isDesktop(context) ? 55 : 33,
                                    height:
                                        Responsive.isDesktop(context) ? 20 : 10,
                                    decoration: const BoxDecoration(
                                      color: Color(
                                        0xff54D03F,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "open",
                                        style: TextStyle(
                                          fontSize:
                                              Responsive.isDesktop(context)
                                                  ? 15
                                                  : 8,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${widget._project.address}',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 20
                                          : 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff2b2b2b),
                                      height: 24 / 16,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '%${widget._project.latitude.split(".").first}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Responsive.isDesktop(context)
                                          ? 16
                                          : 12,
                                      color: Color(0xff2b2b2b),
                                      height: 24 / 10,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'سود تخمینی',
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 18
                                          : 12,
                                      color: Color(0xff2b2b2b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${widget._project.minInvest}',
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 18
                                          : 12,
                                      color: Color(0xff2b2b2b),
                                    ),
                                  ),
                                  Text(
                                    "حداقل سرمایه گذاری",
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 18
                                          : 12,
                                      color: Color(0xff2b2b2b),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${widget._project.description}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? 18
                                          : 12,
                                      color: const Color(0xff2b2b2b),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
