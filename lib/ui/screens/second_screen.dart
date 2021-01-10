import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zakaz/ui/widget/additionally_widget.dart';

class SecondScreen extends StatefulWidget {
  final String imageUrl;
  final String number;

  const SecondScreen({Key key, this.imageUrl, this.number}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  int sumCount = 0;
  int sumPrice = 0;

  Widget _loader(BuildContext context, String url) {
    return Container(
      height: 250,
      width: double.infinity,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    print(error);
    return Container(
      height: 250,
      width: double.infinity,
      child: Icon(Icons.error),
    );
  }

  void getSums(sum, sumPrice) {
    setState(() {
      sumCount = sum;
      this.sumPrice = sumPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4.0 / 3.0,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder: _loader,
              errorWidget: _error,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "Произвольный текст как заголовок",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
                color: Colors.grey.withOpacity(0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Дополнительно", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: AdditionallyWidget(
                            sumChanged: getSums,
                            imageUrl: widget.imageUrl,
                            index: index,
                          ),
                        ),
                        itemCount: int.parse(widget.number),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              color: Colors.blue[200],
              child: Column(
                children: [
                  Container(
                    decoration: DottedDecoration(
                        shape: Shape.line,
                        linePosition: LinePosition.top,
                        color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                    child: Row(
                      children: [
                        Text(
                          "Дополнительно",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text("x$sumCount"),
                        SizedBox(width: 5),
                        Text("$sumPrice р."),
                      ],
                    ),
                  ),
                  Container(
                    decoration: DottedDecoration(
                      shape: Shape.line,
                      linePosition: LinePosition.bottom,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
