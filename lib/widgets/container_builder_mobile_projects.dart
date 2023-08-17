import 'package:amlak_app/data/model/projects/Projects.dart';
import 'package:amlak_app/section/project_detail/mobile/project_detail_mobile_screen.dart';
import 'package:amlak_app/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PojectsContainerBuilderMobile extends StatefulWidget {
  List<Project> _project;
  PojectsContainerBuilderMobile(this._project, {super.key});

  @override
  State<PojectsContainerBuilderMobile> createState() => _PojectsContainerBuilderMobileState();
}

class _PojectsContainerBuilderMobileState extends State<PojectsContainerBuilderMobile> {
  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 280,
        child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget._project.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProjectDetailScreen(widget._project[index]);
                    },
                  ),
                );
              },
              child: Container(
                height: 280,
                width: 182,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: const Color(0xff2C2C2C).withOpacity(0.2)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 181,
                      height: 114,
                      child: CachedImage(
                        imageUrl: widget._project[index].images[0].originalUrl,
                        radious: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  '${widget._project[index].address}',
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff2b2b2b),
                                    height: 24 / 16,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Container(
                                width: 33,
                                height: 14,
                                decoration: const BoxDecoration(
                                  color: Color(
                                    0xff54D03F,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "open",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'سود تخمینی',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff2b2b2b),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '%${widget._project[index].latitude.split(".").first}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Color(0xff2b2b2b),
                                    height: 24 / 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "حداقل سرمایه گذاری",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff2b2b2b),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '${widget._project[index].minInvest}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff2b2b2b),
                                ),
                              ),
                            ],
                          ),
                         const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${widget._project[index].description}',
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff2b2b2b),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: LinearPercentIndicator(
                              width: 159.0,
                              lineHeight: 3.0,
                              percent: widget._project[index].progress_bar.toDouble(),
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
