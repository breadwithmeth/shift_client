import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shift_client/api.dart';
import 'package:intl/intl.dart';

class attendPage extends StatefulWidget {
  const attendPage({super.key, required this.qr});
  final String qr;
  @override
  State<attendPage> createState() => _attendPageState();
}

class _attendPageState extends State<attendPage> {
  Map _shfit = {};
  bool isButtonPressed = false;
  DateTime? start_at = null;
  DateTime? end_at = null;
  DateTime? started_at = null;
  DateTime? ended_at = null;
  // String start_at_s = "";
  // String started_at_s = "";
  // String started_at_s = "";
  // String started_at_s = "";
  Future<void> _enroll() async {
    Map shift = await enroll(widget.qr!);
    setState(() {
      _shfit = shift;
      start_at =
          shift["start_at"] != null ? DateTime.parse(shift["start_at"]) : null;
      end_at = shift["end_at"] != null ? DateTime.parse(shift["end_at"]) : null;
      started_at = shift["started_at"] != null
          ? DateTime.parse(shift["started_at"])
          : null;
      ended_at =
          shift["ended_at"] != null ? DateTime.parse(shift["ended_at"]) : null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _enroll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade900,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Начало смены в "),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            start_at == null
                                ? "Нет"
                                : DateFormat('HH:mm').format(start_at!),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: ScaleSize.textScaleFactor(context) * 24,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            start_at == null
                                ? "Нет"
                                : DateFormat('dd MMMM , yyyy')
                                    .format(start_at!),
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade900,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Конец смены в "),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            end_at == null
                                ? "Нет"
                                : DateFormat('HH:mm').format(end_at!),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: ScaleSize.textScaleFactor(context) * 24,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            end_at == null
                                ? "Нет"
                                : DateFormat('dd MMMM , yyyy').format(end_at!),
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade900,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Смена начата в "),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            started_at == null
                                ? "Нет"
                                : DateFormat('HH:mm').format(started_at!),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: ScaleSize.textScaleFactor(context) * 24,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            started_at == null
                                ? "Нет"
                                : DateFormat('dd MMMM , yyyy')
                                    .format(started_at!),
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey.shade900,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Смена закончена в  "),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            ended_at == null
                                ? "Нет"
                                : DateFormat('HH:mm').format(ended_at!),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: ScaleSize.textScaleFactor(context) * 24,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            ended_at == null
                                ? "Нет"
                                : DateFormat('dd MMMM , yyyy')
                                    .format(ended_at!),
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),

            Text(widget.qr),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Смена номер #"), Text(_shfit["shift_id"] ?? "")],
            ),

            isButtonPressed
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            attend(_shfit["operation"], _shfit["shift_id"])
                                .then((value) {
                              if (value != null) {
                                Map shift = value;
                                setState(() {
                                  isButtonPressed = true;
                                  _shfit = shift;
                                  start_at = shift["start_at"] != null
                                      ? DateTime.parse(shift["start_at"])
                                      : null;
                                  end_at = shift["end_at"] != null
                                      ? DateTime.parse(shift["end_at"])
                                      : null;
                                  started_at = shift["started_at"] != null
                                      ? DateTime.parse(shift["started_at"])
                                      : null;
                                  ended_at = shift["ended_at"] != null
                                      ? DateTime.parse(shift["ended_at"])
                                      : null;
                                });
                              }
                            });
                          },
                          child: _shfit["operation"] == "OPEN"
                              ? Text("Открыть смену")
                              : Text("Закрыть смену")),
                              SizedBox(height: 100,)
                    ],
                  )

            // Row(
            //   children: [Text("Смена номер #"), Text(_shfit["shift_id"] ?? "")],
            // ),

            // Row(
            //   children: [Text("Смена номер #"), Text(_shfit["shift_id"] ?? "")],
            // ),

            // Row(
            //   children: [Text("Смена номер #"), Text(_shfit["shift_id"] ?? "")],
            // ),

            // Text("Начало " + _shfit["start_at"] ?? ""),
            // Text("Конец " + _shfit["end_at"] ?? ""),
            // Text("Смена начата в " + _shfit["started_at"] ?? ""),
            // Text("Смена закрыта в " + _shfit["ended_at"] ?? ""),
          ],
        ),
      )),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
