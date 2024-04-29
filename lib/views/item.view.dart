import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:lostnfound_webadmin/models/items.model.dart";

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  @override
  Widget build(BuildContext context) {
    // receive arguments from pushNamed
    final itemArgs = ModalRoute.of(context)!.settings.arguments as ItemsModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 30.0,
                  runSpacing: 10.0,
                  children: [
                    itemArgs.image == null || itemArgs.image!.isEmpty
                        ? Image.asset(
                            "assets/mystery-item.png",
                            width: 500.0,
                            height: 500.0,
                          )
                        : SizedBox(
                            width: 500.0,
                            child: CarouselSlider.builder(
                              itemCount: itemArgs.image!.length,
                              itemBuilder: (ctx, index, realIndex) =>
                                  Image.network(
                                itemArgs.image![index],
                                fit: BoxFit.fill,
                                height: MediaQuery.sizeOf(ctx).height,
                              ),
                              options: CarouselOptions(
                                height: 400.0,
                                autoPlay: false,
                                // enlargeCenterPage: true,
                              ),
                            ),
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          itemArgs.name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w800),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(
                                itemArgs.category.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                color: itemArgs.claimed
                                    ? Colors.green
                                    : Colors.deepPurple,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(
                                itemArgs.claimed ? "CLAIMED" : "TO BE CLAIMED",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Found at",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 15.0,
                      direction: Axis.vertical,
                      children: [
                        LabelledIcon(
                          icon: FontAwesomeIcons.locationDot,
                          label: itemArgs.locationFound,
                        ),
                        LabelledIcon(
                            label: itemArgs.timeFound.toDate().toString(),
                            icon: FontAwesomeIcons.clock)
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      itemArgs.description,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade600),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LabelledIcon extends StatelessWidget {
  const LabelledIcon({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7.0,
      runSpacing: 7.0,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        FaIcon(
          icon,
          color: Colors.blue.shade900,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );
  }
}
