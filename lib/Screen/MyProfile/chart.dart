import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWallet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color(0xFFfbbf14),
      Color(0xFFea443a),
//      Color(0xFF009688),
//      Color(0xFF215B8E),
    ];
    return AspectRatio(
      aspectRatio: 1.80,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            //color: Color(0xff232d37)
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 10, bottom: 10),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: false,
//                  getDrawingVerticalGridLine: (value) {
//                    return const FlLine(
//                      color: Color(0xff37434d),
//                      strokeWidth:  1,
//                    );
//                  },
//                  getDrawingHorizontalGridLine: (value) {
//                    return const FlLine(
//                      color: Color(0xff37434d),
//                      strokeWidth: 1,
//                    );
//                  },
              ),
              // titlesData: FlTitlesData(
              //   show: true,
              //   bottomTitles: SideTitles(
              //     showTitles: true,
              //     reservedSize: 20,
              //     textStyle: TextStyle(
              //         color: const Color(0xff68737d),
              //         fontWeight: FontWeight.bold,
              //         fontSize: 14
              //     ),
              //     getTitles: (value) {
              //       switch(value.toInt()) {
              //         case 2: return 'MAR';
              //         case 5: return 'JUN';
              //         case 8: return 'SEP';
              //       }
              //
              //       return '';
              //     },
              //     margin: 8,
              //   ),
              //   leftTitles: SideTitles(
              //     showTitles: true,
              //     textStyle: TextStyle(
              //       color: const Color(0xff67727d),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 14,
              //     ),
              //     getTitles: (value) {
              //       switch(value.toInt()) {
              //         case 1: return '10k';
              //         case 3: return '30k';
              //         case 5: return '50k';
              //       }
              //       return '';
              //     },
              //     reservedSize: 28,
              //     margin: 10,
              //   ),
              // ),
              borderData: FlBorderData(
                  show: false,
                  border: Border.all(color: Color(0xff37434d), width: 1)
              ),
              minX: 0,
              maxX: 11,
              minY: 0,
              maxY: 6,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 3),
                    FlSpot(2, 2),
                    FlSpot(4, 0.5),
                    FlSpot(6, 3.1),
                    FlSpot(8, 2),
                    FlSpot(11, 3.5),
                  ],
                  isCurved: true,
                  // colors: gradientColors,
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    // colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
