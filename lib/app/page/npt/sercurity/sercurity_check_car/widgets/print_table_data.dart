import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(image, font) => pw.Container(
      height: 559,
      width: 794,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 25.00),
        child: pw.Column(children: [
          pw.Stack(
            children: [
              pw.Container(
                width: 744,
                height: 50,
                child: pw.Center(
                  child: pw.Text(
                    "PHIẾU XÁC NHẬN XE RA, VÀO CỔNG",
                    style: pw.TextStyle(
                      font: font,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                left: 0,
                bottom: 0,
                top: 0,
                child: pw.Image(
                  image,
                  width: 50,
                  height: 30,
                ),
              )
            ],
          ),
          pw.Container(
            height: 25,
            width: 744,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "ĐƠN VỊ : ICD60 .......",
                  style: pw.TextStyle(font: font),
                ),
                pw.Text(
                  "SỐ XE : 51H 374748",
                  style: pw.TextStyle(font: font),
                ),
                pw.Text(
                  "ROMOOC : ............... ",
                  style: pw.TextStyle(font: font),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            height: 94,
            width: 707,
            padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      "NGÀY VÀO CỔNG: 9:28 24/06/2023",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      "Ghi chú: ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ]),
                pw.Text(
                  "SỐ CONT: SUDUWWWW",
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                pw.Text(
                  "SỐ SEAL: 123123/321321",
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "HÀNG VÀO: CO ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Text(
                      "KHOÁ VÀO: CO ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            height: 94,
            width: 707,
            padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      "NGÀY RA CỔNG: ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      "Ghi chú: ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ]),
                pw.Text(
                  "SỐ CONT: ",
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                pw.Text(
                  "SỐ SEAL: ",
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 10,
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "HÀNG RA:  ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Text(
                      "KHOÁ RA:  ",
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            width: 744,
            height: 50,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 150,
                  child: pw.Column(children: [
                    pw.Text(
                      "XÁC NHẬN CỦA TÀI XẾ",
                      style: pw.TextStyle(font: font),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "NGUYỄN MẠNH TIẾN",
                      style: pw.TextStyle(font: font),
                    )
                  ]),
                ),
                pw.Container(
                  width: 150,
                  child: pw.Column(children: [
                    pw.Text(
                      "XÁC NHẬN CỦA BẢO VỆ",
                      style: pw.TextStyle(font: font),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "BẢO VỆ KHO 6",
                      style: pw.TextStyle(font: font),
                    )
                  ]),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 744,
            height: 145,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("YÊU CẦU TÀI XẾ/ CHỦ HÀNG",
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 12,
                      color: PdfColors.black,
                    )),
                pw.Text("1. ĐỀ NGHỊ TÀI XẾ CHO XE VÀO BÃI CHỜ",
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 6,
                      color: PdfColors.black,
                    )),
                pw.Text(
                  "2. TRƯỢC KHI NHẬP KHO VÀ SAU KHI XUẤT KHO. CHỦ XE VÀ TÀI XẾ TỰ BẢO QUẢN HÀNG TRÊN XE CỦA MÌNH TẠI KHO",
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 6,
                    color: PdfColors.black,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
                pw.Text(
                    "3. TRÌNH PHIẾU NÀY CÙNG VỚI CHỨNG TỪ NHẬP HÀNG CHO VP KHO SAU KHI HOÀN TẤT CÁC THỦ TỤC HẢI QUAN",
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 6,
                      color: PdfColors.black,
                    )),
                pw.Text("4. TÀI XẾ NỘP LẠI PHIẾU KHI RA CỔNG",
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 6,
                      color: PdfColors.black,
                    )),
                pw.Text(
                    "5. ĐỐI VỚI HÀNG XUẤT/NHẬP CỦA APPL, VUI LÒNG GIAO TẠI KHO 6 ",
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 6,
                      color: PdfColors.black,
                    )),
                pw.Text(
                    "Note: Chỉ cho phép Container/Xe trong khi vực IDC Tân Vạn tối đa không quá 24h sau khi vào cổng chính(ngoại trừ vào kho Damco). Nếu trường hợp lưu Container/xe quá 24h thì phải nộp lệ lưu theo bằng giá hiện hành của TBS ",
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 8,
                      color: PdfColors.black,
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
