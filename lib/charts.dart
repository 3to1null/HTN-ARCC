import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RatesChart extends StatefulWidget {
  @override
  _RatesChartState createState() => _RatesChartState();
}

class _RatesChartState extends State<RatesChart> {
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Color(0xFF00FF9C), // lighter green
      Color(0xFF1CD0A2), // dark green
    ];
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 10.0, left: 0.0, top: 24, bottom: 12),
          child: FlChart(
            chart: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawHorizontalGrid: true,
                  getDrawingVerticalGridLine: (value) {
                    return const FlLine(
                      color: Colors.black12,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingHorizontalGridLine: (value) {
                    return const FlLine(
                      color: Colors.black12,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(.85), fontSize: 16),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 2:
                          return 'JAN';
                        case 5:
                          return 'FEB';
                        case 8:
                          return 'MAR';
                      }

                      return '';
                    },
                    margin: 8,
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    textStyle: TextStyle(
                      color: Colors.black.withOpacity(.85),
                      fontSize: 15,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 1:
                          return '0';
                        case 3:
                          return '15';
                        case 5:
                          return '30';
                      }
                      return '';
                    },
                    reservedSize: 28,
                    margin: 12,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                      left: BorderSide(color: Colors.black.withOpacity(0.85), width: 2),
                      bottom:
                          BorderSide(color: Colors.black.withOpacity(0.85), width: 2),
                )),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 3.1),
                      FlSpot(8, 4),
                      FlSpot(9.5, 3),
                      FlSpot(11, 4),
                    ],
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 2,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BelowBarData(
                      show: true,
                      colors: gradientColors
                          .map((color) => color.withOpacity(0.7))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
