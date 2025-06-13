/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.mycompany.rentalkendaraan.model.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idTransaksi = request.getParameter("id");
        String format = request.getParameter("format"); // "pdf" atau null

        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT t.*, a.username AS nama_admin, k.model, k.plat_nomor, k.id_kendaraan, t.nama_pelanggan " +
                "FROM transaksi t " +
                "JOIN admin a ON t.id_admin = a.id " +
                "JOIN kendaraan k ON t.id_kendaraan = k.id_kendaraan " +
                "WHERE t.id_transaksi = ?"
            );
            stmt.setString(1, idTransaksi);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                if ("pdf".equalsIgnoreCase(format)) {
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "inline; filename=invoice_" + idTransaksi + ".pdf");

                    Document document = new Document();
                    PdfWriter.getInstance(document, response.getOutputStream());
                    document.open();

                    // Font
                    Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
                    Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
                    Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);

                    // Logo
                    try {
                        String logoPath = getServletContext().getRealPath("/images/logo.png");
                        Image logo = Image.getInstance(logoPath);
                        logo.scaleToFit(200, 200);
                        logo.setAlignment(Image.ALIGN_LEFT);
                        document.add(logo);
                    } catch (Exception e) {
                        // Lewati jika logo gagal dimuat
                    }

                    // Judul
                    Paragraph title = new Paragraph("INVOICE", headerFont);
                    title.setAlignment(Element.ALIGN_CENTER);
                    document.add(title);
                    document.add(Chunk.NEWLINE);

                    // Info transaksi
                    PdfPTable infoTable = new PdfPTable(2);
                    infoTable.setWidthPercentage(100);
                    infoTable.addCell(getCell("No Invoice :", PdfPCell.ALIGN_LEFT, boldFont));
                    infoTable.addCell(getCell("ID-" + idTransaksi, PdfPCell.ALIGN_LEFT, normalFont));
                    infoTable.addCell(getCell("Tanggal :", PdfPCell.ALIGN_LEFT, boldFont));
                    infoTable.addCell(getCell(LocalDateTime.now().toLocalDate().toString(), PdfPCell.ALIGN_LEFT, normalFont));
                    infoTable.addCell(getCell("Pelanggan :", PdfPCell.ALIGN_LEFT, boldFont));
                    infoTable.addCell(getCell(rs.getString("nama_pelanggan"), PdfPCell.ALIGN_LEFT, normalFont));
                    infoTable.addCell(getCell("Jaminan :", PdfPCell.ALIGN_LEFT, boldFont));
                    infoTable.addCell(getCell("-", PdfPCell.ALIGN_LEFT, normalFont));
                    document.add(infoTable);
                    document.add(Chunk.NEWLINE);

                    // Tabel kendaraan
                    PdfPTable kendaraanTable = new PdfPTable(new float[]{3, 4, 4, 4, 4, 4});
                    kendaraanTable.setWidthPercentage(100);
                    kendaraanTable.addCell(getCell("Kendraan", PdfPCell.ALIGN_CENTER, boldFont));
                    kendaraanTable.addCell(getCell("No Polisi", PdfPCell.ALIGN_CENTER, boldFont));
                    kendaraanTable.addCell(getCell("Biaya Sewa", PdfPCell.ALIGN_CENTER, boldFont));
                    kendaraanTable.addCell(getCell("Tanggal Pinjam", PdfPCell.ALIGN_CENTER, boldFont));
                    kendaraanTable.addCell(getCell("Tanggal Kembali", PdfPCell.ALIGN_CENTER, boldFont));
                    kendaraanTable.addCell(getCell("Pilihan", PdfPCell.ALIGN_CENTER, boldFont));

                    kendaraanTable.addCell(getCell(rs.getString("model"), PdfPCell.ALIGN_CENTER));
                    kendaraanTable.addCell(getCell(rs.getString("plat_nomor"), PdfPCell.ALIGN_CENTER));
                    kendaraanTable.addCell(getCell("Rp. " + formatRupiah(rs.getInt("total_harga")), PdfPCell.ALIGN_CENTER));
                    kendaraanTable.addCell(getCell(rs.getDate("tanggal_pinjam").toString(), PdfPCell.ALIGN_CENTER));
                    kendaraanTable.addCell(getCell(rs.getDate("tanggal_kembali").toString(), PdfPCell.ALIGN_CENTER));
                    kendaraanTable.addCell(getCell("Diambil di garasi", PdfPCell.ALIGN_CENTER));
                    document.add(kendaraanTable);
                    document.add(Chunk.NEWLINE);

                    // Tabel biaya
                    PdfPTable biayaTable = new PdfPTable(2);
                    biayaTable.setWidthPercentage(50);
                    biayaTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    biayaTable.addCell(getCell("Total Biaya Sewa", PdfPCell.ALIGN_LEFT, boldFont));
                    biayaTable.addCell(getCell(": Rp. " + formatRupiah(rs.getInt("total_harga")), PdfPCell.ALIGN_RIGHT));
                    biayaTable.addCell(getCell("Total Biaya Supir", PdfPCell.ALIGN_LEFT, boldFont));
                    biayaTable.addCell(getCell(": 0", PdfPCell.ALIGN_RIGHT));
                    biayaTable.addCell(getCell("Total Biaya BBM", PdfPCell.ALIGN_LEFT, boldFont));
                    biayaTable.addCell(getCell(": 0", PdfPCell.ALIGN_RIGHT));
                    biayaTable.addCell(getCell("Total Biaya Tarif", PdfPCell.ALIGN_LEFT, boldFont));
                    biayaTable.addCell(getCell(": Rp. " + formatRupiah(rs.getInt("total_harga")), PdfPCell.ALIGN_RIGHT));
                    document.add(biayaTable);
                    document.add(Chunk.NEWLINE);

                    // Admin dan waktu cetak
                    Paragraph footer = new Paragraph("Dicetak oleh: " + rs.getString("nama_admin")
                            + " pada " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss")),
                            normalFont);
                    footer.setAlignment(Element.ALIGN_RIGHT);
                    document.add(footer);

                    document.close();
                } else {
                    // Forward ke JSP jika bukan PDF
                    request.setAttribute("transaksi", rs);
                    request.getRequestDispatcher("invoice.jsp").forward(request, response);
                }
            } else {
                response.getWriter().println("Transaksi tidak ditemukan.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal memproses invoice: " + e.getMessage());
        }
    }

    // Helper method untuk membuat sel tabel
    private PdfPCell getCell(String text, int alignment) {
        return getCell(text, alignment, FontFactory.getFont(FontFactory.HELVETICA, 12));
    }

    private PdfPCell getCell(String text, int alignment, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setPadding(5);
        cell.setHorizontalAlignment(alignment);
        cell.setBorder(Rectangle.BOTTOM);
        return cell;
    }

    // Format angka menjadi format rupiah sederhana
    private String formatRupiah(int amount) {
        return String.format("%,d", amount).replace(",", ".");
    }
}

