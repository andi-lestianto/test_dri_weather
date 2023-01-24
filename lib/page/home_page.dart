import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';
import 'package:test_dri_weather/page/weatherdetail_page.dart';
import 'package:test_dri_weather/services/home_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HomeServices>(context, listen: false).fetchApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: 'F9F9F9'.toColor(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    '6B56FD'.toColor(),
                    '59A0F1'.toColor(),
                  ],
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INFO CUACA',
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Pilih Lokasi Anda',
                      style: GoogleFonts.poppins(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Consumer<HomeServices>(
                  builder: (context, HomeServices value, child) => Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.getDataWilayah.length,
                            itemBuilder: ((context, index) => GestureDetector(
                                  onTap: () {
                                    Get.to(WeatherDetailPage(
                                      id: value.getDataWilayah[index].id
                                          .toString(),
                                      wilayah: value.getDataWilayah[index],
                                    ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, right: 20, left: 20),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.getDataWilayah[index]
                                                  .kecamatan
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(value
                                                    .getDataWilayah[index].kota
                                                    .toString()),
                                                const Text(', '),
                                                Text(value.getDataWilayah[index]
                                                    .propinsi
                                                    .toString()),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                              'assets/location.png'),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                      ))
            ],
          ),
        ));
  }
}
