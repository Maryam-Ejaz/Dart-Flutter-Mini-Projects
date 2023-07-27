import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'inc_dec.dart';
import 'counterblock.dart';
import 'counter.dart';
import 'package:provider/provider.dart';

class TabTwo extends StatefulWidget {
  @override
  _TabTwoState createState() => _TabTwoState();
}

class _TabTwoState extends State<TabTwo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = ['https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s', 'https://fastly.picsum.photos/id/15/2500/1667.jpg?hmac=Lv03D1Y3AsZ9L2tMMC1KQZekBVaQSDc1waqJ54IHvo4', 'https://fastly.picsum.photos/id/18/2500/1667.jpg?hmac=JR0Z_jRs9rssQHZJ4b7xKF82kOj8-4Ackq75D_9Wmz8', 'https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.teal,
          tabs: [
            Tab(text: 'Expansion Tile'),
            Tab(text: 'Expansion Panel'),

          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildExpansionTile(),
              _buildExpansionPanel(),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpansionTile() {
    return ListView(
      children: [
        ExpansionTile(
          title: Text('Books'),
          children: [
            ListTile(title: Text('The DaVinci Code')),
            ListTile(title: Text('A thousand splendid suns')),
            ListTile(title: Text('Gone Girl')),
            ListTile(title: Text('The Origin')),
          ],
        ),
        ExpansionTile(
          title: Text('Movies'),
          children: [
            ListTile(title: Text('Arrival')),
            ListTile(title: Text('Matrix')),
          ],
        ),
      ],
    );
  }


  Widget _buildExpansionPanel() {
    return ListView(
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _panels[index].isExpanded = !isExpanded;
            });
          },
          children: _panels.map<ExpansionPanel>((MyPanel item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue),
                );
              },
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        _controller.previousPage();
                      },
                    ),

                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        _controller.nextPage();
                      },
                    ),
                  ],
                ),
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(height: 250.0, aspectRatio: 1/1),
                    items: imgList.map((item) => Container(
                      child: Center(
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                    )).toList(),
                  ),
                ],


              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ],
    );
  }
}


class MyPanel {
  String headerValue;
  String expandedValue;
  bool isExpanded;

  MyPanel({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
  });
}

final List<MyPanel> _panels = <MyPanel>[
  MyPanel(
    headerValue: 'Image',
    expandedValue: 'This is the first panel',
  ),
  MyPanel(
    headerValue: 'Carousel',
    expandedValue: 'This is the second panel',
  ),
];
