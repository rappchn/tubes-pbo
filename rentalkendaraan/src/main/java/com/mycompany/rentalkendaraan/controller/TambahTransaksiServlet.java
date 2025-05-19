/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentalkendaraan.controller;

import com.mycompany.rentalkendaraan.model.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;


/**
 *
 * @author Rappchn
 */
@WebServlet("/tambahTransaksi")
public class TambahTransaksiServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idTransaksi = request.getParameter("idTransaksi");
            String namaPelanggan = request.getParameter("namaPelanggan");
            String idKendaraan = request.getParameter("idKendaraan");
            String idAdminParam = request.getParameter("idAdmin");

            String idAdminStr = request.getParameter("idAdmin");
            System.out.println("Dari form idAdmin: " + idAdminStr); // Tambah ini
            if (idAdminStr == null || idAdminStr.isEmpty()) {
                throw new Exception("ID Admin tidak ditemukan di form");
            }
            int idAdmin = Integer.parseInt(idAdminParam);

            LocalDate tanggalPinjam = LocalDate.parse(request.getParameter("tanggalPinjam"));
            LocalDate tanggalKembali = LocalDate.parse(request.getParameter("tanggalKembali"));

            try (Connection conn = DatabaseConnection.getConnection()) {
                // Ambil harga sewa kendaraan
                int hargaPerHari = 0;
                PreparedStatement stmtHarga = conn.prepareStatement("SELECT harga_sewa_per_hari FROM kendaraan WHERE id_kendaraan = ?");
                stmtHarga.setString(1, idKendaraan);
                ResultSet rsHarga = stmtHarga.executeQuery();
                if (rsHarga.next()) {
                    hargaPerHari = rsHarga.getInt("harga_sewa_per_hari");
                }

                // Hitung jumlah hari & total harga
                long lamaPinjam = ChronoUnit.DAYS.between(tanggalPinjam, tanggalKembali);
                if (lamaPinjam <= 0) lamaPinjam = 1;
                int totalHarga = (int) lamaPinjam * hargaPerHari;

                // Simpan transaksi
                PreparedStatement stmt = conn.prepareStatement(
                        "INSERT INTO transaksi (id_transaksi, nama_pelanggan, id_kendaraan, id_admin, tanggal_pinjam, tanggal_kembali, total_harga, status) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, 'On Going')");
                stmt.setString(1, idTransaksi);
                stmt.setString(2, namaPelanggan);
                stmt.setString(3, idKendaraan);
                stmt.setInt(4, idAdmin);
                stmt.setDate(5, Date.valueOf(tanggalPinjam));
                stmt.setDate(6, Date.valueOf(tanggalKembali));
                stmt.setInt(7, totalHarga);

                stmt.executeUpdate();

                response.sendRedirect("dashboard");

            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal menambahkan transaksi: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT id_kendaraan, model, tahun, plat_nomor FROM kendaraan WHERE tersedia = 1");
            ResultSet rs = stmt.executeQuery();

            List<Map<String, String>> kendaraanList = new ArrayList<>();
            while (rs.next()) {
                Map<String, String> data = new HashMap<>();
                data.put("id_kendaraan", rs.getString("id_kendaraan"));
                data.put("model", rs.getString("model"));
                data.put("tahun", rs.getString("tahun"));
                data.put("plat_nomor", rs.getString("plat_nomor"));
                kendaraanList.add(data);
            }

            request.setAttribute("kendaraanList", kendaraanList);
            request.getRequestDispatcher("transaksi.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Gagal load form: " + e.getMessage());
        }
    }
}
