import 'package:amlak_app/data/model/projects/Projects.dart';
import 'package:amlak_app/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectDetailScreen extends StatefulWidget {
  Project _project;
  ProjectDetailScreen(this._project, {super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 10, bottom: 30),
              child: Text(
                '${widget._project.title}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff2b2b2b),
                  //height: 24 / 16,
                ), 
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                //height: MediaQuery.of(context).size.height / 4,
                child: widget._project.images.isNotEmpty
                    ? CachedImage(
                        imageUrl: widget._project.images[0].originalUrl,
                      )
                    : SizedBox(
                        child: Image.asset("assets/images/placeholder.png"),
                      ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 1.4,
                    lineHeight: 3.0,
                    percent: widget._project.progress_bar.toDouble(),
                    backgroundColor: Colors.grey,
                    progressColor: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "سرمایه گذاری شده",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                    Text(
                      '${widget._project.expectedProfit}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'کل سرمایه مورد نیاز',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                    Text(
                      '${widget._project.expectedProfit}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6),
              child: const Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '%${widget._project.expectedProfit}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2b2b2b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    "سود تخمینی ",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2b2b2b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6),
              child: const Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget._project.area}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2b2b2b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    "قیمت هرمتر",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2b2b2b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6),
              child: const Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${widget._project.minInvest}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2b2b2b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Text(
                    "حداقل سرمایه گذاری",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2b2b2b),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6),
              child: const Divider(),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('خرید'),
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(142, 57),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
