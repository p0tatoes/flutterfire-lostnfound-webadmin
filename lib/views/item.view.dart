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
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: itemArgs.image == null || itemArgs.image!.isEmpty
                    ? const Placeholder(
                        fallbackHeight: 300.0,
                        color: Colors.red,
                      )
                    : CarouselSlider.builder(
                        itemCount: itemArgs.image!.length,
                        itemBuilder: (context, index, realIndex) =>
                            Image.network(
                          itemArgs.image![index],
                          fit: BoxFit.fill,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                        options: CarouselOptions(
                          height: 300.0,
                          autoPlay: false,
                          // enlargeCenterPage: true,
                        ),
                      ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        itemArgs.name,
                        style: const TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w800),
                      ),
                      Row(
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
                      const Text(
                        "Found at",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 15.0,
                        runSpacing: 5.0,
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
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      Text(itemArgs.description),
                    ],
                  ),
                ),
              )
            ],
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
      spacing: 5.0,
      runSpacing: 5.0,
      children: [FaIcon(icon), Text(label)],
    );
  }
}
