import 'package:flutter/material.dart';

class CustomItemCart extends StatelessWidget {
  const CustomItemCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(
            "https://m.media-amazon.com/images/I/61NRYreJ2cL.AC_UL320.jpg",
          ),
        ),
        SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Macbook Pro 15" 2019 - Intel core i7 - Grey',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$910',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '\$1029',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, size: 28),
                            onPressed: () {},
                          ),
                          Text(
                            '7',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, size: 28),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(width: 35),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  Text(
                    "x1",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),

      ]
    );
  }
}