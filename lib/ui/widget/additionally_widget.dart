import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zakaz/models/additionally.dart';

class AdditionallyWidget extends StatefulWidget {
  final String imageUrl;
  final int index;
  final Function sumChanged;

  AdditionallyWidget({Key key, this.imageUrl, this.index, this.sumChanged})
      : super(key: key);

  @override
  _AdditionallyWidgetState createState() =>
      _AdditionallyWidgetState(sumChanged);
}

class _AdditionallyWidgetState extends State<AdditionallyWidget> {
  int sum = 0;
  num priceSum = 0;
  final Function sumChanged;

  _AdditionallyWidgetState(this.sumChanged);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void sumCount() {
      sum = 0;
      priceSum = 0;
      for (Additionally ad in additionallyList) {
        sum += ad.count;
        priceSum += ad.count * ad.price;
      }
      sumChanged(sum, priceSum);
    }

    return Container(
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            width: size.width * 0.35,
            child: Text(
              additionallyList[widget.index].name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove, color: Colors.yellow),
                        onPressed: () {
                          setState(() {
                            if (additionallyList[widget.index].count > 0) {
                              additionallyList[widget.index].count--;
                              sumCount();
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(additionallyList[widget.index].count.toString()),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (additionallyList[widget.index].count < 20) {
                              additionallyList[widget.index].count++;
                              sumCount();
                              print(sum);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text("+${additionallyList[widget.index].price} р."),
          ),
        ],
      ),
    );
  }
}
