import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:test_dri_weather/model/wilayah_model.dart';
import 'package:test_dri_weather/services/weatherdetail_services.dart';
import 'package:flutter/material.dart';

class WeatherDetailPage extends StatefulWidget {
  final Wilayah wilayah;
  final String id;
  const WeatherDetailPage({super.key, required this.id, required this.wilayah});

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void initState() {
    Provider.of<WeatherServices>(context, listen: false)
        .fetchWeatherDetail(id: widget.id);
    Provider.of<WeatherServices>(context, listen: false).setDateNow();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Consumer<WeatherServices>(
                builder: (context, WeatherServices data, child) => (data
                        .getDataWeather.isEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 80),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                '6B56FD'.toColor(),
                                '59A0F1'.toColor(),
                                '8977FD'.toColor(),
                              ],
                            )),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.wilayah.propinsi.toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Colors.white),
                                ),
                                Text(
                                  '${widget.wilayah.kecamatan.toString()}, ${widget.wilayah.kota}',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.getDataWeather[3].tempC
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 70,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16, left: 10),
                                          child: Text('o',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data.getDateNow.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      data.getDataWeather[3].cuaca.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    CachedNetworkImage(
                                        imageUrl:
                                            'https://ibnux.github.io/BMKG-importer/icon/${data.getDataWeather[2].kodeCuaca}.png'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: const Alignment(1, 1),
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Hari ini',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 40,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Besok',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 40,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: data.getDataWeather.length,
                                        itemBuilder:
                                            ((context, index) =>
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 20,
                                                            left: 20),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(data
                                                            .getDataWeather[
                                                                index]
                                                            .jamCuaca
                                                            .toString()
                                                            .substring(11, 16)),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                          child: Image.asset(
                                                            (data
                                                                        .getDataWeather[
                                                                            index]
                                                                        .kodeCuaca ==
                                                                    '1'
                                                                ? 'assets/cerahberawan.png'
                                                                : data.getDataWeather[index]
                                                                            .kodeCuaca ==
                                                                        '2'
                                                                    ? 'assets/cerah.png'
                                                                    : data.getDataWeather[index].kodeCuaca == '3'
                                                                        ? 'assets/berawan.png'
                                                                        : 'assets/hujan.png'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              data
                                                                  .getDataWeather[
                                                                      index]
                                                                  .tempC
                                                                  .toString(),
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20),
                                                            ),
                                                            Text(
                                                              'o',
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ))),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )))));
  }
}
