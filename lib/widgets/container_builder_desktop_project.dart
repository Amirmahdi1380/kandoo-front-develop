import 'package:amlak_app/data/model/projects/Projects.dart';
import 'package:amlak_app/responsive/responsive.dart';
import 'package:amlak_app/section/project_detail/mobile/project_detail_mobile_screen.dart';
import 'package:amlak_app/widgets/cache_image.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/rendering.dart';
import '../section/project_detail/desktop/project_detail_desktop_container.dart';

class PojectsContainerBuilderDesktop extends StatefulWidget {
  List<Project> _project;
  PojectsContainerBuilderDesktop(this._project, {super.key});

  @override
  State<PojectsContainerBuilderDesktop> createState() =>
      _PojectsContainerBuilderDesktopState();
}

class _PojectsContainerBuilderDesktopState
    extends State<PojectsContainerBuilderDesktop> {
  @override
  Widget build(BuildContext context) {
    bool _showLeftArrow = true;
    bool _showRightArrow = true;
    final ScrollController _scrollController = ScrollController();

    @override
    void _handleScroll() {
      setState(() {
        _showLeftArrow = _scrollController.position.pixels > 0;
        _showRightArrow = _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent;
      });
    }

    void initState() {
      super.initState();
      _scrollController.addListener(_handleScroll);
    }

    @override
    void dispose() {
      _scrollController.dispose();
      super.dispose();
    }

    return Padding(
      padding: Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 20)
          : const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        //width: MediaQuery.of(context).size.width*0.9,
        height: Responsive.isMobile(context)
            ? 300
            : Responsive.isTablet(context)
                ? 420
                : Responsive.isDesktop(context)
                    ? 462
                    : 462,
        child: Responsive.isDesktop(context) || Responsive.isTablet(context)
            ? Stack(
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        _handleScroll();
                      }
                      return false;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget._project.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProjectDetailDesktopContainer(
                                          widget._project[index]);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                width: 314,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xff2C2C2C)
                                        .withOpacity(0.2),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 400,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: widget
                                              ._project[index].images.isNotEmpty
                                          ? CachedImage(
                                              imageUrl: widget._project[index]
                                                  .images[0].originalUrl,
                                              radious: 10,
                                            )
                                          : SizedBox(
                                              child: Image.asset(
                                                "assets/images/placeholder.png",
                                              ),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: Responsive.isDesktop(
                                                        context)
                                                    ? 55
                                                    : 38,
                                                height: Responsive.isDesktop(
                                                        context)
                                                    ? 20
                                                    : 18,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xff54D03F),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(4),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "open",
                                                    style: TextStyle(
                                                      fontSize:
                                                          Responsive.isDesktop(
                                                                  context)
                                                              ? 15
                                                              : 12,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${widget._project[index].title}',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontSize:
                                                        Responsive.isDesktop(
                                                                context)
                                                            ? 20
                                                            : 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff2b2b2b),
                                                    height: 24 / 16,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '%${widget._project[index].latitude.split(".").first}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        Responsive.isDesktop(
                                                                context)
                                                            ? 16
                                                            : 12,
                                                    color:
                                                        const Color(0xff2b2b2b),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'سود تخمینی',
                                                  style: TextStyle(
                                                    fontSize:
                                                        Responsive.isDesktop(
                                                                context)
                                                            ? 16
                                                            : 12,
                                                    color: Color(0xff2b2b2b),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${widget._project[index].minInvest}',
                                                style: TextStyle(
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? 16
                                                          : 12,
                                                  color: Color(0xff2b2b2b),
                                                ),
                                              ),
                                              Text(
                                                "حداقل سرمایه گذاری",
                                                style: TextStyle(
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? 16
                                                          : 12,
                                                  color: Color(0xff2b2b2b),
                                                ),
                                                //textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${widget._project[index].description}',
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? 16
                                                          : 12,
                                                  color:
                                                      const Color(0xff2b2b2b),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              LinearPercentIndicator(
                                                width: 180,
                                                lineHeight: 3.0,
                                                percent: widget._project[index]
                                                    .progress_bar
                                                    .toDouble(),
                                                backgroundColor: Colors.grey,
                                                progressColor: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (widget._project.length > 3) ...{
                    if (_showLeftArrow)
                      Positioned(
                        right: 40,
                        top: 0,
                        child: Container(
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black26,
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _scrollController.animateTo(
                                  _scrollController.position.pixels + 200,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    if (_showRightArrow)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black26,
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                size: 24,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _scrollController.animateTo(
                                  _scrollController.position.pixels - 250,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                  }
                ],
              )
            : Stack(
                children: [
                  NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        _handleScroll();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      reverse: true,
                      itemCount: widget._project.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProjectDetailDesktopContainer(
                                        widget._project[index]);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 300,
                              width: 190,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    color: const Color(0xff2C2C2C)
                                        .withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 190,
                                    height: 140,
                                    child:
                                        widget._project[index].images.isNotEmpty
                                            ? CachedImage(
                                                imageUrl: widget._project[index]
                                                    .images[index].originalUrl,
                                                radious: 10,
                                              )
                                            : SizedBox(
                                                child: Image.asset(
                                                    "assets/images/placeholder.png"),
                                              ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          //crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              width:
                                                  Responsive.isDesktop(context)
                                                      ? 55
                                                      : 38,
                                              height:
                                                  Responsive.isDesktop(context)
                                                      ? 20
                                                      : 15,
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
                                                        Responsive.isDesktop(
                                                                context)
                                                            ? 15
                                                            : 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '${widget._project[index].title}',
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? 20
                                                          : 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff2b2b2b),
                                                  height: 24 / 16,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '%${widget._project[index].latitude.split(".").first}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
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
                                                  fontSize:
                                                      Responsive.isDesktop(
                                                              context)
                                                          ? 18
                                                          : 12,
                                                  color: Color(0xff2b2b2b),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${widget._project[index].minInvest}',
                                              style: TextStyle(
                                                fontSize: Responsive.isDesktop(
                                                        context)
                                                    ? 18
                                                    : 12,
                                                color: Color(0xff2b2b2b),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "حداقل سرمایه گذاری",
                                              style: TextStyle(
                                                fontSize: Responsive.isDesktop(
                                                        context)
                                                    ? 18
                                                    : 12,
                                                color: Color(0xff2b2b2b),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LinearPercentIndicator(
                                              width: 130,
                                              lineHeight: 3.0,
                                              percent: widget
                                                  ._project[index].progress_bar
                                                  .toDouble(),
                                              backgroundColor: Colors.grey,
                                              progressColor: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
