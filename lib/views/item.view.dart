import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:lostnfound_webadmin/models/items.model.dart";
import "package:lostnfound_webadmin/providers/items.provider.dart";
import "package:lostnfound_webadmin/widgets/labelled_icon.dart";
import "package:provider/provider.dart";

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  bool? isClaimed;

  @override
  Widget build(BuildContext context) {
    // receive arguments from pushNamed
    final itemArgs = ModalRoute.of(context)!.settings.arguments as ItemsModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campus Find',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
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
                              fontSize: 30.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
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
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Update status:",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 7.0,
                            ),
                            Switch(
                              value: isClaimed ?? itemArgs.claimed,
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.deepPurple,
                              // inactiveTrackColor: Colors.deepPurple.shade100,
                              onChanged: (bool value) async {
                                try {
                                  final isUpdated =
                                      await Provider.of<ItemsProvider>(context,
                                              listen: false)
                                          .updateStatus(id: itemArgs.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Updating listing status"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );

                                  if (isUpdated) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Successfully updated listing status"),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    setState(() {
                                      isClaimed = value;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Failed to updated listing status"),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                    ),
                                  );

                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Found at",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
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
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    Text(
                      itemArgs.description,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white),
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
